#!/bin/bash

STARTED=1

function stop() {
	echo "Stopped generating traffic"
	STARTED=0;
}

function run() {
	echo "Start creating download traffic"
	while [[ $STARTED -gt 0 ]]; do
		sleep 1;
		curl -sfL --insecure https://cncf.io > /dev/null
	done
}

trap stop SIGTERM
trap stop SIGINT

"$@"