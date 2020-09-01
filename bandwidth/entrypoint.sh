#!/bin/bash

LOW_LIMIT=$1
rate=`echo "$(speedtest --no-upload --csv --csv-delimiter '|' | cut -d '|' -f 7)/1000000" | bc`

if [[ "$rate" -gt "$LOW_LIMIT"]]; then
	exit 0;
else
	exit "$rate"
fi