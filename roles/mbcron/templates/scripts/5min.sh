#!/bin/bash

cd {{ module_path }} || exit

php ./mbcron.php rad_online
php ./mbcron.php pool_online
php ./mbcron.php do_turbo_block
