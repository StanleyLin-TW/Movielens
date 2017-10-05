x <- scan("/Users/StanleyLIn/Desktop/u.data.txt",sep="\t")
print(typeof(x))
#NO=c()
A=rep(list(),100000)
#print(A)
#print(y[1])
count=1
print(length(x))
for(i in 1:length(x))
{
	if(i %% 4==1)
	{
		A[count]<-list(x[i],x[i+1],x[i+2],x[i+3])
		count<-count+1
	}
}
print(A[1])	