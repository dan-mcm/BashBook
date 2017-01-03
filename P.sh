#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage $0 mutex-name" >&1
	exit 1
else
# the POSIX 'link' system call is supposed to be atomic on a local file system
	while ! ln -s "$0" "$1" 2>/dev/null; 
	do
		sleep 1
	done
	exit 0
fi
next 8379
