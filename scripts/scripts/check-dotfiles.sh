#!/usr/bin/env bash

function get_local_changes {
  DIR="$(cd "$(dirname "$0")" && pwd)"
  # echo "Script location: ${DIR}"
  cd $DIR
  if (git status | grep -q "nothing to commit"); then
    git pull
  else
    # echo "$(git status)"
    echo "ERROR: dotfiles repo has unsaved changes"
  fi
}

# send_notification
msgId="991050"
status=$(get_local_changes)
echo "test $status"
dunstify -u low -r "$msgId" " ${status}"

# vim: set ts=2 sw=2:
