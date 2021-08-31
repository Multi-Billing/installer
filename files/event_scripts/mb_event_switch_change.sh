#!/bin/bash

# script params:
# ${1}	Локальный IP абонента
# ${2}	UID абонента
# ${3}	ip устройства
# ${4}	Порт абонента
# ${5}	snmp comunity
# ${6}	snmp port
# ${7}	Старый ID устройства
# ${8}	Новый ID устройства

# Example:
# disable port
#snmpset -v 2c -c [community] [ip] .1.3.6.1.2.1.2.2.1.7.[port] i 2
# enable port
#snmpset -v 2c -c [community] [ip] .1.3.6.1.2.1.2.2.1.7.[port] i 1
