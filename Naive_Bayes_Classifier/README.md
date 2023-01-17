1. ABSTRACT

In this project we implemented a very important supervised learning technique of Machine Learning. The main focus of the project was to perform predictions on a dataset using the Naive Bayes Classifier. This technique is based on Bayes' Theorem with an assumption of independence among predictors. In layman’s terms, this classifier assumes that the presence of a particular feature in a class is unrelated to the presence of any other feature in that class. We implemented a not in-built form of the Naive Bayes Classifier algorithm after standardizing data with Z-score normalization. As an extension, we used a cross validation technique called repeated k-fold cross validation wherein, we run the classifier five different times, changing the testing and training sets each time thru selection of random samples, and then finally averaging the accuracy value accross all runs for a more accurate prediction. We utilized bcwdisc.data.mb.csv dataset which is a version of a breast cancer database published by the University of Wisconsin Hospitals. The original data set was sourced from the University of California Irvine (UCI) machine learning repository. The implementation of the aforementioned was done in the programming language R.

2. TEST RESULTS

2.1 Naive Bayes Classifier accuracy with solitary run and no k-fold cross validation

We first prepared our data by segregating the values into two distinct datasets after reading from the .csv file. The first comprised of 70% of the values as a training set and the other with 30% as a testing set. We performed z-score normalization on our data. After which we performed training on the training set. Then we ran our classifier function on test data set. No cross validation was performed as we made these predictions by setting a seed value for random row selection in a solitary run.

![image](https://user-images.githubusercontent.com/54830217/212810199-9592a7c5-f980-4557-b3a3-6bfea970e6e4.png)

Figure 1: Naive Bayes Classifier accuracy with solitary run and no k-fold cross validation (seed value for randomizing sample selection set to 2)

2.2 Naive Bayes Classifier with repeated k-fold cross validation

We followed the steps in 2.1, but this time we did not use a fixed seed value for randomly dividing the rows into training and testing sets. This time we used a cross validation technique called repeated k-fold cross validation which executed the prediction function several (5) times, each time using a different seed value to get different random divisions of data into training and testing sets. We found accuracies for all the runs, and at the very end we averaged this value to find more accurate prediction stats. 

![image](https://user-images.githubusercontent.com/54830217/212810210-d2a90bd2-05bb-46f6-9966-3a85bc275549.png)

Figure 2: Naive Bayes Classifier accuracy with repeated k-fold cross validation (5 runs; seed value for randomizing sample selection set from 1-5)

2.3 Naive Bayes Classifier with repeated k-fold cross validation (and predictions on training set)

We followed the steps in 2.1 and 2.2, but this time we not only performed the repeated k-folds cross validation, but we also made predictions on the training dataset along with testing dataset. This meant we predicted diagnosis values for training dataset using learning we had performed using the very same values. This was done for good measure, to show that the algorithm works on training data, and the results when compared to testing data are very close.
 
![image](https://user-images.githubusercontent.com/54830217/212810235-3fede03d-2db0-418a-bfeb-79fda8e3ded7.png)

Figure 3: Naive Bayes Classifier accuracy with repeated k-fold cross validation (and predictions on training set as well)
