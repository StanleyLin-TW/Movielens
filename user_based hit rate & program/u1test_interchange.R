ratings = read.table(' ~/Desktop/Movielens/user_based hit rate & program/u1.test.txt')
rating_list<-c("userId","movieId","rating","timestamp")
colnames(ratings)=rating_list
rating_fin=matrix(NA,943,1682)
for(i in 1:2000){
	rating_fin[as.integer(ratings[i,1]),as.integer(ratings[i,2])]=as.integer(ratings[i,3])
}

write.csv(rating_fin, file = "u1test_data.csv")
