# movies=read.csv('/Users/StanleyLIn/Desktop/Movieinfo 2.csv') #這邊我有改，你去github把他拿下來，我有更新了就是我的第一列有放標題，這樣讀才會對
 ratings=read.table('/Users/StanleyLIn/Desktop/專題研究/u.base.txt')
 movies=read.csv('/Users/StanleyLIn/Desktop/專題研究/MV.csv', stringsAsFactors=FALSE)
 rating_list<-c("userId","movieId","rating","timestamp")
 colnames(ratings)=rating_list
 library(reshape2)
 ratingmat <- dcast(ratings, userId~movieId, value.var = "rating", na.rm=FALSE)
 ratingmat <- as.matrix(ratingmat[,-1])
 library(recommenderlab)

 ratingmat <- as(ratingmat, "realRatingMatrix")
 #ratingmat_norm <- normalize(ratingmat)
 recommender_model <- Recommender(ratingmat, method = "IBCF", param=list(normalize="Center",method="Cosine",k=1)) #取最靠近的前30個neighbors
 recom_results=rep(list(list()),943)
 #mat=matrix(0,nrow=3,ncol=943)
 for(k in 1:943)
 {
 	recom <- predict(recommender_model, ratingmat[k], n=5) #ratingmat[1]就是用user 1去做,10是最close的前10個項目
 	recom_list <- as(recom, "list") 
 	recom_result <- matrix(0,5)
 	for (i in c(1:5))
 	{
  		recom_result[i]<-movies[as.integer(recom_list[[1]][i]),2]
	}
	recom_results[[k]]<-as.vector(recom_result)
	#mat[,k]=as.vector(recom_result)
	#print(recom_results[[k]])
}
#print(mat)
write.csv(recom_results,file="HEY2.csv",row.names=FALSE)
