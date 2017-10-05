A= read.table("/Users/StanleyLIn/Desktop/u.data.txt")
data<-data.frame(A[1],A[2],A[3])
#print(data)
row_count=943
column_count=1682
alpha=0.452
beta=0.548
R=matrix(0,nrow=row_count,ncol=column_count)
mean_user=rep(0,943)
mean_item=rep(0,1682)
count_user=rep(0,943)
count_item=rep(0,1682)

print(typeof(data[1,1]))
for(i in 1:nrow(data))
{
	R[data[i,1],data[i,2]]=data[i,3]
	#print(data[i,3])
	mean_user[data[i,1]]=mean_user[data[i,1]]+data[i,3]
	mean_item[data[i,2]]=mean_item[data[i,2]]+data[i,3]
	count_user[data[i,1]]=count_user[data[i,1]]+1
	count_item[data[i,2]]=count_item[data[i,2]]+1
}
#print(mean_item)
for(i in 1:length(mean_user))
{
	if(count_user[i]!=0)
	{
		mean_user[i]=mean_user[i]/count_user[i]
	}
}
print(mean_user)
for(i in 1:length(mean_item))
{
	if(count_item[i]!=0)
	{
		mean_item[i]=mean_item[i]/count_item[i]
	}
}
print(mean_item)
for(i in 1:nrow(R))
{
	for(j in 1:ncol(R))
	{
		if(R[i,j]==0)
		{
			R[i,j]=alpha*mean_user[i]+beta*mean_item[j]
		}
	}
}

#print(R)
D<-svd(R)
U<-D$u
sigma<-diag(D$d)
V<-D$v
#print(typeof(U[1,]))
#print(dim(sigma))
#print(typeof(V[1,]))
X=U%*%sigma%*%t(V)
print(X)
'''
pred=matrix(0,nrow=row_count,ncol=column_count)
for(i in 1:nrow(pred))
{

	for(j in 1:ncol(pred))
	{
		#print(t(V[j,]))
		pred[i,j]=mean(R[i,])+X[i,j]

	}
}
print(pred)
'''