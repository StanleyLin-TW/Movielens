A=read.csv("/Users/StanleyLIn/FF.csv")
T=read.table('/Users/StanleyLIn/Desktop/u.test.txt')
movies=read.csv('/Users/StanleyLIn/Desktop/Movieinfo 2.csv', stringsAsFactors=FALSE)
#print(A[1])
B=c(A)
print(B)
#print(T)
mat=data.frame(T[1],T[2],T[3])
item_list=c(movies[2])
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
	if(as.numeric(mat[i,3])>=3 && item_list[as.numeric(mat[i,2])] %in% B[mat[i,1]])
	{
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