#Select dataset .csv file
NB.df <- read.csv(file.choose())

#Repeated k-fold cross validation placeholder for accuracy values
train_prediction = rep(1, 5)
test_prediction = train_prediction

#Read number of columns
col = ncol(NB.df)

#Execute classification five times for repeated k-fold cross validation
for(count in c(1:5))
{
  #Set seed value for random partition
  set.seed(count)
  
  #Split data into 70% and 30% sets for training and testing respectively
  NB.df <- NB.df[sample(nrow(NB.df)),]
  train_data <- NB.df[1:as.integer(0.7*612),]
  test_data <- NB.df[as.integer(0.7*612 +1):612,]
  
  #Store training attributes and diagnosis
  train_attr = train_data[,-col]
  train_diag = train_data[,col]
  
  #Z-score normalize training data
  train_mean <- apply(train_attr, 2, mean)  
  train_sd   <- apply(train_attr, 2, sd)    
  
  #Attribute value minus mean
  train_offset <- t(t(train_attr) - train_mean)
  #Divide by standard deviation
  train_norm  <- t(t(train_offset) / train_sd)
  
  #Get positive diagnosis class Index
  pos_idx = which(train_data[,col] == 1)
  pos_data = train_norm[pos_idx,]
  neg_data = train_norm[-pos_idx,]
  
  #Get mean and standard deviation on standardized data
  pos_mean = apply(pos_data, 2, mean)
  pos_sd = apply(pos_data, 2, sd)
  neg_mean = apply(neg_data, 2, mean)
  neg_sd = apply(neg_data, 2, sd)
  
  #Store test attributes without diagnosis
  test_attr = test_data[,1:col-1]
  
  #Function to predict positive or negative diagnosis value
  predict = function(test_attr_row)
  {
    curr_pred = 0;
    
    #Calculate probability and normal distribution
    pos_p = sum(log(dnorm(test_attr_row, pos_mean, pos_sd)))
    + log(length(pos_idx) / length(train_diag))
    neg_p = sum(log(dnorm(test_attr_row, neg_mean, neg_sd)))
    + log(1 - (length(pos_idx) / length(train_diag)))
    
    #Assign prediction value as positive or negative based on greater probability
    if(pos_p > neg_p)
    {
      curr_pred = 1
    }
    else
    {
      curr_pred = -1
    }  
  }
  
  #Normalize Test Data
  test_offset <- t(t(test_attr) - train_mean)         
  test_norm  <- t(t(test_offset) / train_sd)
  
  #Use predict function on test data and get prediction for each instance (row)
  test_pred = apply(test_norm, 1, predict)
  curr_pred = test_data[,col]
  test_prediction[count] = length(which((test_pred == curr_pred) == TRUE)) / length(curr_pred)
  
  #Predict for train data
  pred_train = apply(train_norm, 1, predict)
  train_prediction[count] = length(which((pred_train == train_diag) == TRUE)) / length(train_diag)
  
  #Print out accuracy results for each iteration of repeated k-fold cross validation
  print(paste0("Accuracy results for run ", count, ":"))
  print(paste0("Test Data Accuracy: ", test_prediction[count]*100.0, "%", sep = " "))
  print(paste0("Train Data Accuracy: ", train_prediction[count]*100.0, "%", sep = " "))
  cat("\n")
}

#Print out averages across five k-fold cross validation runs
print(paste0("Average Test Data Accuracy across 5 runs: ", mean(test_prediction)*100.0, "%", sep = " "))
print(paste0("Average Train Data Accuracy across 5 runs: ", mean(train_prediction)*100.0, "%", sep = " "))