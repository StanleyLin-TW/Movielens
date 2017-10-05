strA="/Users/StanleyLIn/Downloads/ml-100k/u"
strB=".base"
strC=".test"

rmses=c()
num=0
nums=c()
DCGs=c()
NDCGs=c()

for(i in 2:2)
{
direct=paste(strA,toString(i),sep="")
base=paste(direct,strB,sep="")
test=paste(direct,strC,sep="")
A= read.table(base)
A=data.frame(A[1],A[2],A[3])
A=data.matrix(A)
test=A[70001:80000,1:3]
#test_mat=data.frame(test[1],test[2],test[3])
test_mat<-data.matrix(test)
print(test_mat)
#print(data)
row_count=943
column_count=1682
library(Matrix)
#print(A[1])
#print(A[,1])
R=sparseMatrix(i=A[1:70000,1], j=A[1:70000,2],x=A[1:70000,3],dims=c(row_count,column_count))
print(nnzero(R))
C=R
is.na(C) <- C==0
rowmean=rowMeans(C, na.rm=TRUE) 
colmean=colMeans(C, na.rm=TRUE)
Meand=mean(C,na.rm=TRUE)
for(i in 1:length(colmean))
{
	if(is.na(colmean[i]))
	{
		colmean[i]=0
	}
}
for(i in 1:length(rowmean))
{
	if(is.na(rowmean[i]))
	{
		rowmean[i]=0
	}
}
print(rowmean)
print(colmean)
print(Meand)
for(i in 1:nrow(R))
{
	print(i)
	for(j in 1:ncol(R))
	{
		if(R[i,j]!=0)
		{
			R[i,j]=R[i,j]-rowmean[i]-colmean[j]+Meand
		}
	}
}
#print(rowmean)


#print(R)
#print(R)
#print(nnzero(R))
#print (A[1:300,])
#print(test_mat[1:300,])

library(irlba)

for(i in 1:6)
{
num=num+3
print(num)
D=irlba(R,nu=num,nv=num)
#print(S)


#D<-svd(R)
U<-D$u
sigma<-diag(D$d)
V<-D$v
#print(typeof(U[1,]))
#print(dim(sigma))
#print(typeof(V[1,]))
X=U%*%sigma%*%t(V)
print(nrow(X))
print(ncol(X))
#library(recommenderlab)

#recommenderlab::plot(D$d, main="20 large singular values")
#means=rowSums(R)
#print(means)
for(i in 1:nrow(R))
{

	#count=nnzero(R[i,])
	#print(count)
	#X[i,]=X[i,]+(means[i]/count)
	for(j in 1:ncol(R))
	{
		X[i,j]=X[i,j]+rowmean[i]+colmean[j]-Meand
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
write.csv(X,file="SVD2.csv")
get_value=c()
#print(length(test_mat[[1]]))
for(i in 1:nrow(test_mat))
{
	USER=test_mat[i,1]
	ITEM=test_mat[i,2]
	#print(USER)
	#print(ITEM)
	S=X[USER,ITEM]
	get_value<-append(get_value,S)
}

library(Metrics)
#print(get_value)
#print(test_mat[[3]])
rmses<-append(rmses,rmse(get_value,test_mat[,3]))
print(rmses)
for(i in 1:nrow(test_mat))
{
	if(test_mat[i,3]>=3 && get_value[i]>=3)
	{
		DCG=DCG+1
	}
	else if(test_mat[i,3]<3 && get_value[i]<3)
	{
		DCG=DCG+1
	}
}
DCGs<-append(DCGs,DCG)
NDCGs<-append(NDCGs,DCG/nrow(test_mat))
#print(DCGs)
#print(NDCGs)
nums<-append(nums,num)

}
#print(X)

#plot(nums,rmses,'l',main="RMSE")
#text(nums,rmses,rmses)

#plot(nums,DCGs,'l',main="DCG")
#text(nums,DCGs,DCGs)

#plot(nums,NDCGs,'l',main="NDCGs")
#text(nums,NDCGs,NDCGs)

}

