#!/bin/bash

cd {{ module_path }} || exit

php ./mbcron.php pay_mth_ost
php ./mbcron.php tarif_change
