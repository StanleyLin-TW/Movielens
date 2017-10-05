import numpy as np
import csv
import operator
import json
f1=open("2013.csv","r")
f6=open("2013Destination","r")
f7=open("2013Weekday.txt","r")
D=f6.read().splitlines()
print(len(D))
Wd=f7.read().splitlines()
print(len(Wd))
#f4=open("2013NOHKG","w")
monday_dest=dict()
base=0
up=0
count=-1
for row in csv.DictReader(f1):
	if(row["DEP_TIME"]!=""):
		count+=1
		if(D[count]=="HKG" and Wd[count]=="1"):
			base+=1
			if(row["CARD_TYPE"]!=""):
				up+=1
print(up/base)