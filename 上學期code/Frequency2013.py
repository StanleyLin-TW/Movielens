import csv
import time
from datetime import datetime
f1=open("/Users/StanleyLIn/Desktop/專題研究/2013.csv")
f2=open("2013Fre_H_data_Five.csv",'w')
f3=open("2013Fre_L_data_Five.csv",'w')
#f4=open("/Users/StanleyLIn/Desktop/2014.csv")
ID_NO_Duplicate=dict()
count1=0
for row in csv.DictReader(f1):
	count1+=1
	print(count1)
	if(row["DEP_TIME"]!=""):
		if(row["CUSTOMER_ID"] not in ID_NO_Duplicate.keys()):
			ID_NO_Duplicate[row["CUSTOMER_ID"]]=1
		else:
			ID_NO_Duplicate[row["CUSTOMER_ID"]]+=1
writer_HighF= csv.writer(f2, delimiter=',',dialect='excel')
writer_LowF= csv.writer(f3, delimiter=',',dialect='excel')
count2=0
print(ID_NO_Duplicate)
f1.close()
count_high=0
count_low=0
f1=open("/Users/StanleyLIn/Desktop/專題研究/2013.csv")
for row in csv.DictReader(f1):

	count2+=1
	print(count2)
	if(count2==1):
		#print(row)
		writer_HighF.writerow(row)
		writer_LowF.writerow(row)
	#print(row)
	if(row["DEP_TIME"]!=""):
		#print(ID_NO_Duplicate)
		if(ID_NO_Duplicate[row["CUSTOMER_ID"]]>=5):

		#	print(str(count2)+str(Count[ID_NO_Duplicate.index(row["CUSTOMER_ID"])]))
			writer_HighF.writerow(row.values())
			count_high+=1
		if(ID_NO_Duplicate[row["CUSTOMER_ID"]]<5):
			writer_LowF.writerow(row.values())
			count_low+=1

print(count_high)
print(count_low)
	