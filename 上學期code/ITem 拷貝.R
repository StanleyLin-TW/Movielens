 ratings=read.table('/Users/StanleyLIn/Desktop/u1.base.txt')
 movies=read.csv('/Users/StanleyLIn/Desktop/Movieinfo 2.csv', stringsAsFactors=FALSE)
 rating_list<-c("userId","movieId","rating","timestamp")
 colnames(ratings)=rating_list
 library(reshape2)
 ratingmat <- dcast(ratings, userId~movieId, value.var = "rating", na.rm=FALSE)
 ratingmat <- as.matrix(ratingmat[,-1])
 library(recommenderlab)

 ratingmat <- as(ratingmat, "realRatingMatrix")
 ratingmat_norm <- normalize(ratingmat)
 recommender_model <- Recommender(ratingmat_norm, method = "IBCF", param=list(method="Cosine",nn=30)) 
 recom_results=rep(list(list()),943)
 for(k in 1:943){
 	recom <- predict(recommender_model, ratingmat[k], type = "ratings") 
 	recom_pre <- as(recom, "list")
# 	recom_result <- matrix(0,1682)
#  	recom_result <- recom_pre
 	recom_results[[k]]<-as.vector(recom_pre)
 	
}

#write.csv(recom_results,file="u1base_predict.csv")
