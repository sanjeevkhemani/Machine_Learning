1. ABSTRACT

In this project we started our foray into Machine Learning. The main focus of the project was an introduction to clustering which can be applied for outlier detection and unsupervised image segmentation, etc.. We used one of the most widely used clustering alogithms, the K-Means algorithm. We implemented a not in-built form of the K-Means function and also applied z-score normalization to the data set before clustering. We utilized two distinct data sets for this project: kmtest and iris. The implementation of the aforementioned was done in the programming language R.

2. TEST RESULTS

2.1 Clustering with K-means algorithm for kmtest dataset

We first cleaned our data by segregating the values into two distinct columns after reading from the .csv file. After which we clustered our first data set kmtest by using the value of k (no. of clusters) as 2, 3, 4, 5. From observation it was quite apparent that k = 4 is the ideal value for the number of distinct clusters for this data set when using the kmeans algorithm. We then normalized the data set’s attribute values using z-score standardization and ran the k-means again to find that the ideal number of clusters for normalized data is k =3.

![image](https://user-images.githubusercontent.com/54830217/212808128-61e1b340-4db0-437f-b4d9-295f7bb8ca3d.png)

Figure 1: Data points for kmtest

![image](https://user-images.githubusercontent.com/54830217/212808141-6545fc24-aaaa-4ede-bd6a-4f83ffb7b4cb.png)

Figure 2.1: (a) Two Clusters (No Normalization)

![image](https://user-images.githubusercontent.com/54830217/212808149-bfced467-7288-40eb-a78b-8ae20581e78c.png)

Figure 2.1: (b) Three Clusters (No Normalization)

![image](https://user-images.githubusercontent.com/54830217/212808174-193b57e1-62a0-41b7-857e-92d81d2c0bfe.png)

Figure 2.1: (c) Four Clusters (No Normalization)

![image](https://user-images.githubusercontent.com/54830217/212808233-836c8606-7413-4c54-9593-01101454541f.png)

Figure 2.1: (d) Five Clusters (No Normalization)

![image](https://user-images.githubusercontent.com/54830217/212808245-8967abcd-a545-4169-81cc-07f7ecbd3b76.png)

Figure 2.2: (a) Two Clusters (Normalization)

![image](https://user-images.githubusercontent.com/54830217/212808261-ee406e69-344d-4781-8f5c-db0a1858c95d.png)

Figure 2.2: (b) Three Clusters (Normalization)

![image](https://user-images.githubusercontent.com/54830217/212808275-90d379a1-02f9-4e99-b37d-864f6c6a1ca2.png)

Figure 2.2: (c) Four Clusters (Normalization)
 
![image](https://user-images.githubusercontent.com/54830217/212808283-bae4a983-b6ca-411a-ac0b-81cbe0ad3dc5.png)

Figure 2.2: (d) Five Clusters (Normalization)

2.2 Test Results for Clustering with K-means algorithm for iris dataset

We now moved on from the test data set and utilized the very famous iris data set that consisted of attribute values for the heights and widths of petals and sepals respectively. Also included in the data set was the label attribute for species of iris which was ignored for this unsupervised learning process. Using the k value as 3, we plotted the first four columns of our data onto a scatterplot as required. Then we chose to ignore the first two columns and focused solely on sepal attributes. With the 3rd and 4th columns, we ran the program multiple times and got our best and worst results. We then compared it with the original result by calculating the distance (euclidean distance) between the centroids of the best and worst results.

Euclidean Distances:
C2 = 4.28007475229584
C3 = 6.5177431782805
 
![image](https://user-images.githubusercontent.com/54830217/212808300-bf023fb7-c448-4618-8404-327c59731878.png)

Figure 3.1: (a) Three Clusters on Four Attributes (No Normalization)

![image](https://user-images.githubusercontent.com/54830217/212808311-6c3dadac-074f-4813-aae1-ddd448e0eea2.png)

Figure 3.2: (a) Three Clusters on Two Attributes (No Normalization) Variation 1
 
![image](https://user-images.githubusercontent.com/54830217/212808335-b773a994-e79c-4aee-a787-5f091424a8db.png)

Figure 3.2: (b) Three Clusters on Two Attributes (No Normalization) Variation 2
 
![image](https://user-images.githubusercontent.com/54830217/212808350-67958120-4ceb-4406-9354-477dc470a1fb.png)

Figure 3.2: (c) Three Clusters on Two Attributes (No Normalization) Variation 3
 
![image](https://user-images.githubusercontent.com/54830217/212808360-3ee00a99-e8af-467b-891c-04d8cd32df23.png)

Figure 3.3: (a) Best Iteration Three Clusters on Two Attributes (Normalization)

![image](https://user-images.githubusercontent.com/54830217/212808388-d796389a-c257-4401-8829-54754e2b0e95.png)

![image](https://user-images.githubusercontent.com/54830217/212808400-a7a2ef3a-9b36-4c20-bd81-d282a7f21e1f.png)

Figure 3.4: (a) Best Centroid Values (b) Worst Centroid Values
