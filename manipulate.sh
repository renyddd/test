#!/bin/bash
# manipulate the index.html and app.json

sed -i "/foundMe/i <navigator url="/$1/$1?title=$1" hover-class="navigator-hover" class=".page-body-form-item">/etc/rc.d/init.d/functions</navigator> \n" index.wxml
echo finished the index.wxml

sed -i "/],/i ,\"$1/$1\"" app.json
echo finished the app.json
