#!/bin/sh

ping -f -w5 -c1000 -s $1 $2 |grep transmitted > $3 &
