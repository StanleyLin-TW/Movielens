# movies=read.csv('/Users/StanleyLIn/Desktop/Movieinfo 2.csv') #這邊我有改，你去github把他拿下來，我有更新了就是我的第一列有放標題，這樣讀才會對
strA="/Users/StanleyLIn/Downloads/ml-100k/u"
strB=".base"
strC=".test"
rmses=c()
hits=c()
for(i in 1:5)
{
direct=paste(strA,toString(i),sep="")
base=paste(direct,strB,sep="")
test=paste(direct,strC,sep="")
ratings= read.table(base)
ratings=data.frame(ratings[1],ratings[2],ratings[3])
ratings=data.matrix(ratings)
test=read.table(test)
test=data.frame(test[1],test[2],test[3])
test<-data.matrix(test)
movies=read.csv('/Users/StanleyLIn/Desktop/專題研究/MV.csv', stringsAsFactors=FALSE)
rating_list<-c("userId","movieId","rating","timestamp")
 library(Matrix)
 ratingmats=sparseMatrix(i=ratings[,1], j=ratings[,2],x=ratings[,3],dims=c(943,1682))
 library(recommenderlab)
 print(dim(ratingmats))
 ratingmat <-new("realRatingMatrix", data = ratingmats)
 print(dim(ratingmat))
 #ratingmat_norm <- normalize(ratingmat)
 recommender_model <- Recommender(ratingmat, method = "SVDF") #取最靠近的前30個neighbors
 recom_results=rep(list(list()),943)
 prediction <- predict(recommender_model, ratingmat, type="ratings")
 prediction=as(prediction, "matrix")
 print(dim(prediction))
 print(prediction)
 #mat=matrix(0,nrow=3,ncol=943)
# for(k in 1:943)
 #{
 #	recom <- predict(recommender_model, ratingmat[k], n=5) #ratingmat[1]就是用user 1去做,10是最close的前10個項目
 #	recom_list <- as(recom, "list"   ) 
 #	recom_result <- matrix(0,5)
 #	for (i in c(1:5))
 #	{
  #		recom_result[i]<-movies[as.integer(recom_list[[1]][i]),2]
	#}
	#recom_results[[k]]<-as.vector(recom_result)
	#mat[,k]=as.vector(recom_result)
	#print(recom_results[[k]])
#}
#print(mat)
#print(nrow(test))
#print(nrow(prediction))
#print(ncol(prediction))
#print(prediction[2,2])
recom=matrix(0,nrow=nrow(test),ncol=3)
for(i in 1:nrow(test))
{
	USER=as.numeric(test[i,1])
	temp=1:943
	temp=temp[order(test[USER,],decreasing=TRUE)]
	print(temp)
	recom[USER,]=temp[1:3]
}
get_value=rep(NA,20000)
for(i in 1:nrow(test))
{
	USER=as.numeric(test[i,1])
	ITEM=as.numeric(test[i,2])
	get_value[i]=prediction[USER,ITEM]
}

#print(get_value)
library(Metrics)
print(length(get_value))
print(length(test[,3]))
rmses=append(rmses,sqrt(sum((get_value-test[,3])^2,na.rm=TRUE)/length(get_value)))
print(rmses)

hit=0
count=0
appear=c()
prev_user=0
flag=0
for(i in 1:20000)
{
	user=as.numeric(test[i,1])
	if(user!=prev_user)
	{
		prev_user=user
		count=count+1
		flag=0
	}
	num=as.numeric(test[i,2])
	rate=as.numeric(test[i,3])
	#print(rate)
	#print(num)
#	print(findee)
	#print(item_list[num])
#	print(finder[])
	#print(as.character(item_list[num]))
	finder=recom[user,]
#	print(findee %in% finder)
	if(rate>=3 && (num%in%finder))
	{
		#print("GG")
		if(flag==0)
		{
			hit=hit+1
			flag=1
		}
	}
}
hits=append(hits,hit/count)
#write.csv(recom_results,file="HEY2.csv",row.names=FALSE)
}
