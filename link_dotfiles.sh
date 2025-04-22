#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ARCHIVE_OLD=true

if [[ "$1" == "--no-archive" ]]; then
    ARCHIVE_OLD=false
fi

if [ "$ARCHIVE_OLD" = true ]; then
    ARCHIVE_DIR="$SCRIPT_DIR/archive"
    mkdir -p "$ARCHIVE_DIR"
fi

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

FILES=(
    ".bashrc"
    ".vimrc"
    ".bash_profile"
    ".dircolors"
    ".tmux.conf"
    ".vim"
    ".bashrc.d"
)

for TARGET in "${FILES[@]}"; do
    BASENAME="${TARGET#.}"
    SOURCE="$SCRIPT_DIR/$BASENAME"
    DEST="$HOME/$TARGET"

    if [ -e "$DEST" ] || [ -L "$DEST" ]; then
        if [ "$ARCHIVE_OLD" = true ]; then
            mv "$DEST" "$ARCHIVE_DIR/$(basename "$TARGET")_$TIMESTAMP"
            echo "[INFO] Archived $DEST to $ARCHIVE_DIR"
        else
            rm -rf "$DEST"
            echo "[INFO] Removed $DEST"
        fi
    fi

    ln -s "$SOURCE" "$DEST"
    echo "[INFO] Linked $SOURCE -> $DEST"
done

if [ -f "$HOME/.bash_profile" ]; then
    source "$HOME/.bash_profile"
fi

echo "[DONE] Dotfiles setup complete."

