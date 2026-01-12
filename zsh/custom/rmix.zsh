# -----------------------------------------------------------------------------
# rmix: Repomix Git Wrapper - Pack git changes smartly
# -----------------------------------------------------------------------------
# PURPOSE:
#   Automatically detects changed files (git status) and pipes them to repomix.
#   Solves the issue of handling relative paths when running repomix in subdirectories.
#
# FEATURES:
#   1. Flexible Context: Works on current dir (.) or specific sub-folders (e.g., rmix client).
#   2. Smart Output: Output file is always saved in the CURRENT execution path.
#   3. Git Modes:
#      - Default: Packs All changes (Modified + Untracked + Staged).
#      - --staged: Packs only files added to staging area.
#   4. Filtering: Automatically excludes deleted files and respects .repomixignore.
# -----------------------------------------------------------------------------

rmix() {
  # --- HELP HANDLER ---
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    cat <<EOF
Usage: rmix [target_folder] [options]

Description:
  Smart wrapper for repomix that packs git changes (staged, modified, untracked).

Options:
  --staged        Only pack staged files (files added via 'git add').
  -o, --output    Specify output file path (always saved relative to current directory).
  -h, --help      Show this help message.

Examples:
  rmix                          # Pack all changes in current folder
  rmix client -o changes.xml    # Pack changes in 'client' folder to 'changes.xml'
  rmix client --staged          # Pack only staged files in 'client' folder
EOF
    return 0
  fi

  # --- MAIN LOGIC ---
  local dir="."
  local mode="all"
  local repomix_args=()
  local current_pwd="$PWD" # Save current path to resolve output file later

  # 1. Handle first argument: Target Folder (if not a flag)
  if [[ $# -gt 0 && "$1" != -* ]]; then
    dir="$1"
    shift
  fi

  # 2. Parse remaining arguments
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --staged)
        mode="staged"
        shift
        ;;
      --output|-o)
        # Handle output path to ensure it saves in the caller's directory
        shift
        local out_file="$1"
        # If path is relative, prepend current PWD
        if [[ "$out_file" != /* ]]; then
            out_file="$current_pwd/$out_file"
        fi
        repomix_args+=("--output" "$out_file")
        shift
        ;;
      *)
        # Pass other flags to repomix (e.g., --style, --token-count)
        repomix_args+=("$1")
        shift
        ;;
    esac
  done

  # Resolve absolute path for the target code directory
  local target_path
  target_path="$(cd "$dir" 2>/dev/null && pwd)" || { echo "rmix: directory not found: $dir"; return 1; }

  # Run in subshell to avoid changing the current shell's directory
  (
    cd "$target_path" || return

    local files=""
    
    # 3. Logic to retrieve changed files
    if [[ "$mode" == "staged" ]]; then
        # Get files in Staging Area
        # --diff-filter=ACMR: Added, Copied, Modified, Renamed (Excludes Deleted)
        files="$(git diff --name-only --cached --diff-filter=ACMR)"
    else 
        # Default: Modified + Staged (HEAD diff) + Untracked (ls-files)
        local tracked_changes
        local untracked_changes
        
        tracked_changes="$(git diff --name-only HEAD --diff-filter=ACMR)"
        untracked_changes="$(git ls-files -o --exclude-standard)"
        
        files="$tracked_changes"$'\n'"$untracked_changes"
    fi

    # Remove empty lines
    files="$(echo "$files" | grep -v '^$')"

    if [[ -z "$files" ]]; then
      echo "rmix: No changed files found in $(basename "$target_path") ($mode mode)"
      return 1
    fi

    # 4. Apply additional ignoring from .repomixignore if exists
    if [[ -f ".repomixignore" ]]; then
       # Fallback filter for paths containing .git/
       files="$(echo "$files" | grep -vF '.git/')"
    fi

    echo "📦 Packing changes in $(basename "$target_path") [Mode: $mode]..."
    
    # Pipe file list to repomix
    echo "$files" | repomix --stdin "${repomix_args[@]}"
  )
}
