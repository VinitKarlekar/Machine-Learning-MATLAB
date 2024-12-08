#Feature Selection
Data sets often contain predictors which do not have any relationship with the response. For example, a medical data set may include a patient ID number, yet this ID won't have any relationship with the medical condition being studied. The ID should not be included in a model, but a model will treat it like any other predictor.
Data sets can also contain highly correlated predictors, and only one of those predictors needs to be included in the model.
Feature selection techniques choose a subset of predictors to be included in the model.

Built-in Feature Selection
Some classifiers have their own built-in methods of feature selection.
For example, decision tree models have the method predictorImportance which can be used to identify the predictor variables that are important for creating an accurate model. The output of predictorImportance is a vector of the importance values for each predictor.

tModel = fitctree(T,"faultCode");
p = predictorImportance(tModel);
toKeep = p > 0.001;
bar(p(toKeep))
xticklabels(varNames(toKeep))
xtickangle(45)

#Decision Trees: Predictor Importance
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads and displays the data.
rng(0)
load pumpFeatures
T
This code fits a 5-fold cross-validated classification tree model to the original data and calculates the loss.
mdlFull = fitctree(T,"faultCode","KFold",5);
fullLoss = kfoldLoss(mdlFull)

#Task1
You can use predictorImportance on a decision tree model to calculate the importance of each predictor variable.
predImp = predictorImportance(treeModel)
Note  You cannot use the predictorImportance function with cross-validated decision tree models.
Task
Create a classification tree model named mdl without cross-validation for the data in T. Then calculate the importance of each predictor and store the result in p.
Code:- mdl = fitctree(T,"faultCode");
p = predictorImportance(mdl)

#Task2
You can determine which predictors to keep by setting a threshold for importance. 
Task
Create a logical vector toKeep whose values are true if the corresponding values of p are greater than 0.001 and false otherwise. 
Code:- toKeep = p > 0.001;

#Task3
Task
Use the bar function to visualize the values in p greater than 0.001. You may want to label the graph using the function xticklabels.
Code:- bar(p(toKeep))
xticklabels(T.Properties.VariableNames(toKeep))

#Task4
Task
Use toKeep to create a table selected which contains only the predictors with p greater than 0.001 and the response faultCode.
Code:- 
selected = T(:,[toKeep true])

#Task5
Task
Create a five-fold cross-validated classification tree model named mdlPart which uses only the selected predictors. Calculate the loss and save it to partLoss.

# Feature Ranking Agorithms
Feature ranking algorithms assign scores to features based on how relevant they are to the model according to a given metric. Some common algorithms include Chi-Square, Minimum Redundancy Maximum Relevance (MRMR), and Neighborhood Component Analysis.
Use the fs__ functions to apply feature ranking algorithms to data. Most feature ranking algorithms return the positions and scores for all the features sorted from highest to lowest.

>> [idx,scores] = fs__(tblData,ResponseVarName)

Outputs
idx	                Indices of predictors ordered by predictor importance.
scores	            Predictor scores.
 
Inputs
tblData	            Table data with predictor variables and a response variable.
ResponseVarName	    Name of the response variable.


You can then use linear indexing to select a subset of features and use them to train the model.
  toKeep  = idx(1:nFeatures);
  selected = [tblData(:,toKeep),tblData(:,"ResponseVarName")];
  mdl = fitcknn(selected,"ResponseVarName");



#Feature ranking algorithms in MATLAB

Algorithm	                                        Function	            Task
Chi-Square	                                        fscchi2	                Classification
Minimum redundancy maximum relevance (MRMR)	        fscmrmr/fsrmrmr	        Classification/Regression
Neighborhood component analysis (NCA)	            fscnca/fsrnca	        Classification/Regression
F-tests	                                            fsrftest	            Regression
Laplacian	                                        fsulaplacian	        Clustering
ReliefF/RReliefF	                                relieff	                Classification/Regression

#Feature Ranking Algorithms
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads and displays the data.
rng(0)
load pumpFeatures
T
This code fits a 5-fold cross-validated classification tree model to the original data, calculates the loss, and displays a confusion chart.
mdlFull = fitctree(T,"faultCode","KFold",5);
fullLoss = kfoldLoss(mdlFull)
confusionchart(T.faultCode, kfoldPredict(mdlFull))

#Task1
You can use the function fschi2 to rank the predictor variables according to the Chi-Square algorithm.
[idx,scores] = fscchi2(tbl,"Response")
Task
Use fscchi2 to create the rankings idx and obtain the scores scores.
Code:- [idx,scores] = fscchi2(T,"faultCode");


#Task2
Task
Visualize the scores in a bar plot. To order the scores in the plot use linear indexing on scores with idx.
Code:- bar(scores(idx))
xlabel("Predictor rank")
ylabel("Predictor importance score")

#Task4
You can use logical indexing to select a subset of predictors according to their importance. Remember, idx(1) contains the most important predictor.
Task
Create a variable toKeep containing the top 15 predictors. Use toKeep to create a table selected which contains only the selected predictors as well as the response faultCode.
Code:- 
mdlPart = fitctree(selected,"faultCode","KFold",5);
partLoss = kfoldLoss(mdlPart)
confusionchart(T.faultCode, kfoldPredict(mdlPart))

#Task5
How did the model perform using these predictors? Different algorithms might select different predictors. You can try different feature ranking algorithms to decide which predictors to keep.
Task
Change your code in Task 1 so that it uses the MRMR algorithm using the function fscmrmr. Run the whole script, how is the loss affected?
COde:- [idx,scores] = fscmrmr(T,"faultCode");


#Feature Selection in Classification Learner
#Task1 
The Classification Learner app allows you to try and compare different feature selection methods.
Task
Click Feature Selection from the Options section. Select MRMR as the Feature Ranking Algorithm and click Save and apply. Train your model

#Task2
This algorithm calculates scores for each of the predictor variables. You can select how many predictors you want to keep based on these scores.
To apply these changes, you need to create new template models.
Task
Create a new Fine Tree template.

#Task3
This algorithm calculates scores for each of the predictor variables. You can select how many predictors you want to keep based on these scores.
Task
Click Feature Selection from the Options section. Change the number of features to keep to 20. Click Save and Apply and train your model.

#Task4
You can compare different feature selection methods by changing the specifications in the Default Feature Selection tab.
Task
Create a new Fine Tree Model.

#Task5
Task
Change the Feature Ranking Algorithm to Chi2 by selecting and applying it from the Feature Selection section. Click Save and apply
Check in the Summary tab the specification for Feature Selection is using 20 features using Chi2.
Train your model.
How does the performance change?



#Sequential Feature Selection
A feature selection approach that can be used with any learning algorithm is sequential feature selection.
Sequential feature selection is an iterative procedure that, given a specific predictive model, adds and removes predictor variables in turn, and then evaluates the effect on the quality of the model.
