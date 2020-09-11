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
		sleep 1;
		curl -sfL --insecure https://cncf.io > /dev/null
	done
}

function run() {
	echo "run() - process to load"
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