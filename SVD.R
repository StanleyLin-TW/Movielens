SVDa=function(matrixA)
{
	c=t(matrixA)%*%matrixA
	ev<-eigen(c)
	value<-ev$value
	vector<-ev$vector
	print(value)

	print(vector)
}

a=c(1,1,-1)
Amatrix=matrix(0,nrow=2,ncol=3)
Amatrix[1,]<-a
Amatrix[2,]<-a
print(Amatrix)
#answer=SVDa(Amatrix)
A = as.matrix(data.frame(c(4,7,-1,8), c(-5,-2,4,2), c(-1,3,-3,6)))
D<-svd(A)
print(D$d)
print(D$u)
print(D$v)