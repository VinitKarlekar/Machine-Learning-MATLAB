#Telemonitoring Parkinson's Disease
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads the data.
load parkinsons
whos data dataTrain dataTest

#Task1

This data set contains biomedical voice measurements from a study of subjects with early-stage Parkinson's disease. The goal is to predict the clinician's Parkinson's disease symptom score on the UPDRS scale.

The table data contains several predictor variables and a response in an interior column named "total_UPDRS". The data has been split into training and test sets: dataTrain and dataTest.
Task
Use any regression technique with the training set to predict the outcome for the test set. Name the predictions yPred. Find a model where the MSE for the test set is less than 20.

Note  Some models take longer to fit than others. Run your script to try different models. Your script should run in under 30 seconds. Submit your script after you have found a sufficient model.
COde:- mdl = fitrtree(dataTrain,"total_UPDRS");
yPred = predict(mdl,dataTest);

