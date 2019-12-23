#!/bin/bash
# To create the wx files.
# $1 the file name to create.
# $2 the file url.

cd /f/someRrpositories/cloudCamera/miniprogram/ 

mkdir $1
cd $1

jsonfile=$1".json"
touch $jsonfile
echo {} > $jsonfile

jsfile=$1".js"
touch $jsfile
cat > $jsfile << EOF
Page({
  onLoad: function (options) {
    
  }
})
EOF

wxmlfile=$1".wxml"
touch $wxmlfile
cat > $wxmlfile << EOF
<web-view src="$2" />
EOF

# How to get the PATHNAME? 
# Just need the right path of HTML files.
htmlpath=`sed -n '/first.lisp.html/p' first.lisp.html |awk -v FS='>' '{print $2}' |awk -v FS='<' '{print $1}'`
echo $htmlpath

# manipulate the index.wxml and the app.json files, and change to the right directory.
cd ../
sed -i "/foundMe/i <navigator url="/$1/$1?title=$1" hover-class="navigator-hover" class=".page-body-form-item">$htmlpath</navigator> \n" index/index.wxml

echo finished the index.wxml

sed -i "/],/i ,\"$1/$1\"" app.json

echo finished the app.json
