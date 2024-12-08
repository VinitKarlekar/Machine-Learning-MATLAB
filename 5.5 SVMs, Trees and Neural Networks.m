#egression using SVMs, Decision Trees, and Neural Networks
Linear regression techniques like fitlm are parametric, which means predictions are based on a finite set of parameters that are estimated from the training data.

A parametric regression model:
Assumes a relationship that can be specified using a formula.
Is easy to interpret – you can measure the change in the response per unit change in the predictor.

You may not need a model with a specific interpretable formula if its primary purpose is simply to predict the response for unknown observations. In this case, you can use a nonparametric model.

A nonparametric regression model:
Does not fit the regression model based on a given formula.
Can provide more accurate predictions, but is more difficult to interpret.


#Support vector machines (SVMs), decision trees, and neural networks are some of the nonparametric techniques you can use for regression.

fitrtree	Fit binary regression decision tree.
fitrsvm	Fit a support vector machine regression model.
fitrnet	Fit a neural network for regression.

These techniques are covered in detail in the Classification Methods chapter. You can find information specific to regression in the documentation.

#Tree and SVM Models
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads the data.
load data
whos data dataTrain dataTest

#Task1
The table data has been split into a training set, dataTrain, and a test set, dataTest. The response variable is "y".
You can fit a nonparametric model using a decision tree.
mdl = fitrtree(table,"ResponseName")
You can use the loss function to evaluate the model on test data. By default, it calculates the mean squared error between the model predictions and the response.
tLoss = loss(mdl,testTable)

The predict function can predict responses for new data.
preds = predict(mdl,data)
Task
Create a decision tree model named treeMdl using the training data.
Calculate the model loss for the test data and name it treeLoss.
Then, use the model to predict the response for the test data and name it yPred.
COde:- treeMdl = fitrtree(dataTrain,"y");
treeLoss = loss(treeMdl,dataTest)
yPred = predict(treeMdl,dataTest);


#Task2
You can use the function fitrsvm to fit an SVM model.
mdl = fitrsvm(table,"ResponseName")
Task
Create an SVM model named svmMdl using the training data. Calculate the loss svmLoss and find the predicted response yPred for the test data.
Code:-svmMdl = fitrsvm(dataTrain,"y");
svmLoss = loss(svmMdl,dataTest)
yPred = predict(svmMdl,dataTest);

#Task3
You can set optional properties when you train the model. For example, the fitrsvm function has the property "KernelFunction" whose default value is "linear".
svmMdl = fitrsvm(table,"ResponseName",...
    "PropertyName",PropertyValue)
Task
Create another SVM model named svmMdl2 which uses a "polynomial" kernel function. Calculate the loss svmLoss2. Again, find the predicted response yPred for the test data
COde:- svmMdl2 = fitrsvm(dataTrain,"y","KernelFunction","polynomial");
svmLoss2 = loss(svmMdl2,dataTest)
yPred = predict(svmMdl2,dataTest);


#Task4
You can use the function fitrnet to fit a neural network for regression. If your data is not normalized, you should set the property "Standardize" to true.
mdl = fitrnet(table,"ResponseName",...
    "Standardize",true)
Task
Create neural network named netMdl using the training data. Calculate the loss netLoss and find the predicted response yPred for the test data.
COde:- netMdl = fitrnet(dataTrain,"y","Standardize",true);
netLoss = loss(netMdl,dataTest)
yPred = predict(netMdl,dataTest);

#Quiz
(Select all that apply) Which of the following functions create nonparametric regression models?
Ans = The regression functions that start with fitr create nonparametric models. fitcnb creates a naive bayes classification model, and fitlm creates a parametric regression model.


#Choosing a Model
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads and plots the data.
load data
whos data dataTrain dataTest
plot(data.x,data.y,".")

#Task1
The table data has been split into a training set, dataTrain, and a test set, dataTest. The response variable is "y".
Task
Create a tree, SVM, or neural network regression model fitting the training data, name it mdl. Try to get the loss value below 0.15.
Code:- mdl = fitrsvm(dataTrain,"y","KernelFunction","gaussian")



#Fuel Economy Analysis - Tree
Instructions are in the task pane to the left. Complete and submit each task one at a time.

This code loads the data.
load carEcon
whos carData carTrain carTest

#Task1
The table carData has been split into a training set carTrain and a test set carTest. The response variable is "FuelEcon".
Task
Create a decision tree regression model with the training data and name it mdl. Calculate the loss of the model and name it mdlLoss.

Use the model to predict the test values and store the predictions in a variable named econPred.
Code:- mdl = fitrtree(carTrain,"FuelEcon");

mdlLoss = loss(mdl,carTest)
econPred = predict(mdl,carTest);

#Task2
The prune function can be used to reduce overfitting.
treeMdl = prune(treeMdl,"Level",n)
Task
Modify your code to prune mdl to level 10.
COde:- mdl = fitrtree(carTrain,"FuelEcon");
mdl = prune(mdl,"Level",10);

mdlLoss = loss(mdl,carTest)
econPred = predict(mdl,carTest);

#Task3
The "MinLeafSize" property sets the minimum number of observations in each leaf node.
Task
Modify your code again. Remove the pruning step, and instead update mdl to set the "MinLeafSize" property to 5.



#Fuel Economy Analysis - SVM
Instructions are in the task pane to the left. Complete and submit each task one at a time.

This code loads the data.
load carEcon
whos carData carTrain carTest

#Task1
The table carData has been split into a training set carTrain and a test set carTest. The response variable is "FuelEcon".
Task
Create an SVM regression model with the training data and name it mdl. Use a polynomial kernel function.

Calculate the loss of the model and name it mdlLoss. Use the model to predict the response for the test values, and store the predictions in a variable named econPred.
COde:- mdl = fitrsvm(carTrain,"FuelEcon","KernelFunction","polynomial");

mdlLoss = loss(mdl,carTest)
econPred = predict(mdl,carTest);

#Task2
Notice that the fit is particularly poor. This can happen when predictors have different scales. Standardizing the data before fitting can improve the quality of the fit.
Task
Modify your code to set an option in fitrsvm which will standardize the variables in carTrain before fitting the regression model.
Code:- mdl = fitrsvm(carTrain,"FuelEcon","KernelFunction","polynomial",...
    "Standardize",true);

mdlLoss = loss(mdl,carTest)
econPred = predict(mdl,carTest);


#Fuel Economy Analysis - SVM
Instructions are in the task pane to the left. Complete and submit each task one at a time.

This code loads the data.
load carEcon
whos carData carTrain carTest
rng(1)

#Task1
The table carData has been split into a training set carTrain and a test set carTest. The response variable is "FuelEcon".
Task
Create a neural network for regression model with the training data and name it mdl. Make sure you standardize the data.

Calculate the loss of the model and name it mdlLoss. Use the model to predict the response for the test values, and store the predictions in a variable named econPred.
COde:- 
mdl = fitrnet(carTrain,"FuelEcon","Standardize",true);

mdlLoss = loss(mdl,carTest)
econPred = predict(mdl,carTest);

#Task2
By default, fitrnet creates a network with one hidden layer with 10 neurons. You can change the number of neurons in each hidden layer by using the property "LayerSizes".
Task
Modify your code to set an option in fitrnet so that the network has 5 neurons in the hidden layer.
Code:-
mdl = fitrnet(carTrain,"FuelEcon","Standardize",true,...
    "LayerSizes",5);

mdlLoss = loss(mdl,carTest)
econPred = predict(mdl,carTest);