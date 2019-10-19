import requests as req
import os
import telegram
import re
import random
import time
cookies = {'cookies':'Hm_lvt_dbc355aef238b6c32b43eacbbf161c3c=1571490941; Hm_lpvt_dbc355aef238b6c32b43eacbbf161c3c=1571503274'}
bot = telegram.Bot(token='716376253:AAEKXSr17ZSSAuo-gTjWSo2IOFDCSVziZqs')
headers = {
            'cookie': r'Hm_lvt_dbc355aef238b6c32b43eacbbf161c3c=1571490941; Hm_lpvt_dbc355aef238b6c32b43eacbbf161c3c=1571503278',
            'referer': 'https://www.mzitu.com',
            'user-agent': r'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36'
         }
def downloadpng1(i):
    url = r'https://www.mzitu.com/'+str(i)
    h = req.get(url,cookies=cookies,headers=headers)
    if h.status_code == 200:
        p = re.search(r'pagenavi.*hotlist',h.text,re.DOTALL).group(0)
        n = re.findall(r'<span>\d{1,3}</span>',p,re.DOTALL)
        return int(re.search(r'\d{1,3}',n[-1],re.DOTALL).group(0))
    else:
        return 0
    
def downloadpng2(a,b):
        url2 = r'https://www.mzitu.com/'+str(a)+r'/'+str(b)
        m = req.get(url2,cookies=cookies,headers=headers)
        n = m.status_code
        if n == 200:               
            downlink = re.findall(r'<img src="(.*?)" alt="',m.text,re.DOTALL)
            return downlink[0]
        else:
            return 0
for x in range(1,210000):
    print(x)
    b = downloadpng1(x)
    #print(b)
    if b != 0 :
        for v in range(1,b+1):
            c = downloadpng2(x,v)
            if c!=0:
                d = req.get(c,cookies=cookies,headers=headers)
                #print(d.status_code)
                with open('./'+r'1.jpg', 'wb') as f:
                    f.write(d.content)
                img = open('1.jpg', 'rb')
                bot.send_photo(chat_id='@baisimeitu', photo=img)
                time.sleep(random.randint(20,120))
                
    else:
        continue
