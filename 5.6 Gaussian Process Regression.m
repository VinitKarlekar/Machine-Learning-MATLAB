#Gaussian Process Regression
Gaussian process regression (GPR) is another nonparametric regression technique.
In addition to predicting the response value for given predictor values, GPR models optionally return the standard deviation and prediction intervals

#Fitting and Predicting Using Gaussian Process Regression
Fitting GPR Models
You can fit a GPR model by using the fitrgp function.

>> mdl = fitrgp(data,"ResponseVarName")

Outputs
mdl	                A GPR model variable.
Inputs
data	            A table containing the predictor and response values.
"ResponseVarName"	Name of the response variable.


Use the "KernelFunction" property to change the kernel to one of the predefined options.

mdl = fitrgp(data,"ResponseVarName","KernelFunction","exponential")    
Predicting the Response

In addition to the predicted response values, the predict function for GPR models can also return the standard deviation and prediction intervals for the predicted values.
>> [yPred,yStd,yInt] = predict(mdl,dataNew)

Outputs
yPred	    Predicted response value(s).
yStd	    Standard deviation for each predicted value.
yInt	    Matrix whose columns contain the lower and upper limits of the 95% prediction interval for each predicted value.

Inputs
mdl	        A GPR model variable.
dataNew	    Predictor values for one or more new observations.


You can change the significance level of the prediction intervals by setting the "Alpha" property to a value between 0 and 1. The default value is 0.05.
  [yPred,yStd,yInt] = predict(mdl,dataNew,"Alpha",0.01)
    

#Fitting a GPR Model
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads the data.
load data
whos data dataTrain dataTest

#Task1
The table data has been split into training and test sets: dataTrain and dataTest. The response variable is "y".

You can use the function fitrgp to fit a model using Gaussian process regression.
gpMdl = fitrgp(data,"ResponseName")

The predict and loss functions can be used to predict the response and calculate the loss of the predictions, respectively.
preds = predict(gpMdl,data)
mdlLoss = loss(gpMdl,data)
Task
Create a GPR model named mdl using the training data. Then, use the model to predict the response for the test data and name it yPred. Calculate the loss, or mean squared error, of the predictions and name it mdlMSE.
Code:- mdl = fitrgp(dataTrain,"y");

yPred = predict(mdl,dataTest);
mdlMSE = loss(mdl,dataTest)


#Fitting Data with Outliers
Instructions are in the task pane to the left. Complete and submit each task one at a time.

This code loads the data.
load data
whos data dataTrain dataTest

Task1
The table data has been split into training and test sets: dataTrain and dataTest. The response variable is "y".
Task
Create a Gaussian process regression model fitting the training data and name it mdl. Use the model to predict the response and prediction intervals, yPred and yInt
Code:- mdl = fitrgp(dataTrain,"y");
[yPred,~,yInt] = predict(mdl,dataTest);


#Fuel Economy - GPR
Instructions are in the task pane to the left. Complete and submit each task one at a time.

This code loads the data.
load carEcon
whos carData carTrain carTest

#Task1
The table carData has been split into training and test sets: carTrain and carTest. The response variable is "FuelEcon".
Task
Create a Gaussian process regression model with the training data and name it mdl.
Code:- mdl = fitrgp(carTrain,"FuelEcon");
