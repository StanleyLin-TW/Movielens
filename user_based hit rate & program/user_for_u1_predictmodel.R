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
recommender_model <- Recommender(ratingmat_norm, method = "UBCF", param=list(method="Cosine",nn=30)) 
recom_results=rep(0,943,1682)
for(k in 1:943){
 	recom <- predict(recommender_model, ratingmat[k], type = "ratings") 
 	recom_pre <- as(recom, "matrix")
 	for(i in 1:ncol(recom_pre)){
 		if(is.na(recom_pre[i])){
 			recom_pre[i]=0
 		}	
 	}
 	recom_result <- matrix(0,1682)
 	for(i in 1:ncol(recom_pre)){
 		recom_result[i] <- recom_pre[1,i]
 	}
 	for(i in 1:1682){
 		recom_results[k,i] <- recom_pre[i]
 	}
 	
}

library(MASS)
write.matrix(recom_results, file = "u1base_predict.csv")
 
#write.csv(recom_results,file="u1base_predict.csv")
