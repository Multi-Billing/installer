#!/bin/bash

# script params
# $1 - user ip from Database
# $2 - user uid from Database
# $3 - switch ip from Database 
# $4 - switch snmp comunity from Database
# $5 - switch snmp port from Database
# $6 - switchtype ID from Database
# $7 - user OLD port
# $8 - user New port

#disable port on
#snmpset -v 2c -c [community] [ip] .1.3.6.1.2.1.2.2.1.7.[port] i 2
#enable port on
#snmpset -v 2c -c [community] [ip] .1.3.6.1.2.1.2.2.1.7.[port] i 1

#/usr/bin/snmpset -v 2c -c $5 $3 .1.3.6.1.2.1.2.2.1.7.$8 i 2
#sleep 1
#/usr/bin/snmpset -v 2c -c $5 $3 .1.3.6.1.2.1.2.2.1.7.$8 i 1
