#!/bin/bash

cd {{ module_path }} || exit

php ./index.php unlim_block
