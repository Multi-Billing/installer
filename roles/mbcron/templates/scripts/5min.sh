#!/bin/bash

cd {{ module_path }} || exit

php ./index.php rad_online
php ./index.php pool_online
php ./index.php do_turbo_block
