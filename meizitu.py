import requests as req
import threading
import os,telegram,re,random,time,json
mixtime = int(input('请输入两次下载最小间隔时间，单位为秒:'))
maxtime = int(input('请输入两次下载最大间隔时间，单位为秒:'))
while(mixtime >= maxtime):
    print('最大间隔时间小于或等于最小间隔时间,请重新输入!')
    mixtime = int(input('请输入两次下载最小间隔时间，单位为秒:'))
    maxtime = int(input('请输入两次下载最大间隔时间，单位为秒:'))
    
lock = threading.Lock()
cookies = {'cookies':'Hm_lvt_dbc355aef238b6c32b43eacbbf161c3c=1571490941; Hm_lpvt_dbc355aef238b6c32b43eacbbf161c3c=1571503274'}    
bot = telegram.Bot(token='716376253:AAEKXSr17ZSSAuo-gTjWSo2IOFDCSVziZqs')                                                          
headers = {                                                                                                                        
            'cookie': r'Hm_lvt_dbc355aef238b6c32b43eacbbf161c3c=1571490941; Hm_lpvt_dbc355aef238b6c32b43eacbbf161c3c=1571503278',  
            'referer': 'https://www.mzitu.com',                                                                                    
            'user-agent': r'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36'                                                                                                                               
         }                                                                                                                         
def downloadpng1(i):                                                                                                               
    url = r'https://www.mzitu.com/'+str(i)
    #print(url)
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
def all():
    while True:
        if os.path.exists('1.txt') == True:
            txt = open('./1.txt', 'r')
            string = txt.read()
            txt.close()
            sum_dict = json.loads(string)
            sum = int(sum_dict['sum'])
        else:
            sum_dict = {"sum": "1"}
            string = json.dumps(sum_dict)
            txt = open('./1.txt', 'w')
            txt.write(string)
            txt.close()
            sum = 1                                                                                                           
        print('正在下载id为'+str(sum)+"的图片集")
        lock.acquire()
        b = downloadpng1(sum)
        lock.release()
        #print(b)                                                                                                                      
        if b != 0 :
            lock.acquire()
            sum +=1
            lock.release()
            sum_dict['sum'] = str(sum)
            string = json.dumps(sum_dict)
            txt = open('./1.txt', 'w')
            txt.write(string)
            txt.close()
            for v in range(1,b+1):                                                                                                     
                print('正在下载id为'+str(sum)+"该图片集下第'+str(v)+'本')                                                                                                               
                c = downloadpng2(sum-1,v)                                                                                                  
                if c!=0:                                                                                                               
                    d = req.get(c,cookies=cookies,headers=headers)                                                                     
                    print('该图片集下第'+str(v)+'本状态响应码为:'+str(d.status_code))                                                                                               
                    with open('./'+r'1.jpg', 'wb') as f:                                                                               
                        f.write(d.content)                                                                                             
                    img = open('1.jpg', 'rb')                                                                                          
                    bot.send_photo(chat_id='@baisimeitu', photo=img)                                                                   

            time.sleep(random.randint(mixtime,maxtime))                                                                              
                                                                                                                                       
        else:
            sum +=1
            sum_dict['sum'] = str(sum)
            string = json.dumps(sum_dict)
            txt = open('./1.txt', 'w')
            txt.write(string)
            txt.close()                   
            time.sleep(1)
def main():
    t1 = threading.Thread(target=all)
    t2 = threading.Thread(target=all)
    t1.start()
    time.sleep(3)
    t2.start()

    # 等待两个子线程结束再结束主线程
    t1.join()
    t2.join()

if __name__ == '__main__':
    main()
