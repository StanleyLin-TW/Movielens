SVDa=function(matrixA)
{
	AAT=matrixA%*%t(matrixA)
	TAA=t(matrixA)%*%matrixA
	evU<-eigen(AAT)
	evV<-eigen(TAA)
	u<-evU$vectors
	v<-evV$vectors
	v<-v*-1
	eigenvalue<-evU$values
	r <- sqrt(eigenvalue)
	r <- r * diag(length(r))
	if(ncol(matrixA)>nrow(matrixA))
	{
		print("IMHERE")
		time=ncol(matrixA)-nrow(matrixA)
		print(time)
		zero=matrix(0,nrow=nrow(matrixA),ncol=1)
		for(i in 1:time)
		{
			r<-cbind(r,zero)
		}
	}
	if(nrow(matrixA)>ncol(matrixA))
	{
		time=nrow(matrixA)-ncol(matrixA)
		zero=matrix(0,nrow=1,ncol=ncol(matrixA))
		for(i in 1:time)
		{
			r<-rbind(r,zero)
		}
	}
	#print(u)
	#print(v)
	print(r)
	x=u %*% r %*% t(v)
	print(x)
}

a=c(1,1,-1)
Amatrix=matrix(0,nrow=2,ncol=3)
Amatrix[1,]<-a
Amatrix[2,]<-a
#print(Amatrix)
answer=SVDa(Amatrix)
#A = as.matrix(data.frame(c(4,7,-1,8), c(-5,-2,4,2), c(-1,3,-3,6)))
D<-svd(Amatrix)
#print(D$d)
#print(D$u)
#print(D$v)