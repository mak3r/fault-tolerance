#!/bin/bash

LOW_LIMIT=$1
rate=`echo "$(speedtest --no-upload --csv --csv-delimiter '|' | cut -d '|' -f 7)/8388608" | bc`

if [[ "$rate" -gt "$LOW_LIMIT" ]]; then
	echo "Rate $rate MB is acceptable."
	exit 0;
else
	echo "Rate $rate MB is too low. Threshold is $LOW_LIMIT"
	exit "$rate"
fi