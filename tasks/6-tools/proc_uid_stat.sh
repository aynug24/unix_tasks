#!/bin/bash

process_count_and_uid=$(ps -e --no-headers --sort=uid -o uid | uniq -c)

echo "${process_count_and_uid}" | while read count pid; do
  echo -e "Euid\t${pid}\thas ${count}\t processes"
done
