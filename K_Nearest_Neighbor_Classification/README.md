1. ABSTRACT

In this project we started our foray into the all important supervised learning aspect of Machine Learning. The main focus of the project was a type of lazy learning method where an evaluation is performed as needed, called K-Nearest Neighbor. kNN Classifier is a supervised pattern classifier that determines the class of an input sample based on the distance to k nearest labeled neighbors. We implemented a not in-built form of the kNN algorithm and analyzed the effect of normalization as well as not using class labels. We utilized bcwdisc.data.mb.csv dataset which is a version of a breast cancer database published by the University of Wisconsin Hospitals. The original data set was sourced from the University of California Irvine (UCI) machine learning repository. The implementation of the aforementioned was done in the programming language R.

2. TEST RESULTS

4.1 kNN classification without normalized observations
We first prepared our data by segregating the values into two distinct datasets after reading from the .csv file. The first comprised of 70% of the values as a training set and the other with 30% as a testing set. After which we classified our data set by using the value of k (no. of neighbors) as 1, 3, 5, 7, 9. From observation it was quite apparent that k = 1 is the ideal value for the number of classifier neighbor for this data set when standardization isn’t applied. An interesting observation was made as increasing k to 3 neighbors, the accuracy dipped noticeably for this dataset. It steadily rose from 3 to 5 to 7, and then at 9 reached the same value as k = 1. 

![image](https://user-images.githubusercontent.com/54830217/212809403-3b5f72fd-fac1-462a-9ee5-203829e744a8.png)

Figure 1: (a) kNN classification; K = 1 (No Normalization)

![image](https://user-images.githubusercontent.com/54830217/212809415-84d5aa1b-b3a7-476b-b081-86fb1e4a0892.png)

Figure 1: (b) kNN classification; K = 3 (No Normalization)

![image](https://user-images.githubusercontent.com/54830217/212809426-09aad838-f270-4057-8e44-15d3eb885c23.png)

Figure 1: (c) kNN classification; K = 5 (No Normalization)

![image](https://user-images.githubusercontent.com/54830217/212809434-6b046f18-9712-4ead-927c-81107c715680.png)

Figure 1: (d) kNN classification; K = 7 (No Normalization)

![image](https://user-images.githubusercontent.com/54830217/212809445-bd5e79e6-7344-4591-8404-834dc6f4f03b.png)
 
Figure 1: (e) kNN classification; K = 9 (No Normalization)

2.2 kNN classification with normalized observations

We followed the steps in 2.1, but this time we also applied standardization to all the attribute observations (except for column 31, which is the class label). We again classified our data set by using the value of k (no. of neighbors) as 1, 3, 5, 7, 9. From observation it was quite obvious that k = 3 is the ideal value for the number of classifier neighbor for this data set once standardization is applied. Utilizing a singleton neighbor, k = 1 had the second best result out of the lot. An interesting observation was made as increasing k from 5 neighbors to 7, and then to 9, the accuracy value stayed the same and was nominally just below that recorded for k = 1.

![image](https://user-images.githubusercontent.com/54830217/212809460-8d008026-4dbf-4c91-82af-f49cebce9805.png)

Figure 2: (a) kNN classification; K = 1

![image](https://user-images.githubusercontent.com/54830217/212809480-4f41af73-8404-4e5c-b721-6196e0f9ae44.png)

Figure 2: (b) kNN classification; K = 3

![image](https://user-images.githubusercontent.com/54830217/212809495-0daafc48-0ea5-4f16-9c76-26a2c3575911.png)

Figure 2: (c) kNN classification; K = 5

![image](https://user-images.githubusercontent.com/54830217/212809527-3765a225-0c2c-4cfe-9e98-3ca79a303bae.png)

Figure 2: (d) kNN classification; K = 7

![image](https://user-images.githubusercontent.com/54830217/212809543-c271a8ef-41e9-47d3-a53b-e795865e95bc.png)

Figure 2: (e) kNN classification; K = 9


2.3 kNN classification with normalized observations and no class labels

We followed the steps in 2.1 and 2.2, but this time we forego the use of class labels in column 31 for our determination. We again classified our data set by using the value of k (no. of neighbors) as 1, 3, 5, 7, 9 as usual. The observation was quite idiosyncratic as the accuracy value stayed the same regardless of the choice of k for this standardized dataset, and was nominally way worse off when compared to when class labels were used in 2.2. This pattern was foreseen and anticipated.

![image](https://user-images.githubusercontent.com/54830217/212809568-ffd119b8-9168-4fd5-8d38-8ed182e6318b.png)

Figure 3: (a) kNN classification; k = 1, 3, 5, 7, 9 (No Class Labels)
