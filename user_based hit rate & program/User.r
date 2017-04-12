# movies=read.csv('/Users/StanleyLIn/Desktop/Movieinfo 2.csv') #這邊我有改，你去github把他拿下來，我有更新了就是我的第一列有放標題，這樣讀才會對
 ratings=read.table('/Users/StanleyLIn/Desktop/u.base.txt')
 movies=read.csv('/Users/StanleyLIn/Desktop/Movieinfo 2.csv', stringsAsFactors=FALSE)
 rating_list<-c("userId","movieId","rating","timestamp")
 colnames(ratings)=rating_list
 library(reshape2)
 ratingmat <- dcast(ratings, userId~movieId, value.var = "rating", na.rm=FALSE)
 ratingmat <- as.matrix(ratingmat[,-1])
 library(recommenderlab)

 ratingmat <- as(ratingmat, "realRatingMatrix")
 ratingmat_norm <- normalize(ratingmat)
 recommender_model <- Recommender(ratingmat_norm, method = "UBCF", param=list(method="Cosine",nn=30)) #取最靠近的前30個neighbors
 recom_results=rep(list(list()),943)
 for(k in 1:943)
 {
 	recom <- predict(recommender_model, ratingmat[k], n=10) #ratingmat[1]就是用user 1去做,10是最close的前10個項目
 	recom_list <- as(recom, "list") 
 	recom_result <- matrix(0,10)
 	for (i in c(1:10))
 	{
  		recom_result[i]<-movies[as.integer(recom_list[[1]][i]),2]
	}
	recom_results[[k]]<-as.vector(recom_result)
	#print(recom_results[[k]])
}
 
write.csv(recom_results,file="FUCK.csv")
