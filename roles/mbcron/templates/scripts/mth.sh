#!/bin/bash

cd {{ module_path }} || exit

php ./mbcron.php pay_mth
