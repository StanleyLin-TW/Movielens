F1=open("u.user.txt","r",encoding="utf-8")
F_temp=open("tempu.txt","w",encoding="utf-8")
F2=open("user_info_pure.txt","w",encoding="utf-8")
B=F1.read()
C=str(B)
C=C.replace("|","\n")

F_temp.write(C)
F3=open("tempu.txt","r",encoding="utf-8")
A=F3.read().splitlines()
print(A[0])
def writing(file,content):
	file.write(content)
	file.write(" ")

for i in range(0,len(A)):
	#if(i%24==0):
	#	writing(F2,A[i])
	#if(i%24==1):
	#	writing(F2,A[i])
	if(i%5==0):
		writing(F2,A[i])
	if(i%5==1):
		writing(F2,A[i])
	if(i%5==2):
		writing(F2,A[i])	
	if(i%5==3):
		F2.write(A[i])
		F2.write("\n")		

		
										