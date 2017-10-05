import csv
import time
from datetime import datetime
f1=open("/Users/StanleyLIn/Desktop/專題研究/2013.csv")
f2=open("2013F_data.csv",'w')
f3=open("2013M_data.csv",'w')
writer_F= csv.writer(f2, delimiter=',',dialect='excel')
writer_M= csv.writer(f3, delimiter=',',dialect='excel')
count=0
for row in csv.DictReader(f1):
	count+=1
	if(count==1):
		writer_F.writerow(row)
		writer_M.writerow(row)
	print(count)
	if(row["DEP_TIME"]!=""):
		if(row["SEX"]=="F"):
			writer_F.writerow(row.values())
		if(row["SEX"]=="M"):
			writer_M.writerow(row.values())
	