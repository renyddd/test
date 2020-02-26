#!/bin/bash

# echo " The num of arguments is: $# 
# \$1 = $1 
# \$2 = $2 "

count=1
while [[ $# -gt 0 ]]; do
	echo "Argument $count = $1 "
	count=$((count + 1))
	shift
done
