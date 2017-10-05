A= read.table("/Users/StanleyLIn/Desktop/專題研究/u.base.txt")
test=read.table("/Users/StanleyLIn/Desktop/專題研究/u.test.txt")
test_mat=data.frame(A[1],A[2],A[3])

print (A[1:300,])
print(test_mat[1:300,])
#print(data)
row_count=943
column_count=1682
library(Matrix)
R=sparseMatrix(i=A[[1]], j=A[[2]],x=A[[3]])
print(R)
#print(nnzero(R))
library(irlba)
rmses=c()
num=400
nums=c()
DCGs=c()
NDCGs=c()

#num=num*2
D=irlba(R,nu=400,nv=400)
#print(S)


#D<-svd(R)
U<-D$u
sigma<-diag(D$d)
V<-D$v
#print(typeof(U[1,]))
#print(dim(sigma))
#print(typeof(V[1,]))
X=U%*%sigma%*%t(V)
library(recommenderlab)
#recommenderlab::plot(D$d, main="20 large singular values")
#means=rowSums(R)
#print(means)
for(i in 1:nrow(R))
{
	#count=nnzero(R[i,])
	#print(count)
	#X[i,]=X[i,]+(means[i]/count)
	for(j in 1:length(X[i,]))
	{
		if(X[i,j]>=5)
		{
			X[i,j]=5
		}
		if(X[i,j]<=1)
		{
			X[i,j]=1
		}
	}
}
DCG=0
write.csv(X,file="SVD.csv")
get_value=c()
#print(length(test_mat[[1]]))
for(i in 1:length(test_mat[[1]]))
{
	USER=test_mat[[1]][i]
	ITEM=test_mat[[2]][i]
	get_value<-append(get_value,X[USER,ITEM])
}
library(Metrics)
print(length(get_value))
print(length(test_mat[[3]]))
rmses<-append(rmses,rmse(get_value,test_mat[[3]]))
print(rmses)
for(i in 1:length(test_mat[[3]]))
{
	if(test_mat[[3]][i]>=3 && get_value[i]>=3)
	{
		DCG=DCG+1
	}
	else if(test_mat[[3]][i]<3 && get_value[i]<3)
	{
		DCG=DCG+1
	}
}
DCGs<-append(DCGs,DCG)
NDCGs<-append(NDCGs,DCG/length(test_mat[[3]]))
print(DCGs)
print(NDCGs)
nums<-append(nums,num)
#print(X)

#plot(nums,rmses,'l',main="RMSE")
#text(nums,rmses,rmses)

#plot(nums,DCGs,'l',main="DCG")
#text(nums,DCGs,DCGs)

plot(nums,NDCGs,'l',main="NDCGs")
text(nums,NDCGs,NDCGs)



