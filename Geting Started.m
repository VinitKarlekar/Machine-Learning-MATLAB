Review Machine Learning ONramp
Import Data is been Done
Group and merge Data is been done 
Explore Data Done
Train A Model data and Predictions is been done

# Evaluate the model and iterate

Task1 
{Q}
By default, fitcknn fits a kNN model with k = 1. That is, the model uses the class of the single closest "neighbor" to classify a new observation.
The models performance may improve if the value of k is increased – that is, it uses the most common class of several neighbors, instead of just one.

You can change the value of k by setting the "NumNeighbors" property when calling fitcknn.
mdl = fitcknn(table,"ResponseVariable", ...
    "NumNeighbors",7)

Task
Modify the fitcknn function call on line 3. Set the "NumNeighbors" property to 5.

Code :-
Load data
Load the basketball player statistics (per minute) data set.

load bballTrainingData.mat
whos

Train kNN model
Fit a kNN classification model to the training data.
knnmodel = fitcknn(dataTrain,"pos","NumNeighbors",5)

Task2
{Q}
Using 5 nearest neighbors reduced the loss, but the model still misclassifies over 50% of the test data set.

Many machine learning methods use the distance between observations as a similarity measure. Smaller distances indicate more similar observations.

In the basketball data set, the statistics have different units and scales, which means some statistics will contribute more than others to the distance calculation. Centering and scaling each statistic makes them contribute more evenly.

By setting the "Standardize" property to true in the fitcknn function, each column of predictor data is normalized to have mean 0 and standard deviation 1, then the model is trained using the standardized data.
Task
Modify line 3 again. Add to the fitcknn function call to also set the "Standardize" property to true


Code :-
Train kNN model
Fit a kNN classification model to the training data.
knnmodel = fitcknn(dataTrain,"pos","NumNeighbors",5,"Standardize",true);