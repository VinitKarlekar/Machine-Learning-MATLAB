#Hyperparameter Optimization
You can modify the properties of a machine learning model to try to improve model performance.
For example, you can change a kNN model to use 5 nearest neighbors instead of 1, then calculate the loss of the new model.

The process usually consists of repeatedly training the model with a variety of property values, and choosing the combination that produces the best accuracy. mdl = fitcknn(data,"y");
mdlLoss = loss(mdl,dataTest)

mdlLoss =
    0.1738


mdl2 = fitcknn(data,"y","NumNeighbors",5);
mdlLoss2 = loss(mdl2,dataTest)
mdlLoss2 =
    0.0916

    These properties are often called hyperparameters. Hyperparameters can have a large impact on the performance of a model, but it’s typically time consuming or difficult to find the optimal hyperparameter values.

    In order to efficiently set all the properties at once, you can perform hyperparameter optimization. Hyperparameter optimization allows you to select a subset of the model's properties and find the optimal settings for a specific data set.


#Performing Hyperparameter Optimization
You can use the "OptimizeHyperparameters" property name-value pair to choose which model properties to optimize. Most model-creation functions accept the "OptimizeHyperparameters" option.

>> mdl = fitcknn(data,"ResponseName","OptimizeHyperparameters",params)    

#Outputs
mdl	             Model fit using
optimized        property values.

Inputs
data,"ResponseName"             	Table of predictors and response values and response variable name.
"OptimizeHyperparameters"	        Optional property for hyperparameter optimization.
params	                            Model properties to optimize, specified as a string array or cell array. Using "auto" and "all" optimizes pre-selected properties.


During the optimization, iterative updates are displayed, as well as a plot with the best objective function value against the iteration number.
mdl = fitcknn(data,"y","OptimizeHyperparameters","auto")

Setting the "OptimizeHyperparameters" property value to "auto" will optimize a typical set of hyperparameters. The properties optimized differ depending on the model type. For example, for Nearest Neighbor classification, the optimized properties are "Distance" and "NumNeighbors".
Optimization Options

By default, hyperparameter optimization uses Bayesian optimization and tries to minimize the 5-fold cross-validation loss. You can change these settings with the "HyperparameterOptimizationOptions" property name-value pair.

Specify the optimization options using a structure. To use 10-fold cross validation, create a cross-validation partition and then create a structure containing option name-value pairs.

part = cvpartition(y,"KFold",10);
opt = struct("CVPartition",part);
mdl = fitcknn(data,"y","OptimizeHyperparameters","auto","HyperparameterOptimizationOptions",opt);

You can set many optimization options in the structure. For example, you can hide the plots and set the maximum number of objective function evaluations.
opt = struct("ShowPlots",false,"MaxObjectiveEvaluations",50);

To see the available options for a particular model-creation function, view the function's documentation.

#Optimize Parameters
This code loads and partitions the data.
load pumpFeatures.mat
rng(0)
cv = cvpartition(T.faultCode,"Holdout",0.2);
dataTrain = T(cv.training,:)
dataTest = T(cv.test,:);
This code fits a tree model to the training data and calculates the loss.
holdoutMdl = fitctree(dataTrain,"faultCode");
trainLoss = resubLoss(holdoutMdl)
testLoss = loss(holdoutMdl,dataTest)


#Task
Create a 10-fold cross-validation partition named cvpt of the training data dataTrain.faultCode.
Then use the struct function to create a structure named opt which sets the following optimization options:
Set "CVPartition" to cvpt.
Set "MaxObjectiveEvaluations" to 25.