import telegram
import sys
if  len(sys.argv)==0:
    print('没有消息参数')
elif  len(sys.argv)>1:
    print('消息参数过多')
else:
    bot = telegram.Bot(token='716376253:AAEKXSr17ZSSAuo-gTjWSo2IOFDCSVziZqs')
    bot.send_message(chat_id='-1001364247522', text=sys.argv[0])
