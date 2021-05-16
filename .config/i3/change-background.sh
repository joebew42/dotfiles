#!/usr/bin/env bash

trap stop SIGINT SIGTERM

PIDFILE=/tmp/change-background.pid

wallpapersDirectory=~/Pictures/Wallpapers/*
timeout=$((30 * 60))

check_if_already_running() {
  if [ -e $PIDFILE ]; then
    if kill -0 &>1 > /dev/null `cat $PIDFILE`; then
        echo "Already running"
        exit 1
    else
        rm $PIDFILE
    fi
  fi
}

start() {
  check_if_already_running

  echo $$ > $PIDFILE
  while :; do
    run
  done
}

stop() {
  echo "Bye bye ..."
  rm $PIDFILE
  exit
}

run() {
  for wallpaper in $wallpapersDirectory; do
    changeWallpaper $wallpaper
    sleep $timeout &
    wait $!
  done
}

changeWallpaper() {
   /usr/bin/feh --bg-fill $1
}

start
