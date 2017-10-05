import numpy as np
import operator
import json
f6=open("2013MDestination.txt","r")
f7=open("2013Mweekday.txt","r")
D=f6.read().splitlines()
print(D)
Wd=f7.read().splitlines()
print(Wd)
f4=open("2013MHKG","w")
monday_dest=dict()
for i in range(0,len(D)):
	if(D[i]=="HKG"):
		if(Wd[i] not in list(monday_dest.keys())):
			monday_dest[Wd[i]]=1
		else:
			monday_dest[Wd[i]]+=1
sorted_x = sorted(monday_dest.items(), key=operator.itemgetter(1))
print(sorted_x)
json.dump(sorted_x,f4)		