knn.df <- read.csv(file.choose())

#str(knn.df)
#dim(knn.df)
#summary(knn.df)

#normalize <- function(x)
#{  return((x- min(x)) /(max(x)-min(x)))}
set.seed(2)

#dividing the data into 70% train and 30% test
knn.df <- knn.df[sample(nrow(knn.df)),]
train.df <- knn.df[1:as.integer(0.7*612),]
test.df <- knn.df[as.integer(0.7*612 +1):612,]
#knn.df <- as.data.frame(lapply(knn.df, normalize))

#normalizing columns 1-30
#train.norm <- scale(train.df)
#train.norm[,31] <- train.df[,31]
#test.norm <- scale(test.df)
#test.norm[,31] <- test.df[,31]
#train.norm <- as.data.frame(lapply(train.df[,1:30], normalize))
#test.norm <- as.data.frame(lapply(test.df[,1:30], normalize))
#train.df.n <- rbind(train.df.n, train.df[,30:31])
#test.df.n <- rbind(test.df.n, test.df[,30:31])

euclideanDist <- function(a, b)
{
  #check for the same number of observations
  if(length(a) == length(b))
  {
    sqrt(sum((a-b)^2))  
  }
  else
  {
    stop('The two vectors must be of the same length')
  }
}

knnPredict <- function(test_data, train_data, k_value)
{
  pred <- c()  #empty pred vector 
  
  #looping over each record of the testing data
  for(i in c(1:nrow(test_data)))
  {
    eu_dist = c()                   #eu_dist & eu_char empty  vector
    eu_char = c()
    malignant = 0                   #malignant & benign variable initialization with 0 value
    benign = 0
    
    #looping over training data 
    for(j in c(1:nrow(train_data)))
    {
      #adding euclidean distance b/w test data point and train data to eu_dist vector
      eu_dist <- c(eu_dist, euclideanDist(test_data[i,], train_data[j,]))
      
      #adding class variable of training data in eu_char
      eu_char <- c(eu_char, as.character(train_data[j,][[31]]))
    }
    
    eu <- data.frame(eu_char, eu_dist) #dataframe eu created with eu_char & eu_dist columns
    
    eu <- eu[order(eu$eu_dist),]       #sorting eu dataframe to gettop K neighbors
    eu <- eu[1:k_value,]               #eu dataframe with top K neighbors
    
    #loop over eu and count classes of neighbors
    for(k in c(1:nrow(eu)))
    {
      if(as.character(eu[k,"eu_char"]) == 1)
      {
        malignant = malignant + 1
        #print(paste0("Malignant: ", malignant))
      }
      else if(as.character(eu[k,"eu_char"]) == -1)
      {
        benign = benign + 1
        #print(paste0("Benign: ", benign))
      }
    }
    
    # Compares the no. of neighbors with class label
    if(malignant > benign)
    {
      #if majority of neighbors are malignant then put "1" in pred vector
      pred <- c(pred, 1)
    }
    else {#if(benign < malignant)
      #if majority of neighbors are benign then put "-1" in pred vector
      pred <- c(pred, -1)
    }
  }
  return(pred) #return pred vector
  
}

accuracy <- function(test_data)
{
  correct = 0 #initializing the correct counter to 0
  for(i in c(1:nrow(test_data)))
  {
    if(test_data[i,31] == test_data[i,32])
    { 
      correct = correct+1 #if prediction matches the actual diagnosis
    }
  }
  acc = correct/nrow(test_data) * 100  
  return(acc)
}

K = 1
predictions <- knnPredict(test.df, train.df, K) #calling function knnPredict
test.df[,32] <- predictions #adding predictions to the test data as 32nd column
print(paste0("Data is not normalized. Accuracy: ", accuracy(test.df), "% for K = ", K, "."))