library(ggplot2)
#Generate the data
A=read.table("/Users/StanleyLIn/Desktop/專題研究/2013Mfreq_d")
print(A)
B=A
A=as.matrix(A)
#print(A)
#A=as.vector(A)
#Set Aesthetic attributes and assign Geometric objects
par(mfrow = c(1,2)) 
arr=c()
for(i in 1:365)
{
	#print(A[i])
	print(i)
#	if(A[i]<12000 && A[i]>9000)
	if(i>10 && i<=355 && abs(A[i]-mean(A[(i-10):(i-1)]))<800 && abs(A[i]-mean(A[(i+1):(i+10)]))<800)
	{
		print("YA")
		arr=append(arr,"")
	}
	else if(i<=10  && abs(A[i]-mean(A[(i+1):(i+10)]))<800)
	{
		arr=append(arr,"")
	}
	else if(i>355 && abs(A[i]-mean(A[(i-10):(i-1)]))<800)
	{
		arr=append(arr,"")
	}
	else
	{
		print("NO")
		aa=as.Date(i-1, origin = "2014-01-01")
		aa=format(as.Date(aa,format="%Y-%m-%d"), "%m/%d")
		print(aa)
		aa=toString(aa)
		arr=append(arr,aa)
	}
}
names(B)<-NULL
df <- data.frame(gp = 1:365,y = B)
print(arr)
s=ggplot(df, aes(x = gp, y = y))+geom_line(color="#CAA661")+geom_text(label=arr,check_overlap = TRUE)+ggtitle("2013_male_Days", subtitle = NULL)
s