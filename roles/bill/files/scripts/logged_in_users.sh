#!/bin/bash

result=$(last | grep still | awk '{print "{\"user\": \"" $1 "\", \"console\": \"" $2 "\", \"ip\": \"" $3 "\", \"time\": \"" $4 "\"},"}')

echo [ ${result%?} ]

