#!/bin/bash

LOW_LIMIT=$1
LOW="low"
OK="ok"

rate=`echo "scale=2; $(speedtest --no-upload --csv --csv-delimiter '|' | cut -d '|' -f 7)/8388608" | bc -l`

if (( $(echo "$rate > $LOW_LIMIT" | bc -l) )); then
	echo "Rate $rate MB/s is acceptable."
	echo "$OK" > /etc/ft-load-status
	exit 0;
else
	echo "Rate $rate MB/s is too low. Threshold is $LOW_LIMIT MB/s"
	echo "$LOW" > /etc/ft-load-status
	exit `echo "$rate/1" | bc`
fi