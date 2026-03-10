#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if (($# > 0)); then
  PACKAGES=("$@")
else
  PACKAGES=(aerospace nvim opencode wezterm zsh)
fi

INSTALL_OPENCODE_GITIGNORE=false
for package in "${PACKAGES[@]}"; do
  if [[ "$package" == "opencode" ]]; then
    INSTALL_OPENCODE_GITIGNORE=true
    break
  fi
done

if ! command -v stow >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    echo "stow not found; installing with Homebrew..."
    brew install stow
  else
    echo "stow is required but Homebrew is not available. Install stow first, then rerun this script." >&2
    exit 1
  fi
fi

for package in "${PACKAGES[@]}"; do
  if [[ ! -d "$REPO_DIR/$package" ]]; then
    echo "Unknown package: $package" >&2
    exit 1
  fi
done

for package in "${PACKAGES[@]}"; do
  echo "==> stowing $package"
  stow --restow --dir "$REPO_DIR" --target "$HOME" "$package"
done

if [[ "$INSTALL_OPENCODE_GITIGNORE" == true ]] && [[ -d "$HOME/.config/opencode" ]] && [[ ! -L "$HOME/.config/opencode" ]]; then
  ln -snf "$REPO_DIR/opencode/.config/opencode/.gitignore" "$HOME/.config/opencode/.gitignore"
fi

echo "Done. Restart apps that read these configs if needed."
