#!/bin/bash

cd {{ module_path }} || exit

php ./mbcron.php do_freeze
php ./mbcron.php do_unfreeze
php ./mbcron.php do_freeze_abonplata

php ./mbcron.php pay_day
php ./mbcron.php pay_day_monthly
php ./mbcron.php pay_day2
php ./mbcron.php pay_real
php ./mbcron.php pay_credit
php ./mbcron.php clear_dhcp_log
php ./mbcron.php do_usluga_block
php ./mbcron.php credit_null
php ./mbcron.php otkl_neplat
php ./mbcron.php del_otkl
php ./mbcron.php clear_real_ip
