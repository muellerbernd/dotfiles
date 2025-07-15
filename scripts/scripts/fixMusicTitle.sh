#! /usr/bin/env bash
# tagutil demo: fix title
# license: public domain, no warranty

set -e

# check dependencies
for dep in tagutil jq
do
  command -v $dep || { echo please install $dep; exit 1; }
done

dryrun=false
if [[ "$1" == "-n" ]]
then
  dryrun=true
  shift
fi

for file in "$@"
do

  echo "file: $file"

  # read title
  title=$(tagutil -F json print "$file" | jq -r ".[0].title")
  title1="$title" # copy
  echo "title 1: $title"

  # fix title
  title=$(echo $title) # collapse multiple whitespaces
  title=$(echo "$title" | sed 's/ (original version)$//i') # remove suffix
  title=$(echo "$title" | sed 's/ (album version)$//i') # remove suffix
  title=$(echo "$title" | sed 's/ (official video)$//i') # remove suffix

  if [[ "$title1" == "$title" ]]
  then
    echo no change
    continue
  fi

  echo "title 2: $title"

  drycmd=()
  $dryrun && drycmd=(printf "%q ")

  # make backup
  #[ -e "$file.bak" ] || cp -v "$file" "$file.bak"

  # write title
  ${drycmd[@]} tagutil set:title="$title" "$file"

done

# find . -type f \( -name "*.mp3" -o -name "*.flac" \) -exec sh ~/scripts/fixMusicTitle.sh {} +
