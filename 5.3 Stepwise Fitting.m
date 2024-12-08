#Stepwise Linear Regression
When fitting linear regression models, there are infinitely many model specifications you can use.

How can you choose the model specification which creates the best model?
This problem becomes worse when you have a large number of predictors. 
Stepwise linear regression methods choose a subset of the predictor variables and their polynomial functions to create a compact model.
In this lesson, you will learn to use the function stepwiselm.
Note The stepwiselm function is used only when the underlying model is linear regression. For nonlinear regression and classification problems, use the function sequentialfs.

#Fitting Stepwise Linear Regression
Use the function stepwiselm to fit a stepwise linear regression model.

>> stepwiseMdl = stepwiselm(data,"modelspec")

Outputs
stepwiseMdl	      A linear model variable containing the coefficients and other information about the model.

Inputs
  data	          A table containing the data used to fit the regression model. See below for details.
  "modelspec"	      Starting model for the stepwise regression (see below).

  s with fitlm, stepwiselm uses the last column of data as the response and all other columns as predictors.


How to Specify a Model
stepwiselm chooses the model for you. However, you can provide the following inputs to control the model selection process.
"modelspec" - The second input to the function specifies the starting model. stepwiselm starts with this model and adds or removes terms based on certain criteria.
Commonly used starting values: "constant", "linear", "interactions" (constant, linear, and interaction terms), "quadratic" (constant, linear, interaction, and quadratic terms).

"Lower" and "Upper" - If you want to limit the complexity of the model, use these properties. For example, the following model will definitely contain the intercept and the linear terms but will not contain any terms with a degree of three or more.

  mdl = stepwiselm(data,"Lower","linear","Upper","quadratic")

By default, stepwiselm considers models as simple as a constant term only and as complex as an interaction model.
How a Model is Chosen

stepwiselm iteratively adds and subtracts terms from the starting model, if the modified model is better than the previous iteration.

“Better” is judged according to the value of the "Criterion" property. The default value is "sse" — an F-test on the sum of squared error. You can change this measure by setting the "Criterion" property.


  mdl = stepwiselm(data,"Criterion","rsquared")
    
Available values: "sse" (default), "aic", "bic", "rsquared", "adjrsquared"

#Quiz
(T/F) Whenever your predictive model is a regression model, you can use stepwiselm to perform feature selection.
False 
 The lm in stepwiselm stands for "linear model". The stepwiselm function is only good for linear regression models.


 #Fitting a Stepwise Linear Model
 Instructions are in the task pane to the left. Complete and submit each task one at a time.
 
 This code loads the data.
 load data
 whos data dataTrain dataTest.


 #Task1
 The table data has been split into a training set, dataTrain, and a test set, dataTest.

To fit a stepwise linear regression model, you can use the stepwiselm function.
lnMdl = stepwiselm(table)

You can use the predict function to predict the response on your test data.
predictions = predict(lnMdl,testData)
Task
Perform a stepwise linear fit of the training data and name it mdl. Predict the response on the test data and name the predicted response yPred.
Code:- mdl = stepwiselm(dataTrain);
yPred = predict(mdl,dataTest);


#Task2
You can use dot indexing to examine properties of the model, such as the model formula or the root mean squared error (RMSE).
lnMdl.Formula
lnMdl.RMSE
Task
Extract the model formula and name it formula.
Code:- formula = mdl.Formula

#Task3

Starting with a different model may yield a different formula. You can specify the initial model by using a second input.
lnMdl = stepwiselm(table,"modelspec")
Task
Modify your stepwise linear fit from Task 1. Provide the model spec value "purequadratic" so that the initial model has pure quadratic terms.
Code:-mdl = stepwiselm(dataTrain,"purequadratic");
yPred = predict(mdl,dataTest);




#Fuel Economy - Stepwise Linear Regression
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads the data.
load carEcon
whos carData carTrain carTest

#Task1
The table carData has been split into a training set, carTrain, and a test set, carTest. The response variable is "FuelEcon".

Use the "Lower" or "Upper" properties with a model specification value to restrict a model to a specific set of terms.
lnMdl = stepwiselm(table,...
    "Upper","modelspec")
Task
Perform a stepwise linear fit of the training data to create mdl. Limit the model to use at most a constant plus linear terms. Predict the response on the test data and name the predicted response econPred.
Code:- mdl = stepwiselm(carTrain,"Upper","linear");
econPred = predict(mdl,carTest);

#Task2
Task
Extract the root mean squared error (RMSE) of the model and name it RMSE.
Code:- RMSE = mdl.RMSE


#Task3
Task
Modify your stepwise linear fit from Task 1. Add an optional property so the model is chosen using the "aic" criterion.
Code:- mdl = stepwiselm(carTrain,"Upper","linear","Criterion","aic");
econPred = predict(mdl,carTest);

