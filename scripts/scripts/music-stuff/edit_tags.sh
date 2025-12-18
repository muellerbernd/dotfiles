#!/usr/bin/env bash

# Check if the directory is provided

if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/music/directory"
    exit 1
fi

MUSIC_DIR="$1"

# Process MP3s safely; check for missing artist OR missing title

find "$MUSIC_DIR" -type f -name "*.mp3" -print0 | while IFS= read -r -d '' file; do
    ARTIST_MISSING=$(tagutil "$file" 2>/dev/null | grep -E '^- artist: ')
    TITLE_MISSING=$(tagutil "$file" 2>/dev/null | grep -E '^- title: ')

    if [ -z "$ARTIST_MISSING" ] || [ -z "$TITLE_MISSING" ]; then
        echo "Needs tag edit: $file"
        # Interactive approach:
        tagutil edit "$file"

        # Non-interactive example (uncomment and customize):
        # ARTIST_NAME="Unknown Artist"
        # TITLE_NAME="Unknown Title"
        # tagutil set:artist="$ARTIST_NAME" "$file"
        # tagutil set:title="$TITLE_NAME" "$file"
        # echo "Set artist '$ARTIST_NAME' and title '$TITLE_NAME' for: $file"
    fi
done
