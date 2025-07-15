#!/usr/bin/env bash

# change_artist demo: change artist name
# license: public domain, no warranty

set -e

# check dependencies
for dep in tagutil jq; do
    command -v $dep || {
        echo "please install $dep"
        exit 1
    }
done

dryrun=false
if [[ "$1" == "-n" ]]; then
    dryrun=true
    shift
fi

# Current and new artist names
current_artist="$1"
new_artist="$2"
shift 2

if [[ -z "$current_artist" || -z "$new_artist" ]]; then
    echo "Usage: $0 [-n] 'Current Artist Name' 'New Artist Name' file1 [file2 ...]"
    exit 1
fi

for file in "$@"; do
    echo "file: $file"

    # read current artist
    artist=$(tagutil -F json print "$file" | jq -r ".[1].artist")
    echo "current artist: $artist"

    # check if the current artist matches
    if [[ "$artist" != "$current_artist" ]]; then
        echo "current artist does not match. Skipping."
        continue
    fi

    echo "changing artist from '$current_artist' to '$new_artist'"

    drycmd=()
    $dryrun && drycmd=(printf "%q ")

    # make backup
    #[ -e "$file.bak" ] || cp -v "$file" "$file.bak"

    # write new artist name
    ${drycmd[@]} tagutil set:artist="$new_artist" "$file"

done

# find . -type f -name "*.mp3" -exec sh ~/scripts/change_artist.sh "Novelists" "NOVELISTS" {} +
