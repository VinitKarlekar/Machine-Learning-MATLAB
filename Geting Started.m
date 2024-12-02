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

