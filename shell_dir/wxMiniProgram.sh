#!/bin/bash
# This is to make wx miniprogram web-view file.
# You input a conf file, then I will turn it inot html file.
# Change the title to the right name(the right title).
# Then move it to the right directory.

# test if there is the input file.
if [ $# -lt 1 ]; then
    echo Pleas inupt only one file ...
    exit 2
fi

# test if the right input file.
if [ -f $1 ]; then
    echo Well, I am processing $1 ...
else
    echo You input the wrong file.
    exit 2
fi

# change $1 into the .html file($htmlfile).
vim -c "TOhtml" -c "wqall" $1

# rename
htmlfile=$1".html"
echo $htmlfile, I will deal with it!

# echo Found it, I will process the title line ...

iftheline=`sed -n '/\.html/p' $htmlfile |wc -l`
if [ $iftheline -eq 0 ]; then
    echo No need to process!
    exit 4
fi

sed -i 's/\.html//' $htmlfile

if [ $? -eq 0 ]; then
    echo Finished it!
else
    echo Not done!
    exit 5
fi

# the end, to move the html file.
