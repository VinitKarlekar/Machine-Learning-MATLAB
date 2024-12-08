
#Cross Validation
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code calculates the loss using holdout validation.
load pumpFeatures
T
cv = cvpartition(size(T,1),"HoldOut",0.2);
dataTrain = T(cv.training,:);
dataTest = T(cv.test, :);
holdoutMdl = fitcdiscr(dataTrain,"faultCode");
holdoutLoss = loss(holdoutMdl,dataTest)


#Task1
You can use the cvpartition function to create a k-fold cross-validation partition of the data.
pt = cvpartition(table.Response,...
    "KFold",k);
Task
Create a five-fold cross-validation partition named cvpt of the data in table T. The response is the table variable faultCode.
Code :- Task1 
cvpt = cvpartition(T.faultCode,"KFold",5)


#Task2
You can pass a partition to model-creation functions, such as fitcknn or fitcdiscr, using the "CVPartition" option.
Task
Create a discriminant analysis model named mdl for the data in table T. Use the cross-validation partition cvpt.
Code:- 
mdl = fitcdiscr(T,"faultCode","CVPartition",cvpt)

#Task3
To evaluate a cross-validated model, use the kfoldLoss function on the model. Note that function names are case-sensitive.
Task
Calculate and save the loss to kfLoss.
Code:- kfLoss = kfoldLoss(mdl)


#Task

You can also fit a cross-validated model without explicitly creating a partition. The following code fits a model with leave-one-out validation.

mdl = fitcknn(table,"Response",...
    "Leaveout","on");
Task
Create a discriminant analysis model named mdl2 for the data in table T that uses leave-one-out validation. Then calculate and save the loss of the leave-one-out model to kfLoss2.
Code:- mdl2 = fitcdiscr(T,"faultCode","Leaveout","on");
kfLoss2 = kfoldLoss(mdl2)

#Quiz
Given a data set with a small number of observations, which validation method will generally give the most reliable model?
leave-one-out validation. ; Smaller data sets do well with larger values of k. The largest value of k is used for leave-one-out validation.