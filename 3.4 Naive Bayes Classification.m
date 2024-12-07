##Naive Bayes
Observations being classified using naive bayes.
kNN models and decision trees do not make any assumptions about the distribution of the underlying data.
If we assume the data set comes from an underlying distribution, we can treat the data as a statistical sample. This can reduce the influence of the outliers on our model.
A naïve Bayes classifier assumes the independence of the predictors within each class. This classifier is a good choice for relatively simple problems.

##Naïve Bayes Overview
Function         fitcnb
Performance      Fit Time                     Prediction Time                 Memory Overhead
                 Normal Dist. - Fast          Normal Dist. - Fast             Normal Dist. - Small
                 Kernel Dist. - Slow          Kernel Dist. - Slow             Kernel Dist. - Moderate to large
 
Common Properties  
                "DistributionNames" – Distribution used to calculate probabilities.
                "Width" – Width of the smoothing window (when "DistributionNames" is set to "kernel").
                "Kernel" – Type of kernel to use (when "DistributionNames" is set to "kernel").

Special Notes    Naive Bayes is a good choice when there is a significant amount of missing data.


##Quiz
(T/F) The predictor distributions are, by default, assumed to be uniform for naïve Bayes classification.
The predictor distributions are, by default, modeled as Gaussian, or normal.

##Naive Bayes Classification
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads the pump features and partitions it into training and testing
load pumpFeatures
rng(0)
cv = cvpartition(size(T,1), "HoldOut", 0.3);
dataTrain = T(cv.training,:);
dataTest = T(cv.test, :)

#Task1

To construct a naive Bayes classifier, use the fitcnb function.
nbModel = fitcnb(tableData,...
    "ResponseVariable")
Task
Create a naive Bayes classifier named mdlNB using the training data with the response variable named "faultCode".
Code:- Task 1
mdlNB = fitcnb(dataTrain,"faultCode")

Evaluate model
evalModel(dataTest, mdlNB)

##Task2
By default, the numeric predictors are modeled as normal (Gaussian) distributions, with estimated means and standard deviations. However, the assumption of normality may not always be appropriate. You can change the distribution using the "DistributionNames" property.
nbModel = fitcnb(trainingData,...
    "ResponseVariable",...
    "DistributionNames",distName);
Task
Create a naive Bayes classifier named mdlNB. Change the distribution to use "kernel".
Code:- Task 2
mdlNB = fitcnb(dataTrain,"faultCode","DistributionNames","kernel")

Evaluate model
evalModel(dataTest, mdlNB)

#Task3

Sometimes you may want to use different distributions for different variables. In this case, you can set the "DistributionNames" property using an array of distribution names.
 nbModel = fitcnb(trainingData,"Response",...
 "DistributionNames",["kernel","mvmn","mvmn"]);
You can use the repmat function to create a string array with repeated values.
d = repmat("kernel",1,2)
d = 
    "kernel"    "kernel"
Task
Create a naive Bayes classifier named mdlNB. Set the "DistributionNames" property to use "normal" for the first 28 variables, which relate to the motor, and "kernel" for the last 56 variables.
Code:- Task3
dists = [repmat("normal",1,28),repmat("kernel",1,56)]
mdlNB = fitcnb(dataTrain,"faultCode","DistributionNames",dists)
Evaluate model
evalModel(dataTest, mdlNB)


##Naive Bayes Countries
Instructions are in the task pane to the left. Complete and submit each task one at a time.
Load data from file. 
load citydata.mat
cities
Fit a default Naive Bayes classifier and visualize boundaries for later comparison.
mdlNB = fitcnb(cities,"Country");
plotBoundaries(mdlNB)

Tasks 1 & 2
mdl = fitcnb(cities,"Country", ...
    "DistributionNames","kernel", ...
    "Kernel","epanechnikov");
plotBoundaries(mdl) 
#Task1
Naive Bayes relies on the assumption that data follows a normal distribution. For cases where we can't make this assumption, using a kernel estimator is a good choice. You can do this by setting the "DistributionNames" to "kernel" to see how the boundaries are affected.
Task
Set the "Kernel" to normal. Notice what occurs in the border between Belgium, Germany, and France.

#Quiz
Which of the following properties is not associated with multiclass naive Bayes models?
Ans:- Three of the above properties are associated with fitcnb and one is associated with fitctree.
