#!/bin/bash

LOW_LIMIT=$1
rate=`echo "$(count=2; speedtest --no-upload --csv --csv-delimiter '|' | cut -d '|' -f 7)/8388608" | bc -l`

if [[ "$rate" -gt "$LOW_LIMIT" ]]; then
	echo "Rate $rate MB/s is acceptable."
	exit 0;
else
	echo "Rate $rate MB/s is too low. Threshold is $LOW_LIMIT MB/s"
	exit `echo "$rate/1" | bc`
fi