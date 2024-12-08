#Regularized Linear Regression
When a data set has a large number of predictors, choosing the right parametric regression model can be a challenge. Including all the predictors can create an unnecessarily complicated model, and some of the predictors can be correlated.
Fitting a linear regression model to this kind of data can result in coefficients with large variance. That is, the coefficients' values change by a large amount with slight changes in the training data.

Regularization

Regularized linear regression models shrink the regression coefficients by applying a penalty for large coefficient values. This reduces the variance of the coefficients and can create models with smaller prediction error.

#Ridge and Lasso Regression
In linear regression, the coefficients are chosen by minimizing the mean squared error (MSE). Mean squared error is the squared difference between the observed and the predicted response value.
In ridge and lasso regression, a penalty term is added to MSE.

This penalty term is composed of the fit coefficient values and a tuning parameter λ. The larger the value of λ, the greater the penalty and, therefore, the more the coefficients are “shrunk” towards zero.

#The Penalty Term
The difference between the two methods is how the penalty term is calculated. Ridge regression uses an L2 norm of the coefficients. Lasso uses an L1 norm.

The use of different norms provides different regularization behavior.

Ridge regression shrinks coefficients continuously, and keeps all predictors.
Lasso allows coefficients to be set to zero, reducing the number of predictors included in the model.

Lasso can be used as a form of feature selection, however feature selection may not be appropriate for cases with similar, highly correlated variables. It may result in loss of information which could impact accuracy and the interpretation of results. Ridge regression maintains all features, but the model may still be very complex if there is a large number of predictors.

Elastic Net
You can also use a penalty term that uses a weighted average of both. This is elastic net regression, which introduces another parameter – the weighting between ridge (L2 norm) and lasso (L1 norm).



#Fitting Ridge Regression Models
You can use the function ridge to fit a ridge regression model.

>> b = ridge(y,X,lambda,scaled)

Outputs
b	           Ridge regression coefficients.

Inputs
y	           Response values, specified as a vector.
X	           Predictor values, specified as a numeric matrix.
lambda	       Regularization parameter.
scaled	       A {0,1}-valued flag to determine if the coefficient estimates in b are restored to the scale of the original data.

Notes
The matrix X is a numeric design matrix with columns representing the terms in the regression formula. If the original data contains two predictive variables x1 and x2, but the desired regression model formula contains the terms x1, x2, and x1*x2, the matrix X should have 3 columns: x1, x2, and x1*x2.
The ridge parameter lambda is a non-negative number. In a later section, you will try to estimate the optimum value of lambda.
The ridge function normalizes the predictors before fitting the model. Therefore, by default, the regression coefficients correspond to the normalized data. Set the scaled flag to 0 to restore the coefficients to the scale of the original data.



Predicting Response using Ridge Regression Models
When using a ridge regression model for predictions, you will want the regression coefficients in the scale of the original data. In this case (the scaled flag set to 0), the coefficient vector b will contain n+1 coefficients for a model with n predictors. The first element of b corresponds with the intercept term.
You can predict the response by multiplying the matrix containing the predictors and the last n elements of the coefficient vector. Add the first element of the coefficient vector to incorporate the intercept in the calculation.


yPred = dataNew*b(2:end) + b(1);


#Determining the Regression Parameter
When modeling data using ridge regression, how can you determine the regression parameter, lambda?
When you provide a vector of λ values to the ridge function, the output b is a matrix of coefficients.

    b = ridge(y,X,lambda,scaled);

The columns of b contain the coefficient values for each parameter in the vector lambda.
 schematic for a lambda vector

You can now use each column of the matrix b as regression coefficients and predict the response.
yPred = dataNew*b(2:end,:) + b(1,:);
The response yPred is a matrix where each column is the predicted response for the corresponding value of lambda. You can use yPred to calculate the mean squared error (MSE), and choose the coefficients which minimize MSE.


#Fitting a Ridge Regression Model
Instructions are in the task pane to the left. Complete and submit each task one at a time.

This code loads and plots the data.
load data
whos data XTrain XTest yTrain yTest
scatter3(data.X1,data.X2,data.Y)

#Task1
Training data is saved in XTrain and yTrain.
The ridge function takes the data and a vector of values for λ as inputs:
lambda = 0:10;
coef = ridge(y,X,lambda);

Setting the scaled flag to 0 returns the coefficients in the scale of the original data.
coef = ridge(y,X,lambda,0);
Task
Create a vector lambda of integers from 0 to 100. Then perform ridge regression on the training data for the values in lambda. Return the coefficients in the scale of the original data, and name the coefficients b.
Code:- lambda = 0:100;
b = ridge(yTrain,XTrain,lambda,0);

#Task2
The output b is a matrix where each column is a vector of coefficients for the corresponding value of lambda.
Task
Plot b against lambda to see how the coefficients change as λ increases.
This plot is called the ridge trace.
COde:- plot(lambda,b)
legend("intercept","X1","X2")
xlabel("\lambda")

#Task3
Notice that the coefficient of X2 is positive when λ is zero, and becomes negative as λ increases.
You can calculate the predicted response for each λ. The first row of the coefficient matrix corresponds to the intercept. Matrix multiply the predictor matrix and rows 2:end of the coefficient matrix, then add the intercept to the result.
yp = dataNew*coef(2:end,:) + coef(1,:)
Task
Predict the response for the test data XTest. Name the result yPred.
COde:-
yPred = b(1,:) + XTest*b(2:end,:);

#Task4
You can calculate the mean squared error by subtracting the actual and predicted responses, squaring each value, and taking the mean.
err = y - yp
MSE = mean(err.^2)
The result is a row vector of the mean squared error for each parameter in the vector lambda.
Task
Calculate mean squared error and name the result mdlMSE. Plot mdlMSE against lambda.
Code:- err = yPred - yTest;
mdlMSE = mean(err.^2);
plot(lambda,mdlMSE)
xlabel("\lambda")
ylabel("MSE")

#Task5
Task
Find the smallest MSE and the index where it occurs. Name the results minMSE and idx, respectively.
Code:- [minMSE,idx] = min(mdlMSE)

#Quiz
(T/F) With ridge regression, you may only model a line.
ans If you want to model a polynomial, you can provide those terms as input to the ridge function.
coef = ridge(yTrain,[xTrain xTrain.^2 xTrain.^3],lambda)






#Fitting Lasso Regression Models
Lasso (Least Absolute Shrinkage and Selection Operator) regression models are fit using the lasso function.

>> [b,fitInfo] = lasso(X,y,"Lambda",lambda)

Outputs
b	              Lasso coefficients.
fitInfo	          A structure containing information about the model.

Inputs
X	              Predictor values, specified as a numeric matrix.
y	              Response values, specified as a vector.
"Lambda"	      Property name for specifying the regularization parameter.
lambda	          Regularization parameter value.


Notes
Like in ridge, the matrix X is a design matrix with columns representing the terms in the regression formula.
The "Lambda" property is optional. If not specified, lasso uses a geometric sequence of
λ values based on the data.
ridge and lasso implement their penalty terms slightly differently, and as a result, use different scalings for lambda. To use λ values in lasso which have the same interpretation as for ridge, scale lambda in lasso by the number of observations.
Use the optional property "Alpha" with a value between 0 and 1 to create an elastic net. Recall that elastic net regression uses a penalty term which is a weighted average of the ridge (L2) and lasso (L1) penalty terms. "Alpha" values near 1 are closer to lasso, and "Alpha" values near 0 are closer to ridge.

Predicting Response using Lasso Model
You can predict the response by multiplying the matrix containing the predictors by the coefficient vector.
Note that the intercept term is not included in the output coefficients. Instead, it is a field in the output structure fitInfo.

yPred = dataNew*b + fitInfo.Intercept



#Lasso and Elastic Net Regularization
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads and plots the data.
load data
whos data XTrain XTest yTrain yTest
scatter3(data.X1,data.X2,data.Y)


#Task1
Training data is saved in XTrain and yTrain.
You can use the lasso function to perform lasso regression.
lambda = (0:10)/length(y);
[coef,fitInfo] = lasso(X,y,"Lambda",lambda);
Note that lasso uses a different scaling for lambda. Scale lambda by the number of observations to have the same interpretation as for ridge.
Task
Perform lasso regression on the training data. For λ values, create a vector lambda of integers from 0 to 100 scaled by the number of observations. Name the fit coefficients b, and save information about the model fit as fitInfo.
Code:- lambda = (0:100)/length(yTrain);
[b,fitInfo] = lasso(XTrain,yTrain,"Lambda",lambda);


#Task2
Notice that once the coefficient of X2 reaches zero, it remains zero, which means the algorithm has identified X2 as a redundant predictor. You can use the MSE to evaluate its impact on the fit.
As with ridge regression, the predicted response is calculated by matrix multiplying the predictor matrix and the coefficient matrix. The intercept is stored in the Intercept field of the fitInfo structure.
yp = fitInfo.Intercept + dataNew*coef
Task
Predict the response yPred for the test data XTest.
Calculate the mean squared error mdlMSE, and plot mdlMSE against lambda.
Find the smallest MSE and the index where it occurs. Name the results minMSE and idx, respectively.
Code:- yPred = fitInfo.Intercept + XTest*b;
mdlMSE = mean((yTest - yPred).^2);
[minMSE,idx] = min(mdlMSE)

plot(lambda,mdlMSE)
xlabel("\lambda")
ylabel("MSE")

#Task3
Task
Modify the call to the lasso function to use an alpha value of 0.4. This will perform elastic net regression
Code:- lambda = (0:100)/length(yTrain);
[b,fitInfo] = lasso(XTrain,yTrain,"Lambda",lambda,"Alpha",0.4);


#Quiz
Which property do you set to perform elastic net regression?
"Alpha" You set a scalar property in the lasso function to a value from 0 to 1 to represent the weight of lasso optimization.




#Fuel Economy - Regularized Linear Models
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads the data.
load carEcon
whos XTrain XTest econTrain econTest

#Task1
The workspace contains the numeric predictors and response for vehicle fuel economy data. The predictors for creating a model are in XTrain with corresponding response in econTrain.
Task
Perform ridge regression on the training data. Create a vector lambdaR with values 0:300 to use as λ values. Return the coefficients in the scale of the original data, and name the coefficients bR
Code:- vlambdaR = 0:300;
bR = ridge(econTrain,XTrain,lambdaR,0);


#Task2
Task
Predict the response econPredR for the test data XTest, then calculate the MSE and name it MSER. Plot MSER against lambdaR.
Find the smallest MSE and the index where it occurs, and name the results minMSER and idxR, respectively.
Code:- econPredR = bR(1,:) + XTest*bR(2:end,:);
err = econPredR - econTest;
MSER = mean(err.^2);
[minMSER,idxR] = min(MSER)

plot(lambdaR,MSER)
xlabel("\lambda")
ylabel("MSE")
title("Ridge model")


#Task3
Task
Now perform lasso regression on the training data. For λ values, create a vector lambdaL with values 0:300 scaled by the number of observations.
Name the coefficients bL, and save information about the model fit as fitInfo.
COde:- lambdaL = (0:300)/length(econTrain);
[bL,fitInfo] = lasso(XTrain,econTrain,"Lambda",lambdaL);


#Task4
For your lasso model, predict the response econPredL for the test data XTest, then calculate the MSE and name it MSEL. Plot MSEL against lambdaL.
Find the smallest MSE and the index where it occurs, and name the results minMSEL and idxL, respectively.
Code:-econPredL = fitInfo.Intercept + XTest*bL;
err = econPredL - econTest;
MSEL = mean(err.^2);
[minMSEL,idxL] = min(MSEL)

plot(lambdaL,MSEL)
xlabel("\lambda")
ylabel("MSE")
title("Lasso model")