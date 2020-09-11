#!/bin/bash

RUNNING=1
LOW="low"
OK="ok"

function stop() {
	RUNNING=0;
}

function pause() {
	echo "Stopped generating traffic"
	sleep 5;
}

function dl() {
	echo "Downloading content"
	curl -sfL --insecure https://cncf.io > /dev/null
	sleep 1;
}

function run() {
	echo "run() - process to load"
	# We know that the container wont start unless the init container succeds 
	#   so we set the status to OK to start
	# An alternative would be to setup a readiness probe to populate the 
	#   load status when it's ready.
	echo "$OK" > /etc/ft-load-status
	while [ $RUNNING -gt 0 ]; do
		bandwidth=$(cat /etc/ft-load-status)
		if [ "$bandwidth" == "$LOW" ]; then
			pause
		elif [ "$bandwidth" == "$OK" ]; then
			dl
		fi
	done
}

trap stop SIGTERM
trap stop SIGINT

"$@"