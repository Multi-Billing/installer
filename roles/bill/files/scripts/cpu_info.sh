#!/bin/bash

result=$(/bin/cat /proc/cpuinfo \
		| /usr/bin/awk -F: '{print "\""$1"\": \""$2"\"," }	'\
		)

echo "{" ${result%?} "}"
