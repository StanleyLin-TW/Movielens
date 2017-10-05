import numpy as np
import csv
import operator
import json
f1=open("2014Fre_L_data_Three.csv","r")
#f4=open("2013NOHKG","w")

base=0
up=0
count=-1
for row in csv.DictReader(f1):
	if(row["DEP_TIME"]!=""):
		base+=1
		if(row["CARD_TYPE"]!=""):
			up+=1
print(up/base)