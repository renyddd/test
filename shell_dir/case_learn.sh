#!/bin/bash

choose=q
help()
{
cat << EOF
Usage: you type a word.
mem
disk
cpu
h
q
EOF
}

help # 函数调用时不加括号
read -t 5 -p "You choice: " choose

case $choose in
mem)
	free -h;;
disk)
	fdisk -l;;
cpu)
	cat /proc/cpuinfo
	;;
h)
	help;; # no ()
q)
	exit 1
	;;
esac
