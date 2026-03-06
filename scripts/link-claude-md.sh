#!/bin/bash
# Usage: link-claude-md.sh <destination-dir>
# Example: link-claude-md.sh ~/recruiter

if [ -z "$1" ]; then
  echo "Usage: $(basename "$0") <destination-dir>"
  exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
src="$DOTFILES_DIR/claude/CLAUDE.md"
dest="${1%/}/CLAUDE.md"

ln -sf "$src" "$dest"
echo "Linked $dest -> $src"
