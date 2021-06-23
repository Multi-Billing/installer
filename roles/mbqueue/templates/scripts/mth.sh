#!/bin/bash

cd {{ module_path }} || exit

php ./index.php pay_mth
