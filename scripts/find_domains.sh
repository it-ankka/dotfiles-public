#!/bin/sh

if [ ! -f "$1" ]; then
  echo "Please enter a valid file path"
  exit 1
fi

cut -f1 "$1" | tr -d '\r' | grep -P '^[A-Za-z]{4,4}$' |
while read -r word; do
  if whois "$word.fi" 2>/dev/null | grep -qi "not found"; then
    echo "$word.fi available"
  fi
done
