#!/usr/bin/env bash

# Check if the directory is provided

if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/music/directory"
    exit 1
fi

# Directory containing music files

MUSIC_DIR="$1"

# Find files without an artist tag

find "$MUSIC_DIR" -type f -name "*.mp3" | while read -r file; do
    if [ -z "$(tagutil "$file" 2>/dev/null | grep 'artist: ')" ]; then
        echo "File: $file"
        # read -p "Enter artist name for this file: " ARTIST_NAME
        # tagutil set:artist="$ARTIST_NAME" "$file"
        # echo "Set artist '$ARTIST_NAME' for: $file"
        tagutil edit "$file"
    fi
done
