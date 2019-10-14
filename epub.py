import requests as req
import re
import pinyin
import string
passname = 0
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
for i in range(1,243762):
    yuanma=req.get('https://www.aixdzs.com/d/111/'+str(i))
    yuanma.encoding='UTF-8'
    yuanmatxt = yuanma.text
    n = re.findall(r' <title>(.*?)txt,epub电子',yuanmatxt,re.DOTALL)    
    name = n[0]
    x = re.findall(r'TXT全集下载</h3><i>/(.*?)</i></div>',yuanmatxt,re.DOTALL)
    if x[0].find('M')!=-1:

        for a in name[:1]:
            shouzm = shou2(a)
        downlink = 'https://www.aixdzs.com/down?id='+str(i)+'&p=4'
        print("\r"+'正在下载第'+str(i)+'本,名称为:\"'+name+'\",已跳过'+str(passname)+'本'+'                   ', end='')
        d = req.get(downlink)
        with open('./'+str(shouzm)+'/'+name+r'.epub', 'wb') as f:
            f.write(d.content)
        with open('./log.txt', 'w') as f:
            f.write(str(i))
    elif x[0].find('K')!=-1:
        c = x[0]
        c = c[:-1]
        if float(c)>100:
            for a in name[:1]:
                shouzm = shou2(a)
            downlink = 'https://www.aixdzs.com/down?id='+str(i)+'&p=4'
            print("\r"+'正在下载第'+str(i)+'本,名称为:\"'+name+'\",已跳过'+str(passname)+'本'+'                   ', end='')
            d = req.get(downlink)
            with open('./'+str(shouzm)+'/'+name+r'.epub', 'wb') as f:
                f.write(d.content)
            with open('./log.txt', 'w') as f:
                f.write(str(i))
        else:
            passname +=1
            print("\r"+'字数小于10万跳过第'+str(i)+'本,名称为:\"'+name+'\",已跳过'+str(passname)+'本'+'                   ', end='')
        
    else:
        passname +=1
        print("\r"+'字数小于10万跳过第'+str(i)+'本,名称为:\"'+name+'\",已跳过'+str(passname)+'本'+'                   ', end='')

                
