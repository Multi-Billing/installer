#!/bin/bash

digits="01234567890"
lettersB="QWERTYUIOPASDFGHJKLZXCVBNM"
lettersS="qwertyuiopasdfghjklzxcvbnm"
symbols=".-_="

count_d=4
count_lB=5
count_lS=5
count_s=2

pass_string=""

for (( c = 1; c <= $count_d; c++ ))
do
pass_string=$pass_string${digits:$(( RANDOM % ${#digits} )):1}
done

for (( c = 1; c <= $count_lB; c++ ))
do
pass_string=$pass_string${lettersB:$(( RANDOM % ${#lettersB} )):1}
done

for (( c = 1; c <= $count_lS; c++ ))
do
pass_string=$pass_string${lettersS:$(( RANDOM % ${#lettersS} )):1}
done

for (( c = 1; c <= $count_s; c++ ))
do
pass_string=$pass_string${symbols:$(( RANDOM % ${#symbols} )):1}
done

echo -n $pass_string | grep -o . | shuf | tr -d "\n"
