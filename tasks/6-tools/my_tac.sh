#!/bin/bash

function is_newline_or_empty {
  read -r -N 1 char
  [[ (-z "$char") || ("$char" = $'\n') ]]
}

FILENAME="$1"
if [[ -z $FILENAME ]]; then
  echo "Error: no file specified" >&2
  exit 1
fi

line_count=$(wc -l <"$FILENAME")
for (( line_idx = line_count; line_idx >= 1; line_idx-- )); do
    tail -n +${line_idx} <"$FILENAME" | head -1
done

if ! tail -c 1 "$FILENAME" | is_newline_or_empty; then
  echo "Warning: file is missing trailing newline" >&2
fi