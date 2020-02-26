import requests
import re
import os
 
hd={"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like     Gecko) Chrome/79.0.3945.130 Safari/537.36"}

url="https://yq.aliyun.com/search/articles/?spm=a2c4e.11163080.searchblog&q=kernel&idx=default&&p="
data=requests.get(url,headers=hd).text
allpage=820//15+1
domain = []
tmp_url=url+str(1)
index=1

fp=open("kernel.txt", "a")

for i in range(0,int(allpage)):
    print("-----page:"+str(i+1)+" -----")
    fp.write("-----page:"+str(i+1)+" -----")
    fp.write('\n')
    data=requests.get(tmp_url,headers=hd).text
    pat_url='<div class="media-body text-overflow">.*?<a href="(.*?)"'
    articles=re.compile(pat_url,re.S).findall(data)

    for j in articles:
        thisurl="https://yq.aliyun.com"+j
        thisdata=requests.get(thisurl).text
        pat_title='<meta charset="utf-8">.*?<title>(.*?)</title>'
        title=re.compile(pat_title,re.S).findall(thisdata)[0]
        # title is all right here.
        fp.write(str(thisurl))
        fp.write(": ")
        fp.write(str(title))
        fp.write('\n')
    
    index+=1
    tmp_url=url+str(index+1)

fp.close()

