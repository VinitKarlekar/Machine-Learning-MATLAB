##Discriminant Analysis
Observations being classified using discriminant analysis.
Similar to naive Bayes, discriminant analysis works by assuming that the observations in each prediction class can be modeled with a normal probability distribution. However, there is no assumption of independence in each predictor. Hence, a multivariate normal distribution is fitted to each class.
This lesson focuses on the discriminant analysis classifier.

##Fitting Discriminant Analysis Models
Linear Discriminant Analysis
By default, the covariance for each response class is assumed to be the same. This results in linear boundaries between classes.
 daModel = fitcdiscr(dataTrain,"ResponseVarName")
Quadratic Discriminant Analysis
Removing the assumption of equal covariances results in a quadratic boundary between classes. Use the "DiscrimType" option to do this:
 daModel = fitcdiscr(dataTrain,"ResponseVarName","DiscrimType","quadratic")

 #Discriminant Analysis (DA) Review
 Function                   fitcdiscr
 Performance                Fit Time                  Prediction Time           Memory Overhead
                            Fast                      Fast                      Linear DA - Small
                            ∝ size of the data        ∝ size of the data       Quadratic DA - Moderate to large
                                                                                ∝ number of predictor
Common Properties  
                   "DiscrimType" - Type of boundary used.
                    "Delta" - Coefficient threshold for including predictors in a linear boundary. (Default: 0)
                    "Gamma" - Regularization to use when estimating the covariance matrix for linear DA.
 
Special Notes       Linear discriminant analysis works well for “wide” data (more predictors than observations).

#Quiz
True or False: A Gaussian distribution for each class of each predictor is assumed for discriminant analysis.
A multivariate normal (Gaussian) distribution is used to model the predictors in discriminant analysis

#Discriminant Analysis
Instructions are in the task pane to the left. Complete and submit each task one at a time.
Load the pump features from pumpFeatures.
load pumpFeatures
Partition into training and testing
rng(0)
cv = cvpartition(size(T,1), "HoldOut", 0.3);
dataTrain = T(cv.training,:)
dataTest = T(cv.test, :)

#Task1
To construct a discriminant analysis classifier, use the fitcdiscr function with the table as input and specify the name of the response variable. By default, the boundaries between classes are linear.
discrModel = fitcdiscr(tableData,...
    "ResponseVariable");
Task
Create a discriminant classification model named mdlDA using the training data dataTrain with response variable "faultCode".
Code:- Task 1
mdlDA = fitcdiscr(dataTrain,"faultCode")

#Task2
Task
Call again the fitcdiscr function and modify it so that mdlDA uses "diaglinear" as the decision boundary rather than a linear one.
You can reference the documentation to see which property controls the discriminant boundary.
Code:- Task 2
mdlDA = fitcdiscr(dataTrain,"faultCode","DiscrimType","diaglinear")

#Quiz
True or False: A quadratic discriminant classifier will always give better results than a linear one. However, the calculations generally take more time.
 In some cases, a quadratic fit overfits the data and ends up worse than a linear fit.

 #Discriminant analysis needs data sufficient to fit Gaussian models with invertible covariance matrices. If your data is not sufficient, fitcdiscr will fail. To address this, you can set the "DiscrimType" to be "pseudolinear", which uses the pseudoinverse of the covariance matrix.
 Task
 Select from the dropdown pseudolinear for the "DiscrimType" property. Are there any changes in the boundaries?
 