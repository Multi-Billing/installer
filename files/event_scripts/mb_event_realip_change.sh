#!/bin/bash

# script params:
# ${1}	Локальный IP абонента
# ${2}	UID абонента
# ${3}	ip устройства
# ${4}	snmp comunity
# ${5}	snmp port
# ${6}	ID устройства

# Example:
# disable port on
#snmpset -v 2c -c [community] [ip] .1.3.6.1.2.1.2.2.1.7.[port] i 2
# enable port on
#snmpset -v 2c -c [community] [ip] .1.3.6.1.2.1.2.2.1.7.[port] i 1
