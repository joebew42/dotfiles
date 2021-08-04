#!/usr/bin/env bash

[ $# -eq 0 ] && { echo "Usage: $0 directory-to-watch command-to-run"; exit 1; }

folder_to_watch=$1; shift

if [ ! -d $folder_to_watch ]
then
  echo "The folder ${folder_to_watch} does not exists.";
  exit 1
fi

command_to_run=$@

exclude_files='^\./\.|node_modules|tags'

inotifywait -e create -e delete -e close_write \
            -e moved_from -e moved_to \
            --exclude $exclude_files \
            -m $folder_to_watch -r |
  while read path action filename; do
    echo "${action} triggered on: ${path}${filename}, running ${command_to_run} ..."
    eval $command_to_run
  done
