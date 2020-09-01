#!/bin/bash

LIMITED=1
LOW_LIMIT=$1

function check() {
	echo "scale=2; $(speedtest --no-upload --csv --csv-delimiter '|' | cut -d '|' -f 7)/8388608" | bc -l	
}

function stop() {
	LIMITED=0
}

function run() {
	rate=$(check)
	while [[ "$LIMITED" -ne "0" ]]; do
		if (( $(echo "$rate > $LOW_LIMIT" | bc -l) )); then
			LIMITED=0
			echo "Rate $rate MB/s is acceptable."
		else
			echo "Rate $rate MB/s is too low. Threshold is $LOW_LIMIT MB/s"
			sleep 5
			LIMITED=1
		fi
	done
}

trap stop SIGINT
trap stop SIGTERM

run