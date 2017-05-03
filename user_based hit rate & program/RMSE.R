library(Metrics)
#library(hydroGOF)
#test=read.csv('~/Desktop/Movielens/user_based hit rate & program/u1test_data.csv')
#train=read.csv('~/Desktop/Movielens/user_based hit rate & program/u1base_predict.csv', stringsAsFactors=FALSE)

ratings=read.table('~/Desktop/Movielens/user_based hit rate & program/u1.base.txt')
movies=read.csv('~/Desktop/Movielens/user_based hit rate & program/Movieinfo 2.csv', stringsAsFactors=FALSE)
rating_list<-c("userId","movieId","rating","timestamp")
colnames(ratings)=rating_list
library(reshape2)
ratingmat <- dcast(ratings, userId~movieId, value.var = "rating", na.rm=FALSE)
ratingmat <- as.matrix(ratingmat[,-1])
library(recommenderlab)

ratingmat <- as(ratingmat, "realRatingMatrix")
ratingmat_norm <- normalize(ratingmat)
recommender_model <- Recommender(ratingmat_norm, method = "UBCF", param=list(method="Cosine",nn=30)) 
recom_results=matrix(NA,943,1682)
for(k in 1:943){
 	recom <- predict(recommender_model, ratingmat[k], type = "ratings") 
 	recom_pre <- as(recom, "matrix")
# 	for(i in 1:ncol(recom_pre)){
# 		if(is.na(recom_pre[1,i])){
# 			recom_pre[1,i]=0
# 		}	
# 	}
 	recom_result <- matrix(0,1682)
 	for(i in 1:ncol(recom_pre)){
 		j = as.integer(colnames(recom_pre)[i])
 		recom_result[j] <- recom_pre[1,i]
 	}
 	for(i in 1:1682){
 		recom_results[k,i] <- recom_result[i]
 	}
 	
}

write.csv(recom_results, file = "u1base_predict.csv")

rmses=c()
num=5
nums=c()
DCGs=c()
NDCGs=c()

test=read.table("/Users/po-chengchang/Downloads/ml-100k/u1.test")
test_mat=data.frame(test[1],test[2],test[3])
test_mat<-data.matrix(test_mat)

DCG=0
get_value=c()
for(i in 1:nrow(test_mat)){
	USER=test_mat[i,1]
	ITEM=test_mat[i,2]
	#print(USER)
	#print(ITEM)
	S=recom_results[USER,ITEM]
	get_value<-append(get_value,S)
}

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
print(DCGs)
print(NDCGs)
nums<-append(nums,num)

#plot(nums,rmses,'l',main="RMSE")
#text(nums,rmses,rmses)

#plot(nums,DCGs,'l',main="DCG")
#text(nums,DCGs,DCGs)

#plot(nums,NDCGs,'l',main="NDCGs")
#text(nums,NDCGs,NDCGs)

