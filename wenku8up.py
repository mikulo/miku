import requests as req
import datetime
import re
import pinyin

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        pass

    try:
        import unicodedata
        unicodedata.numeric(s)
        return True 
    except (TypeError, ValueError):
        pass
         
    return False
def shou1(name):
    return "".join([i[0] for i in pinyin.get(name, " ").split(" ")])
def shou2(name):
    if is_number(shou1(name))==True:
        return 0
    elif 65<=ord(shou1(name))&ord(shou1(name))<=90:
        return shou1(name).lower()
    elif 97<=ord(shou1(name))&ord(shou1(name))<=122:
        return shou1(name) 
    else:
        return 0

if datetime.datetime.now().day <10:
    todaytime = str(datetime.datetime.now().year) +'-'+str(datetime.datetime.now().month)+'-'+'0'+str(datetime.datetime.now().day)
else:
    todaytime = str(datetime.datetime.now().year) +'-'+str(datetime.datetime.now().month)+'-'+str(datetime.datetime.now().day)
username = 'paranoiam'
userpasswd = 'qwe905148'
logindata = {'username':username,'password':userpasswd,'usercookie':0,'action':'login','submit':'%26%23160%3B%B5%C7%26%23160%3B%26%23160%3B%C2%BC%26%23160%3B'}
login = req.post('https://www.wenku8.net/login.php',data=logindata)
login.encoding='gbk'
logintxt = login.text
if logintxt.find('登录成功')!= -1:
    print('登陆成功!即将开始爬取今日更新!')
    toplist = req.get('https://www.wenku8.net/modules/article/toplist.php',cookies=login.cookies)
    toplist.encoding='gbk'
    toplistxt=toplist.text
    if toplistxt.find(todaytime) != -1:
    
        print('今日有'+str(toplistxt.count(todaytime))+'个更新!')
        m = re.findall(r'style="font-size:13px(.*)>',toplistxt)
        for i in m[:toplistxt.count(todaytime)]:
            link = re.findall(r'book/(.*).htm',i)
            downlink=r'http://dl.wenku8.com/down.php?type=txt&id='+str(link[0])
            namelink=r'https://www.wenku8.net/book/'+str(link[0])+r'.htm'
            downtext = req.get(namelink,cookies=login.cookies)
            downtext.encoding='gbk'
            downtxt = downtext.text
            n = re.findall(r'content="(.*)小说,',downtxt)
            name = n[0]
            print(name)
            for a in name[:1]:
                shouzm = shou2(a)
            d = req.get(downlink,cookies=login.cookies)
            with open('./'+str(shouzm)+'/'+name+r'.txt', 'wb') as f:
                f.write(d.content)
        print('全部更新下载完成!')

    else:
        print('未检测到更新!')


else:
    print('登陆失败,请检查账号密码!')
