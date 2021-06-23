#!/bin/bash

PROG=$1
CHROOT="{{ chroot_dir }}"

if ! command -v "${PROG}" &> /dev/null
then
	echo "command ${PROG} not found!"
	exit 0
fi

COMMAND=$(which "${PROG}")
list="$(ldd "${COMMAND}" | grep -oE '/lib.*\.[0-9]')"
for item in $list;
do
	/bin/cp -vf "${item}" "${CHROOT}/${item}";
done
/bin/cp -vf "${COMMAND}" "${CHROOT}${COMMAND}"
