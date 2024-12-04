##Fitting Different Classification Models

Fitting a model
You can use the function fitc___  (replace ___ by the name of the classifier) to fit a classifier.
For example, the following syntax creates a k-nearest neighbor (kNN) classification model.
>> knnModel = fitcknn(tbl,"response")

Customizing a model
Often, because of the prior knowledge you have about the data or after looking at the classification results, you may want to customize the classifier. You can update and customize the model by setting different options using the fitting functions.
Set the options by providing additional inputs for the option name and the option value.
>> model = fitc___(tbl,"response","optionName",optionValue)


Fitting Models Using Data Stored in Arrays
If your data is stored in a matrix, you do not have to convert it into a table to use the fitting functions.
You can provide the predictors and response values in a matrix and vector respectively.
>> knnModel = fitcknn(X,y)

##Classification Workflow
Instructions are in the task pane to the left. Complete and submit each task one at a time.
Load the pump features from pumpFeatures.
load pumpFeatures
Partition into training and testing
rng(0)
cv = cvpartition(size(T,1),"HoldOut",0.3);
dataTrain = T(cv.training,:);
dataTest = T(cv.test, :)

#Task1
To construct a classifier in MATLAB, use the fitc___ function, replacing ___ with the name of the classifier. The inputs should be the data table and the name of the response variable.
For example, the following syntax creates a k-nearest neighbor (kNN) classification model.
mdl = fitcknn(tableData,...
    "ResponseVariable");
Task
Construct a k-nearest neighbor classifier named mdl using the function fitcknn. Train the model using dataTrain with the response variable faultCode.
Code:- Task1
mdl = fitcknn(dataTrain,"faultCode")


##Task2
The predict function determines the predicted class of new observations.
predClass = predict(mdl,testData);
Task
Predict the groups for the data in dataTest. Assign the result to a variable named preds.
Code:- Task2
preds = predict(mdl,dataTest)

##Task3
What proportion of points have been misclassified?
You can use the function loss to evaluate how well a model classifies the data.
err = loss(mdl,testData)
The output consists of the inaccuracy of the classification model on the test data, a lower loss indicates a better predictive model.
Task
Calculate the loss for the test data dataTest, and assign it to a variable named err.
Code:- Task3
err = loss(mdl,dataTest)

##Task4
To visualize how the algorithm classified the observations, you can use the function confusionchart.
confusionchart(trueLabels,predictions)
The result is a confusion matrix showing the number of observations for each combination of true and predicted class.
Task
Use confusionchart to compare the predicted values preds to the known labels (stored in the variable faultCode in the table dataTest) .
Code:- Task4
confusionchart(dataTest.faultCode,preds)