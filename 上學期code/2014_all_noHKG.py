import numpy as np
import operator
import json
f6=open("2014Destination","r")
f7=open("2014Weekday.txt","r")
f8=open("2014noHKGweekday.txt",'w')
D=f6.read().splitlines()
print(len(D))
Wd=f7.read().splitlines()
print(len(Wd))
f4=open("2014NOHKG","w")
monday_dest=dict()
for i in range(0,len(D)):
	if(D[i]!="HKG"):
		if(Wd[i] not in list(monday_dest.keys())):
			monday_dest[Wd[i]]=1
		else:
			monday_dest[Wd[i]]+=1
sorted_x = sorted(monday_dest.items(), key=operator.itemgetter(0))
print(sorted_x)
json.dump(sorted_x,f4)		
for item in sorted_x:
	temp=str(item)
	temp=temp[6:len(temp)-1]
	f8.write(temp)
	f8.write("\n")

