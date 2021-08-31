#!/bin/bash

freeCmd=$(command -v free)
awkCmd=$(command -v awk)

$freeCmd -tmo | $awkCmd 'NR==2 {print "{\"total\":"$2",\"used\":"$3-$6-$7",\"free\":" $4+$6+$7"}"}'
