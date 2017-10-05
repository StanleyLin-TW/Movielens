F1=open("u.item.txt","r",encoding="utf-8")
F_temp=open("temp.txt","w",encoding="utf-8")
F2=open("item_info_pure.txt","w",encoding="utf-8")
B=F1.read()
C=str(B)
C=C.replace("|","\n")
F_genre=open("u.genre.txt","r",encoding="utf-8")
List_genre=F_genre.read().splitlines()
F_temp.write(C)
F3=open("temp.txt","r",encoding="utf-8")
A=F3.read().splitlines()
print(A[0])
def writing(file,content,i):
	if(content==1):
		file.write(List_genre[i])
		file.write("|")

F4=open("index.txt","w",encoding="utf-8")
F5=open("name.txt","w",encoding="utf-8")
for i in range(0,len(A)):
	#if(i%24==0):
	#	writing(F2,A[i])
	#if(i%24==1):
	#	writing(F2,A[i])
	if(i%24==5):
		F4.write(A[i])
		F4.write("\n")
	if(i%24==6):
		F5.write(A[i])
		F5.write("\n")
	if(i%24==7):
		writing(F2,A[i],i-7)	
	if(i%24==8):
		writing(F2,A[i],i-7)			
	if(i%24==9):
		writing(F2,A[i],i-7)			
	if(i%24==10):
		writing(F2,A[i],i-7)	
	if(i%24==11):
		writing(F2,A[i],i-7)				
	if(i%24==12):
		writing(F2,A[i],i-7)		
	if(i%24==13):
		writing(F2,A[i],i-7)	
	if(i%24==14):
		writing(F2,A[i],i-7)	
	if(i%24==15):
		writing(F2,A[i],i-7)	
	if(i%24==16):
		writing(F2,A[i],i-7)							
	if(i%24==17):
		writing(F2,A[i],i-7)	
	if(i%24==18):
		writing(F2,A[i],i-7)	
	if(i%24==19):
		writing(F2,A[i],i-7)	
	if(i%24==20):
		writing(F2,A[i],i-7)	
	if(i%24==21):
		writing(F2,A[i],i-7)	
	if(i%24==22):
		writing(F2,A[i],i-7)	
	if(i%24==23):
		if(A[i]==1):
			F2.write(List_genre[i-7])
			F2.write("\n")	
										