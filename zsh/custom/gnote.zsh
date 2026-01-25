# -----------------------------------------------------------------------------
# gnote: Git Release Notes Generator
# -----------------------------------------------------------------------------
# PURPOSE:
#   Parses git log history and generates a formatted changelog based on
#   Conventional Commits specification.
#
# FEATURES:
#   1. Grouping: Automatically groups commits into "Features", "Bug Fixes",
#      and "Other Changes".
#   2. Detail Oriented: Includes both commit subject and body (if present),
#      formatting them as indented lists.
#   3. Range Support: Supports both strict ranges (tag..tag) and open ranges
#      (tag..HEAD).
#   4. Validation: Verifies git tags/refs before processing to prevent awk errors.
# -----------------------------------------------------------------------------

gnote() {
  # --- HELP HANDLER ---
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    cat << EOF
Usage: gnote <from-tag-or-commit> [to-tag-or-commit]

Description:
  Generate release notes formatted by Conventional Commits groups:
  - Features (feat:)
  - Bug Fixes (fix:)
  - Other Changes (everything else)

Arguments:
  <from-tag>    Starting commit or tag (exclusive).
  [to-tag]      Ending commit or tag (default: HEAD).

Examples:
  gnote v1.2.0           # Show changes from v1.2.0 to HEAD
  gnote v1.2.0 v1.3.0    # Show changes between two specific tags
EOF
    return 0
  fi

  # --- MAIN LOGIC ---

  # 1. Validate Arguments
  if [[ -z "$1" ]]; then
    echo "Error: Missing starting point."
    echo "Try 'gnote -h' for usage."
    return 1
  fi

  # 2. Setup Variables
  local from_ref="$1"
  local to_ref="${2:-HEAD}" # Default to HEAD if second argument is missing
  local range="${from_ref}..${to_ref}"

  # Verify if the git reference exists
  if ! git rev-parse --verify "$from_ref" >/dev/null 2>&1; then
    echo "Error: Reference '$from_ref' not found."
    return 1
  fi

  # 3. Define Internal Helper Functions
  
  # Function to format commits based on type (feat/fix)
  _gnote_format_commits() {
    local type="$1"
    git log "$range" --pretty=format:"<<COMMIT>>%s (%h)%n%b" | \
      awk -v type="$type" '
        /^<<COMMIT>>/ {
          if (commit != "" && index(commit, "<<COMMIT>>" type ":") == 1) {
            gsub(/<<COMMIT>>/, "* ", commit)
            print commit
            if (body != "") print body
          }
          commit = $0
          body = ""
          next
        }
        NF { body = body "  " $0 "\n" }
        END {
          if (commit != "" && index(commit, "<<COMMIT>>" type ":") == 1) {
            gsub(/<<COMMIT>>/, "* ", commit)
            print commit
            if (body != "") print body
          }
        }
      '
  }

  # Function to format all other commits (not feat or fix)
  _gnote_format_other() {
    git log "$range" --pretty=format:"<<COMMIT>>%s (%h)%n%b" | \
      awk '
        /^<<COMMIT>>/ {
          if (commit != "" && index(commit, "<<COMMIT>>feat:") != 1 && index(commit, "<<COMMIT>>fix:") != 1) {
            gsub(/<<COMMIT>>/, "* ", commit)
            print commit
            if (body != "") print body
          }
          commit = $0
          body = ""
          next
        }
        NF { body = body "  " $0 "\n" }
        END {
          if (commit != "" && index(commit, "<<COMMIT>>feat:") != 1 && index(commit, "<<COMMIT>>fix:") != 1) {
            gsub(/<<COMMIT>>/, "* ", commit)
            print commit
            if (body != "") print body
          }
        }
      '
  }

  # 4. Execute and Output
  echo "## Features"
  _gnote_format_commits "feat"

  echo ""
  echo "## Bug Fixes"
  _gnote_format_commits "fix"

  echo ""
  echo "## Other Changes"
  _gnote_format_other
}
