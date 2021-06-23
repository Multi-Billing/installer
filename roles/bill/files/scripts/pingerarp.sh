#!/bin/sh

arping -f -w 3 -I $1 $2 > $3 &
