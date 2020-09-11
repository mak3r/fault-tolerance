#!/bin/bash

STARTED=1
LOW="low"
OK="ok"

function stop() {
	echo "Stop generating traffic"
	STARTED=0;
}

function start() {
	echo "Start creating download traffic"
	while [[ $STARTED -gt 0 ]]; do
		curl -sfL --insecure https://cncf.io > /dev/null
		sleep 1;
		check
	done
}

function check() {
	bandwidth=$(cat /etc/ft-load-status)
	if [ "$bandwidth" == "$LOW" ]; then
		stop
	fi
}

function run() {
	echo "run() - process to load"
	# We know that the container wont start unless the init container succeds 
	#   so we set the status to OK to start
	# An alternative would be to setup a readiness probe to populate the 
	#   load status when it's ready.
	echo "$OK" > /etc/ft-load-status
	bandwidth=$(cat /etc/ft-load-status)
	if [ "$bandwidth" == "$LOW" ]; then
		stop
	elif [ "$bandwidth" == "$OK" ]; then
		start
	fi
}

trap stop SIGTERM
trap stop SIGINT

"$@"