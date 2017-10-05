import numpy as np
f1=open("2013MDestination.txt","r")
f7=open("2013Mweekday.txt","r")
A=f1.read().splitlines()
D=f7.read().splitlines()
f8=open("2013Mfreq_wd_no_BKK","w")
random_x = [1,2,3,4,5,6,7,8,9,10,11,12]
week_freq=np.repeat(0,7)
week_freq=week_freq.tolist()
for i in range(0,len(D)):
	if(A[i]=="BKK" or A[i]=="HKG"):
		print("Ah")
		continue
	else:
		week_freq[int(D[i])-1]+=1
for i in range(0,7):
	week_freq[i]=str(week_freq[i])
for item in week_freq:
	f8.write(item)
	f8.write("\n")				
