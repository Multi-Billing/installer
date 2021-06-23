#!/bin/bash

# script params
# $1 - user ip from Database
# $2 - user uid from Database
# $3 - switch ip from Database 
# $4 - switch port from Database
# $5 - switch snmp comunity from Database
# $6 - switch snmp port from Database
# $7 - switchtype ID from Database
# $7 - swid old
# $8 - swid new

#disable port
#snmpset -v 2c -c [community] [ip] .1.3.6.1.2.1.2.2.1.7.[port] i 2
#enable port
#snmpset -v 2c -c [community] [ip] .1.3.6.1.2.1.2.2.1.7.[port] i 1

#/usr/bin/snmpset -v 2c -c $5 $3 .1.3.6.1.2.1.2.2.1.7.$4 i 2
#sleep 1
#/usr/bin/snmpset -v 2c -c $5 $3 .1.3.6.1.2.1.2.2.1.7.$4 i 1
