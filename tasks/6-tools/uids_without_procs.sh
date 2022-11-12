#!/bin/bash
all_uids=$(cut -d':' -f3 /etc/passwd | sort -u)
uids_with_procs=$(ps -e --no-headers -o uid:1 | sort -u)

uids_without_procs=$(comm -23 <(echo "$all_uids") <(echo "$uids_with_procs") | sort -n)

echo "$uids_without_procs"

# Можно было сразу join чтобы со всей инфой
#join -v 1 -t':' -1 3 <(sort -u -t':' -k3,3 /etc/passwd) <(ps -e --no-headers -o uid:1 | sort -u)