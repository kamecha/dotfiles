#!/bin/bash

function nvim-qt-wsl() {
	true
	while [ $? -ne 1 ]; do
		RANDOM_PORT=$(( (RANDOM % 10000) + 50000 ))
		nc -z localhost $RANDOM_PORT
	done
	echo "Using port $RANDOM_PORT"
	cat - <<CMD | parallel
		nvim-qt.exe --server localhost:$RANDOM_PORT
		nvim --listen localhost:$RANDOM_PORT --headless "$@"
CMD
}

nvim-qt-wsl "$@"

