library(Metrics)
library(hydroGOF)
test=read.csv('~/Desktop/Movielens/user_based hit rate & program/u1test_data.csv')
train=read.csv('~/Desktop/Movielens/user_based hit rate & program/u1base_predict.csv', stringsAsFactors=FALSE)

result<-rmse(train, test, na.rm=TRUE)
