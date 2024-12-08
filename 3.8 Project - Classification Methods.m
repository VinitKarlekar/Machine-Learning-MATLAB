##User Knowledge Assessment
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads and formats the data.
knowledge = readtable("userKnowledge.txt");
knowledge.knowledgeScore = categorical(knowledge.knowledgeScore);
Partition the data into training and test sets.
rng(0)
pt = cvpartition(knowledge.knowledgeScore,"HoldOut",0.3);
kTrain = knowledge(training(pt),:)
kTest = knowledge(test(pt),:);

The table knowledge contains measurements from a student with regards to time spent studying and scores on exams. The response variable knowledgeScore is a category assigned by professors.
Task
Create a classifier named mdl to predict the knowledge score for the training data kTrain. Calculate the misclassification rate, and assign it to a variable named errRate.
Code:- mdl = fitctree(kTrain,"knowledgeScore");
errRate = loss(mdl,kTest)


#Breast Cancer Detection
Task 1
Fit classifier and calculate loss.
mdl = fitctree(bcTrain,"diagnosis");
errRate = loss(mdl,bcTest)

#Task2
False negatives are masses where the true diagnosis is malignant, but the predicted diagnosis is benign. The false negative rate is different from the misclassification rate, which includes benign masses that are misclassified as malignant.
Task
Of the data classified from bcTest, what is the proportion of misclassified malignant masses? Calculate the false negative rate and name it falseNeg.
Code:- p = predict(mdl,bcTest);
falseNeg = mean((bcTest.diagnosis == "M") & (p == "B"))
confusionchart(bcTest.diagnosis,p);



#Mushroom Edibility
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads and formats the data.
mushrooms = readtable("mushrooms.txt");
mushrooms = convertvars(mushrooms,vartype("cellstr"),"categorical");
Partition the data into training and test sets.
pt = cvpartition(mushrooms.edibility,"HoldOut",0.3);
mTrain = mushrooms(training(pt),:);
mTest = mushrooms(test(pt),:)

#Task1
The table mushrooms contains several features of a mushroom and the corresponding response, edibility.

Because all of the predictor variables are categorical, you may want to specify a multivariate multinomial distribution.
Task
Use a Naive Bayes classifier on the training data mTrain with a multivariate multinomial ("mvmn") distribution to predict mushroom edibility. Calculate the classification loss and name it errRateNB.
Code:- mdlKNN = fitcknn(mTrain,"edibility","NumNeighbors",2);
errRateKNN = loss(mdlKNN,mTest)

#Wine Quality
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads and formats the data.
redData = readtable("redWine.txt");
redData.QCLabel = categorical(redData.QCLabel);
Partition the data into training and test sets.
pt = cvpartition(redData.QCLabel,"HoldOut",0.3);
redWineTrain = redData(training(pt),:);
redWineTest = redData(test(pt),:)

#Task1
The table redData contains several features of red wine and the corresponding quality, which is saved in the variable named "QCLabel".
Task
Create a classifier named mdl to predict the quality for the training data redWineTrain. Calculate the misclassification loss for the test data redWineTest, and assign it to a variable named errRate. Try to find a classifier that repeatedly gives a loss value less than 0.46.
Code:- mdl = fitcdiscr(redWineTrain,"QCLabel");
errRate = loss(mdl,redWineTest)
Done with project