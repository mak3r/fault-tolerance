#!/bin/bash

LIMITED=1
LOW_LIMIT=$1

function check() {
	speed=$(echo "scale=2; $(speedtest --no-upload --csv --csv-delimiter '|' | cut -d '|' -f 7)/8388608" | bc -l)
	if [[ "$?" -ne "0" ]]; then
		echo "-1"
	else
		echo $speed
	fi
}

function stop() {
	LIMITED=0
}

function run() {
	while [[ "$LIMITED" -ne "0" ]]; do
		rate=$(check)
		if (( $(echo "$rate == -1" | bc -l) )); then
			echo Unable to get bandwidth value.
			sleep 5
			LIMITED=1
		elif (( $(echo "$rate > $LOW_LIMIT" | bc -l) )); then
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