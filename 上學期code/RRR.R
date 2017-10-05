A=read.csv("/Users/StanleyLIn/HEY2.csv",header=FALSE)
T=read.table('/Users/StanleyLIn/Desktop/專題研究/u.test.txt')
movies=read.csv('/Users/StanleyLIn/Desktop/專題研究/MV.csv')$Movie
#print(movies[2])
#print(length(A))
#print(A)
B=list(list())
for(i in 1:length(A))
{
	B[i]=A[i]
}
print((B[1]))
#print(T)
mat=data.frame(T[1],T[2],T[3])
item_list=movies
print(A[,1])
hit=0
count=0
appear=c()
prev_user=0
flag=0
for(i in 1:20000)
{
	user=mat[i,1]
	if(user!=prev_user)
	{
		prev_user=user
		count=count+1
		flag=0
	}
	num=as.numeric(mat[i,2])
	rate=as.numeric(mat[i,3])
	findee=as.vector(item_list[num])
	finder=as.vector(B[[as.numeric(mat[i,1])]])
	#print(rate)
	#print(num)
#	print(findee)
	#print(item_list[num])
#	print(finder[])
	#print(as.character(item_list[num]))

#	print(findee %in% finder)
	if(rate>=3 && (findee%in%finder))
	{
		#print("GG")
		if(flag==0)
		{
			hit=hit+1
			flag=1
		}
	}
}
print(prev_user)
print(hit)
print(count)
print(hit/count)