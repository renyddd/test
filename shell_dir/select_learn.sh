#!/bin/bash

echo "What's your favourite?"

select var in "l" "w" "none"; do
	break;
done
# 交互时，使用数字
echo "You choose $var"
