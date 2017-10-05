import plotly.plotly as py
import plotly.graph_objs as go
import numpy as np
import csv
import time
from datetime import datetime
import itertools
Month=list(range(1,13))
months=[]
days=[]
hours=[]
i=0
days=[]
N = 500
random_x = np.linspace(0, 1, N)
random_y = np.random.randn(N)
f = open('2013M_data.csv', 'r')
f4=open('2013Mmonth.txt','w')
f5=open('2013Mday.txt','w')
f6=open('2013Mhour.txt','w')
f7=open('2013Mweekday.txt','w')
for row in csv.DictReader(f):
	i=i+1
	print(i)
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
		continue
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
	f4.write((str(day.month)))
	f5.write((str(day.timetuple().tm_yday)))
	f6.write((str(day.hour)))
	f7.write((str(day.isoweekday())))
	f4.write("\n")
	f5.write("\n")
	f6.write("\n")
	f7.write("\n")


'''
# Create a trace
trace = go.Scatter(
    x = random_x,
    y = random_y
)

data = [trace]

py.iplot(data, filename='basic-line')
'''