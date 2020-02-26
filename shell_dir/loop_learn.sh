#!/bin/bash

var=1

while [ $var -lt 10 ]; do
	echo $var
	(( var++ ))
done

for var in A B C; do
	echo $var
done


for var in "Hello World."; do
	echo $var
done
