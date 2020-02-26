#!/bin/bash

var1=99
var2="hello world"
# 复制两边不能有空格

printf '%s\n' "A is: $var2"
echo "Hey, ${var2}"

var1=$var1+1
echo $var1
# shell 变量默认为字符串

var=99
(( var += 1 )) # C 风格的算数表达式
echo $var
echo $(( var + 1 ))

let 'var = var / 5'
echo $var

if [ -n $var ]; then
	echo More
fi

[ -f "/etc/shadow" ] && echo "/etc/shadow is exist"
[ -f "/etc/NOTFOUND" ] || echo "/etc/NOTFOUD is not exist"
