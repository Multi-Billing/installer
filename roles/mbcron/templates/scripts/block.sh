#!/bin/bash

cd {{ module_path }} || exit

php ./mbcron.php unlim_block
