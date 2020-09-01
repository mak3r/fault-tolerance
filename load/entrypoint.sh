#!/bin/bash

STARTED=1

function stop() {
	STARTED=0;
}

function run() {
	while ($STARTED) {
		sleep 10;
		curl -sfL https://www.google.com > /dev/null
	}
}

trap stop SIGTERM

"$@"
