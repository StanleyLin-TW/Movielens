library(Metrics)

getCosine <- function(x,y) 
{
  this.cosine <- sum(x*y) / (sqrt(sum(x*x)) * sqrt(sum(y*y)))
  return(this.cosine)
}
ratings=read.table('~/Desktop/Movielens/user_based hit rate & program/u1.base.txt')
movies=read.csv('~/Desktop/Movielens/user_based hit rate & program/Movieinfo 2.csv', stringsAsFactors=FALSE)
rating_list<-c("userId","movieId","rating","timestamp")
colnames(ratings)=rating_list
library(reshape2)
ratingmat <- dcast(ratings, userId~movieId, value.var = "rating", na.rm=FALSE)
ratingmat <- as.matrix(ratingmat[,-1])


rating_norm <- matrix(NA, nrow=943,ncol=1682,dimnames=list(1:943,1:1682))
rowmean = rowMeans(ratingmat,na.rm=TRUE)
for(b in 1:length(rowmean)){
	if(is.na(rowmean[b])){
		rowmean[i]=0;
	}
}
for(b in 1:nrow(ratingmat)){
	for(c in 1:ncol(ratingmat)){
		if(!is.na(ratingmat[b,c])){
			rating_norm[b,c]=ratingmat[b,c]-rowmean[b]
		}
	}
}
data.similarity  <- matrix(NA, nrow=nrow(rating_norm),ncol=nrow(rating_norm),dimnames=list(1:nrow(rating_norm),1:nrow(rating_norm)))
for(w in 1:nrow(rating_norm)) {
    for(k in 1:ncol(rating_norm)) {
    	if(is.na(rating_norm[w,k])){
    		rating_norm[w,k]= 0
    	}
    }
}
for(w in 1:nrow(rating_norm)) {
    for(k in 1:nrow(rating_norm)) {
    	  data.similarity[w,k] <- getCosine(rating_norm[w,],rating_norm[k,])
    }
}

datapre <- matrix(0, nrow=943,ncol=1682)
top30 <- matrix(NA, nrow=943,ncol=31)
for(i in 1:943){
	top30[i,] <- as.integer(names(head(sort(data.similarity[i,], decreasing=TRUE), 31)))
}
top30<-top30[,-1]
for(i in 1:943){
	for(j in 1:1682){
		datapre[i,j] <- rowmean[i]
	}
}
for(i in 1:nrow(ratingmat)){
	for(j in 1:ncol(ratingmat)){
		for(k in 1:30){
			datapre[i,as.integer(colnames(ratingmat)[j])] <- (data.similarity[i,(top30[i,k])] * rating_norm[(top30[i,k]),j]) + datapre[i,as.integer(colnames(ratingmat)[j])]
		}
	}
}
for(i in 1:943){
	for(j in 1:1682){
		if(datapre[i,j]>=5){
			datapre[i,j]=5
		}
		if(datapre[i,j]<=0){
			datapre[i,j]=0
		}
	}
}
  	
strA="/Users/po-chengchang/Desktop/Movielens/user_based hit rate & program/u"
strC=".test.txt"
direct=paste(strA,toString(1),sep="")
test=paste(direct,strC,sep="")
test=read.table(test)
test_mat=data.frame(test[1],test[2],test[3])
test_mat<-data.matrix(test_mat)

get_value=c()
for(i in 1:nrow(test_mat)){
	USER=test_mat[i,1]
	ITEM=test_mat[i,2]
	S=datapre[USER,ITEM]
	get_value<-append(get_value,S)
}
rmse_1=rmse(get_value,test_mat[,3])
print(rmse_1)


