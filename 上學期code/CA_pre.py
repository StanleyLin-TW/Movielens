import csv
import time
from datetime import datetime
import itertools
f = open('2013.csv', 'r')
Date=[]
Time=[]
Month=list(range(1,13))
#print(Month)
Time_type=["MID","MOR","AFT","NIG","NAN"]
Date_type=["Weekday","Weekend","VAC"]
Con_Flight=[0,1]
Location=[]
Vacation=["11","29","210","211","212","213","214","215","216","217","228","44","45","46","47","612","919","920","921","922","1010"]
Result=[]
c=0
f3=open('user_id.txt','w')
for row in csv.DictReader(f):
	#f3.write(str(row['CUSTOMER_ID']))
	#f3.write("\n")
	c=c+1
	print(c)
	temp=[]
	con=-1
	if(row['DEST'] not in Location):
		Location.append(row['DEST'])
	if(row['IN_FLT']=="" and row['OUT_FLT']==""):
		con=0
	else:
		con=1
	temp_time=""
	temp_day=""
	s2=row["FLT_DATE"]
	temp_word=""
	count=0
	t_year=""
	t_month=""
	for word in s2:
		if(word!="/"):
			temp_word=temp_word+word
		else:
			if(count==0):
				t_year=temp_word
			if(count==1):
				t_month=temp_word
			temp_word=""
			count=count+1
	t_day=temp_word
	s=row["DEP_TIME"]
	if(s==""):
		day=datetime(year=int(t_year),month=int(t_month),day=int(t_day))
		temp_time="NAN"
	else:
		t_hr=""
		t_min=""
		flag=0
		min_flag=0
		#print(s)
		for word in s:
			#print(word)
			if(word==" "):
				flag=1
			if(word==":" and min_flag==0):
				min_flag=1
				continue
			if(word==":" and min_flag==1):
				break
			if(flag==1 and min_flag==0):
				t_hr=t_hr+word
			if(flag==1 and min_flag==1):
				t_min=t_min+word
	#	print(t_hr)
		#print(t_min)
		day=datetime(year=int(t_year),month=int(t_month),day=int(t_day),hour=int(t_hr),minute=int(t_min))
	#	print(str(day.month)+str(day.day))
		if(day.hour>=0 and day.hour<7):
			temp_time="MID"
		if(day.hour>=7 and day.hour<13):
			temp_time="MOR"
		if(day.hour>=13 and day.hour<18):
			temp_time="AFT"
		if(day.hour>=18 and day.hour<24):
			temp_time="NIG"
	if(day.isoweekday()<=5):
		temp_day="Weekday"
	if(day.isoweekday()>5):
		temp_day="Weekend"
	check=day.month+day.day
	if(check in Vacation):
		temp_day="Vacation"
	temp=(day.month,temp_day,temp_time,con,row['DEST'])
	Result.append(temp)
print(len(Location))

print(len(Result))
#print(Location)
Permutation=[Month,Date_type,Time_type,Con_Flight,Location]
Prob=list(itertools.product(*Permutation))
print(len(Prob))
item_index=[]

f2=open('items_new.txt','w')
for item in Result:
	index=Prob.index(item)
	f2.write(str(index))
	f2.write("\n")
	item_index.append(index)
	#print(day.hour)
#print(item_index)
#print(Prob[4])
#print(Prob[5])
print(len(item_index))
f.close()