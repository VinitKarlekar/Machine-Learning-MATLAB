#Linear Regression Models
Linear regression is one of the simplest—but most powerful—regression techniques. It is a parametric regression technique in which the response is modeled as some known formula given in terms of the predictor variables.
For example, you could fit a linear regression model to the fuel economy data using the following formula.
sample equation
In this model, the fuel economy is the response whereas the weight, horse power, and axle ratio are the predictor variables.
The fitting process finds the coefficients c0, c1, c2, and c3 that minimize the prediction error.

#Fitting Linear Regression Models
Use the function fitlm to fit a linear regression model.
>> mdl = fitlm(data,"modelspec")

Outputs
 mdl	          A regression model variable containing the coefficients and other information about the model.
Inputs
 data	          A table containing the data used to fit the regression model. See below for details.
"modelspec"       Specification of the regression model. See below for details.

#How to Organize the Data

In a regression model, the relationship between the predictors and the response can be described by the following formula.

	The first input to fitlm is a table containing the predictors and the response. By default, fitlm uses the last column as the response and all other columns as predictors.

How to Specify the Regression Model
When modeling a linear regression, you can apply different functions to the predictive variables. As the second input to fitlm, you can use one of the predefined models or you can specify a model by providing a formula in Wilkinson–Rogers notation.



#Common predefined models:

Model name	                 Meaning
"linear"	                Intercept and linear terms for each predictor.
"interactions"	            Intercept, linear terms, and all products of pairs of distinct predictors (no squared terms).
"quadratic"              	Intercept, linear terms, interactions, and squared terms.


#Operator	       Meaning	                                           Example
+	                Include this term.	                               "y ~ x1+x2" includes the intercept term, x1, and x2:
y = c0 + c1 x1 + c2 x2
-	                Exclude this term.	                               "y ~ x1+x2-1" excludes the intercept term:
                                                                        y = c1 x1 + c2 x2
*	                Include product and all lower-order terms.	       "y ~ x1*x2" includes the intercept term, x1, x2, and x1*x2:
                                                                        y = c0 + c1 x1 + c2 x2 + c3 x1 x2
:	                Includes the product term only.                    "y ~ x1:x2" includes only x1*x2:
                                                                        y = c1 x1 x2
^	                Include power and all lower-order terms.	       "y ~ (x1^2)+(x2^2)" includes the intercept, x1, x2, x1^2, 
                                                                        and x2^2:
                                                                        y = c0 + c1 x1 + c2 x2 + c3 x12 + c4 x22


#Fitting a Line
Instructions are in the task pane to the left. Complete and submit each task one at a time.

This code loads and plots the data.
load data
whos data dataTrain dataTest
plot(data.x,data.y,".")

#Task1
The table data has been split into a training set, dataTrain, and a test set, dataTest.

You can create a linear regression model using the following syntax:
mdl = fitlm(trainingData)
Task
Create a regression model named mdl using the training data.
Code:- mdl = fitlm(dataTrain);

#Task2

You can use the predict function to predict the response on your test data.
predictions = predict(linearMdl,testData)
Task
Use mdl to predict the response on the test data. Name the predicted response yPred.
Code:- yPred = predict(mdl,dataTest);


#Quiz
(T/F) With linear regression, you may only model a straight line
False
 By default, the model is a linear combination of all predictor variables. You can specify higher-order models by providing a model-specification string.



#Fitting a Polynomial
Instructions are in the task pane to the left. Complete and submit each task one at a time.

This code loads the data.
load data
whos data dataTrain dataTest

#Task1
The table data has been split into a training set, dataTrain, and a test set, dataTest.
Task
Create a linear regression model named mdl which fits a line to the training data. Then, use the model to predict the response on the test data and name it yPred.
Code:- mdl = fitlm(dataTrain)
yPred = predict(mdl,dataTest);


#Task2
Task
Modify your code so that mdl fits a quadratic polynomial to the training data.
Code:-mdl = fitlm(dataTrain,"quadratic")
yPred = predict(mdl,dataTest);

#Task3
Notice the cluster of outliers in the upper left of the plot. You can reduce the influence of the outliers on the model by setting the "RobustOpts" property to "on".
Task
Modify your code so that the influence of the outliers on the model mdl is reduced.
Code:- mdl = fitlm(dataTrain,"quadratic","RobustOpts","on")
yPred = predict(mdl,dataTest);








#Multivariable Linear Regression
Instructions are in the task pane to the left. Complete and submit each task one at a time.

This code loads the data and displays the table variable names.
load data
whos data dataTrain dataTest
data.Properties.VariableNames

#Task1
The table data has three predictor variables (x1, x2, x3) and one response (y). It has been split into training and test sets: dataTrain and dataTest.
Task
Create a regression model named mdl fitting the training data. Use a linear combination of the predictor variables for the model. Then predict the response on the test data and name it yPred.
Code:- mdl = fitlm(dataTrain)
yPred = predict(mdl,dataTest);

#Task2
You can find a reference for Wilkinson–Rogers notation in the documentation.
Task
Modify your code so that mdl fits a model where the response y is a function of x1, x1^2, and x3.
Code:-
mdl = fitlm(dataTrain,"y ~ x3 + x1^2")
yPred = predict(mdl,dataTest);












#Fitting Models Using Data Stored in Arrays
If your data is stored in numeric arrays instead of a single table, you can provide the fitlm function the predictor and response values as numeric arrays.
>> mdl = fitlm(X,y)

Outputs
  mdl	        Linear regression model variable.
Inputs
 X               Predictor values, specified as a numeric matrix.
 y	            Response values, specified as a vector.

#How to Specify the Regression Model
Each column of the predictor matrix X is treated as one predictor variable. By default, fitlm will fit a model with an intercept and a linear term for each predictor (column).

To fit a different regression formula, you have two options. You can store the predictors and the response in a table and provide the model specification separately. Alternatively, you can create a matrix with a column for each term in the regression formula. This matrix is called a design matrix.

#Fitting with Numeric Arrays
Instructions are in the task pane to the left. Complete and submit each task one at a time.

This code loads the data.
load data
whos 

#Task1
The data set for this interaction is provided as numeric arrays rather than a table.

X is a matrix containing the values for predictor variables x1, x2, and x3, and y is a vector containing the response values.
The data set is divided into a training set, XTrain and yTrain, and a test set, XTest and yTest.
Task
Create a regression model named mdl fitting the training data. Use a linear combination of the predictor variables for the model.
Code:- mdl = fitlm(XTrain,yTrain)

#Task2
When you provide training data to fitlm as a numeric array, each column represents a term in the regression formula. This matrix is the design matrix.

For example, suppose X contains two columns with data for predictor variables x
1
 and x
2
. You can create a design matrix for a regression formula with terms x1, x2, and x2.
X2 = [X X(:,2).^2]
Task
Create a matrix XTrain13 to represent a regression formula for the training data with terms x1, x3, and x1 * x3.
Then create a regression model named mdl13 which fits the training data, using the model.
Code:- XTrain13 = [XTrain(:,1),XTrain(:,3),XTrain(:,1).*XTrain(:,3)];
mdl13 = fitlm(XTrain13,yTrain)




#Fuel Economy Analysis
Instructions are in the task pane to the left. Complete and submit each task one at a time.

This code loads the data.
load carEcon
whos carData carTrain carTest

Task1
The table carData has been split into a training set, carTrain, and a test set, carTest. The response variable is "FuelEcon".
Task
Create a multivariate linear model named mdl with the training data. Then, use the model to predict the values, econPred.
Code:- mdl = fitlm(carTrain);
econPred = predict(mdl,carTest);

#Task2
Task
Modify your code so that the model mdl uses "cauchy" for the "RobustOpts" property value.
Code:- mdl = fitlm(carTrain,"RobustOpts","cauchy");
econPred = predict(mdl,carTest);

