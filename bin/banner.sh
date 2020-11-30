#!/usr/bin/env bash

# Usage Example
# banner.sh "CODE KATA" "Unusual Spending Kata"

[ $# -eq 0 ] && { echo "Usage: $0 type-of-the-session what url"; exit 1; }

TYPE_OF_SESSION=$1
WHAT=$2
URL=$3

clear

while [ true ]; do
  echo -e "\e[0m\n"
  echo -e "\e[0m 🎯 \e[1m$TYPE_OF_SESSION"
  echo -e "\e[0m 👉 $WHAT"
  echo -e "\e[0m 🔗 \e[4m\e[2m$URL"
  echo -e "\e[0m\n"
  read
done
