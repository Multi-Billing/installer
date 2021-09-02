#!/bin/bash

cd {{ module_path }} || exit

php -q ./mbcron.php config_mrtg_gen
env LANG=C /usr/bin/mrtg /etc/mrtg/mrtg_tarif.conf >/dev/null 2>&1
env LANG=C /usr/bin/mrtg /etc/mrtg/mrtg_users.conf >/dev/null 2>&1
