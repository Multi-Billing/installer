#!/bin/bash

cd {{ module_path }} || exit

php ./index.php pay_mth_ost
php ./index.php tarif_change
