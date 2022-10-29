function doesnt_overflow_and_isnt_negative {
  n=$1
  ((n + 1 > 0))
}

# Search for first number that 'does overflow or is negative' <=> number that overflows <=> max number
function bin_search_max_number {
  left=$1
  diff=$2

  if ((diff <= 1)); then
    echo $left
    return 0
  fi

  half_diff=$((diff / 2))
  center=$((left + half_diff))
  if doesnt_overflow_and_isnt_negative $center; then
    bin_search_max_number $(( center + 1 )) $((diff - half_diff))
  else
    bin_search_max_number $left $half_diff
  fi
}

function find_max_number_estimate {
  for ((n = 2; n * 2 > 0; n = n / 2 + n)); do
    true
  done

  echo $n
}

function find_max_number {
  max_number_estimate=$(find_max_number_estimate)
  max_n=$(bin_search_max_number $max_number_estimate $max_number_estimate)

  echo $max_n
}


max_number=$(find_max_number)

echo "Max number:"
echo $max_number

echo "Max number log2:"
bc -l <<<"log2($max_number) / l(2)"

# У меня 2 ** 63 - 1