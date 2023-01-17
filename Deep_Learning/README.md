1. ABSTRACT

In this project we deep structured learning which is part of a broader family of machine learning methods based on artificial neural networks with representation learning. Deep-learning architectures such as deep neural networks, and convolutional neural networks have been applied to several applications. Transfer learning is a research problem in machine learning that focuses on storing knowledge gained while solving one problem and applying it to a different but related problem. We utilized fundus images in IDRiD were captured by a retinal specialist at an Eye Clinic located in Nanded, Maharashtra, India. From the thousands of examinations available, we have extracted 516 images to form our dataset. Experts verified that all images are of adequate quality, clinically relevant, that no image is duplicated and that a reasonable mixture of disease stratification representative of diabetic retinopathy (DR) is present. The implementation of the aforementioned was done in the programming language MATLAB.

2. DATA PREPARATİON AND LABELING

We first prepared our data by reading the images with different labels into different imageDatastores. We read images with label 0 and assigned a ‘Non-DR’ categorical label value, and ones with label 3, 4 with ‘DR’ categorical label value. We made sure to keep images in the Train and Test folders separated. After assigning proper labels, we compiled out list of images for training and validation.

![image](https://user-images.githubusercontent.com/54830217/212810957-87cf58c2-a396-4a95-9bb8-8b20d7791c1a.png)

Figure 2.1: Data preparation
 
![image](https://user-images.githubusercontent.com/54830217/212810939-971c7b53-9004-4dcb-a5bc-381d1a1ef927.png)

Figure 2.2: Label assignment

3. TEST RESULTS AND ANALYSIS
 
![image](https://user-images.githubusercontent.com/54830217/212810881-fe893df1-e3f9-4768-a808-90a3395da728.png)

Figure 3.1: Layer analysis

3.1 Deep learning with MaxEpochs = 7, MiniBatchSize = 10, ValidationFrequency = 3

We set our algorithm values to MaxEpochs = 7, MiniBatchSize = 10, ValidationFrequency = 3 and tested our deep learning prediction model.
 
![image](https://user-images.githubusercontent.com/54830217/212810850-c6b627b7-0860-4b35-bfd6-19b89ceee981.png)

Figure 3.2: Training Progress Graph

Accuracy = 	(TP + TN) / (TP + FP + FN + TN)
		(30 + 23) / (30 + 9 + 4 + 23)
		53 / 66
		0.80303030303

Recall = 	TP / (TP + FN)
		30 / (30 + 4)
		30 / 34
		0.88235294117

Specificity =	TN / (TN + FP)
		23 / (23 + 9)
		23 / 32
		0.71875

![image](https://user-images.githubusercontent.com/54830217/212810822-3f271400-fccd-4b46-8ee2-fe6e30319ecd.png)

Figure 3.3: Confusion Matrix

3.2 Deep learning with MaxEpochs = 10, MiniBatchSize = 10, ValidationFrequency = 3
We set our algorithm values to MaxEpochs = 10, MiniBatchSize = 10, ValidationFrequency = 3 and tested our deep learning prediction model.

![image](https://user-images.githubusercontent.com/54830217/212810805-b0f98395-923e-4461-9368-e0591eccd087.png)
 
Figure 3.4: Training Progress Graph

Accuracy = 	(TP + TN) / (TP + FP + FN + TN)
		(21 + 28) / (21 + 28 + 13 + 4)
		49 / 66
		0.74242424242

Recall = 	TP / (TP + FN)
		21 / (21 + 13)
		21 / 34
		0.61764705882

Specificity =	TN / (TN + FP)
		28 / (28 + 4)
		28 / 32
		0.875
 
![image](https://user-images.githubusercontent.com/54830217/212810762-65cedc1e-e4a4-4d48-ae4b-1a832563fd67.png)

Figure 3.5: Confusion Matrix
