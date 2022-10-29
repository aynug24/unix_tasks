#!/bin/bash

function setup {
  mkdir test
  cd test

  touch $'simple'
  touch $'MiXeD'
  touch $'ALREADY_CAP'
  touch $'АБВГД'
  touch $'white space'
  touch $'new\nline'
  touch $'carriage\rret'
}

function teardown {
  cd ..
  rm -rf test
}

function _capitalize_found_file {
  file_path=$1

  file_basename=$(basename "${file_path}")
  file_capitalized_name="${file_basename^^}"
  capitalized_path="$(dirname "${file_path}")/${file_capitalized_name}"

  mv "$file_path" "$capitalized_path"
}

function _capitalize_found_files {
  for file_path in "$@"; do
    _capitalize_found_file "$file_path"
  done
}

function capitalize_files {
  export -f _capitalize_found_file
  export -f _capitalize_found_files
  find . -type f -exec bash -c '_capitalize_found_files "$@"' {} '+'
}

function start_test {
  setup
  echo -e "Files before capitalizing:\n$(ls -b)"

  capitalize_files

  echo -e "Files after capitalizing:\n$(ls -b)"
  teardown
}

#set -o xtrace
start_test
