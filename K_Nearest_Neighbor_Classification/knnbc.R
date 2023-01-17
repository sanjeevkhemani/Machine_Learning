knn.df <- read.csv(file.choose())

#str(knn.df)
dim(knn.df)
#summary(knn.df)

#normalize <- function(x) {
#  return((x- min(x)) /(max(x)-min(x)))
#}

set.seed(2)

#knn.df <- as.data.frame(lapply(knn.df, normalize))
knn.df <- knn.df[sample(nrow(knn.df)),]
train.df <- knn.df[1:as.integer(0.7*612),]
test.df <- knn.df[as.integer(0.7*612 +1):612,]

train.norm[,1:30] <- scale(train.df[,1:30])
#train.norm <- as.data.frame(lapply(train.df[,1:30], normalize))
train.norm[,31] <- train.df[,31]
test.norm[,1:30] <- scale(test.df[,1:30])
#test.norm <- as.data.frame(lapply(test.df[,1:30], normalize))
test.norm[,31] <- test.df[,31]

# train.df.n <- rbind(train.df.n, train.df[,30:31])
# test.df.n <- rbind(test.df.n, test.df[,30:31])

euclideanDist <- function(a, b){
  #  We check that they have the same number of observation
  if(length(a) == length(b)){
    sqrt(sum((a-b)^2))  
  } else{
    stop('Vectors must be of the same length')
  }
}

knn_predict <- function(test_data, train_data, k_value){
  pred <- c()  #empty pred vector 
  #LOOP-1
  for(i in c(1:nrow(test_data))){   #looping over each record of test data
    eu_dist = c()          #eu_dist & eu_char empty  vector
    eu_char = c()
    malignant = 0              #good & bad variable initialization with 0 value
    benign = 0
    
    #LOOP-2-looping over train data 
    for(j in c(1:nrow(train_data))){
      
      #adding euclidean distance b/w test data point and train data to eu_dist vector
      eu_dist <- c(eu_dist, euclideanDist(test_data[i,], train_data[j,]))
      
      #adding class variable of training data in eu_char
      eu_char <- c(eu_char, as.character(train_data[j,][[31]]))
    }
    
    eu <- data.frame(eu_char, eu_dist) #eu dataframe created with eu_char & eu_dist columns
    
    eu <- eu[order(eu$eu_dist),]       #sorting eu dataframe to gettop K neighbors
    eu <- eu[1:k_value,]               #eu dataframe with top K neighbors
    
    #Loop 3: loops over eu and counts classes of neibhors.
    for(k in c(1:nrow(eu))){
      if(as.character(eu[k,"eu_char"]) == 1){
        malignant = malignant + 1
        #print(paste0("Malignant: ", malignant))
      }
      else if(as.character(eu[k,"eu_char"]) == -1) {
        benign = benign + 1
        #print(paste0("Benign: ", benign))
      }
    }
    
    # Compares the no. of neighbors with class label good or bad
    if(malignant > benign){          #if majority of neighbors are good then put "g" in pred vector
      
      pred <- c(pred, 1)
      #print(paste0("Good > Bad: ", malignant))
    }
    else {#if(benign < malignant){
      #if majority of neighbors are bad then put "b" in pred vector
      pred <- c(pred, -1)
      #print(paste0("Bad > Good: ", benign))
    }
    
  }
  return(pred) #return pred vector
}

accuracy <- function(test_data){
  correct = 0
  for(i in c(1:nrow(test_data))){
    if(test_data[i,31] == test_data[i,32]){ 
      correct = correct+1
    }
  }
  accu = correct/nrow(test_data) * 100  
  return(accu)
}

K = 9
predictions <- knn_predict(test.norm, train.norm, K) #calling knn_predict()
test.norm[,32] <- predictions #Adding predictions in test data as 7th column

print(accuracy(test.norm))

