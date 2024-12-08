#Wine Quality - Reducing Predictors
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads and displays the wine data and a trained 7-fold cross-validated quadratic DA model of redData.
rng(0)
load wineDataRed
redData
mdlFull
fullLoss = kfoldLoss(mdlFull)

#Task1
The table redData contains several features of red wine and the corresponding quality, which is saved in the QCLabel variable.
Task
Reduce the number of predictors in redData. You may use feature selection and/or feature transformation.
Create a cross-validated model of any type with the reduced data. Name the model mdl, and calculate the loss mdlLoss.
Try different models to see if you can get the loss value below 0.45, that of the full quadratic discriminant analysis model.

#Task1
The table redData contains several features of red wine and the corresponding quality, which is saved in the QCLabel variable.
Task
Reduce the number of predictors in redData. You may use feature selection and/or feature transformation.
Create a cross-validated model of any type with the reduced data. Name the model mdl, and calculate the loss mdlLoss.
Try different models to see if you can get the loss value below 0.45, that of the full quadratic discriminant analysis model.
Code:-Reduce Predictors
Fit model with fewer predictors. Target loss value less than 0.45.
Method: Feature Selection (Tree)
tModel = fitctree(redData,"QCLabel");
p = predictorImportance(tModel);

% View predictor importance on a bar plot
bar(p)
xticklabels(redData.Properties.VariableNames(1:end-1))
xtickangle(60)

% Sort out the top predictors
[~,iSorted] = sort(p);
selected = [iSorted(1:6) width(redData)];

% Create tree model to reduced data
mdl = fitctree(redData(:,selected),"QCLabel","KFold",7);
mdlLoss = kfoldLoss(mdl)
Method: Feature Transformation (PCA)
[pcs,scrs,~,~,pexp] = pca(redData{:,1:end-1});
pareto(pexp)

% Create k-NN model to reduced data
mdl = fitcknn(scrs(:,1:3),redData.QCLabel,"KFold",7);
mdlLoss = kfoldLoss(mdl)



#Classify Credit Ratings
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads and displays the credit ratings data and a 7-fold cross-validated tree model of creditRatings.
rng(0)
load creditData
creditRatings
mdlFull
fullLoss = kfoldLoss(mdlFull)

#Task1
The table creditRatings has several predictor variables and a response named Rating.
Task
Create a reduced data set with three or fewer predictor variables. You may use feature selection and/or feature transformation. Then, create a seven-fold cross-validated tree model named mdl and calculate the loss, mdlLoss.
Code:-tModel = fitctree(creditRatings,"Rating");
p = predictorImportance(tModel);

% View predictor importance on a bar plot
bar(p)
xticklabels(creditRatings.Properties.VariableNames(1:end-1))
xtickangle(60)

% Sort out the top predictors
[~,iSorted] = sort(p);
selected = [iSorted(1:2) width(creditRatings)];

% Create tree model to reduced data
mdl = fitctree(creditRatings(:,selected),"Rating","KFold",7);
mdlLoss = kfoldLoss(mdl)

#Task2
Create an ensemble of 50 seven-fold cross-validated classification trees using the bag method. Create your model with three or fewer predictors selected from the previous task. Name the ensemble mdlEns. Calculate the loss and name it lossEns.
Code:- mdlEns = fitcensemble(creditRatings(:,selected),"Rating","Method","Bag",...
    "NumLearningCycles",50,"Learners","tree","KFold",7);
lossEns = kfoldLoss(mdlEns)


