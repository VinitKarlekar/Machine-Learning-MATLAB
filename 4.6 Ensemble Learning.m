Ensemble Learning
Some machine learning methods are considered weak learners, meaning that they are highly sensitive to the data used to train them.
For example, decision trees are weak learners; two slightly different sets of training data can produce two completely different trees and, consequently, different predictions.
However, this weakness can be harnessed as a strength by creating an ensemble of several trees (or, following the analogous naming, a forest). New observations can then be applied to all the trees and the resulting predictions can be compared.
This lesson focuses on ensemble learning methods.

#Fitting Ensemble Models
The fitcensemble function creates a classification ensemble of weak learners. Similarly, the fitrensemble function creates a regression ensemble. Both functions have identical syntax.

>> mdl = fitcensemble(data,"ResponseName") 

Outputs
  mdl	              Ensemble model variable.

Inputs
  data	          Table containing the predictors and response values.
"ResponseName"	  Response variable name.


#Commonly Used Options
#"Method" - Bagging (bootstrap aggregation) and boosting are the two most common approaches used in ensemble modeling. The fitcensemble function provides several bagging and boosting methods. For example, use the "Bag" method to create a random forest.

  mdl - fitcensemble(data,"Y","Method","Bag")

The default method depends on if it is a binary or multiclass classification problem, as well as the type of learners in the ensemble.


#"Learners" - You can specify the type of weak-learner to use in the ensemble: "tree", "discriminant", or "knn". The default learner type depends on the method specified: the method "Subspace" has default learner "knn", and all other methods have default learner "tree".

  mdl = fitcensemble(data,"Y","Learners","knn")

The fitcensemble function uses the default settings for each learner type. To customize learner properties, use a weak-learner template.

  mdl = fitcensemble(data,"Y","Learners",templateKNN("NumNeighbors",3))

You can use a cell vector of learners to create an ensemble composed of more than one type of learner. For example, an ensemble could consist of two types of kNN learners.

  lnrs = {templateKNN("NumNeighbors",3),templateKNN("NumNeighbors",5)}
  mdl = fitcensemble(data,"Y","Learners",lnrs)


#"NumLearningCycles" - At every learning cycle, one weak learner is trained for each learner specified in "Learners". The default number of learning cycles is 100. If "Learners" contains only one learner (as is usually the case), then by default 100 learners are trained. If "Learners" contains two learners, then by default 200 learners are trained (two learners per learning cycle).

#Quiz
(T/F) Ensemble learning can only be applied to classification trees.
false
The "Learners" option of fitcensemble can be one of the preset strings ("discriminant", "knn", or "tree") or a learner template.

#Quiz
What is generally a benefit of using an ensemble?
Better predictive performnace of the model

Using an ensemble can group weak learners into a strong learner with greater predictive power.

#Ensemble Learning - Random Forest
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads and displays the data.
rng(0)
load pumpFeatures.mat
T
This code fits a classification tree and calculates the loss.
cvpt = cvpartition(T.faultCode,"KFold",5);
mdlTree = fitctree(T,"faultCode","CVPartition",cvpt);
lossTree = kfoldLoss(mdlTree)

#Task1
The table T contains several predictors and the response variable faultCode.
Use the fitcensemble function to create an ensemble.
en = fitcensemble(table,"Response",...
     "Method",method)
Task
Create an ensemble named mdlEns for the data in T with response "faultCode". Use classification tree learners and "Bag" as the ensemble creation method.
Calculate the resubstitution loss and save it to a variable named lossEns.
Code:- mdlEns = fitcensemble(T,"faultCode","Method","Bag");
lossEns = resubLoss(mdlEns)


#Task2 
Why does the loss value go to zero? Essentially, without cross validation, the ensemble was trained to fit the data perfectly. The model is most likely overfit and will not generalize well to new data.
You can create a cross-validated ensemble by passing fitcensemble a cross-validation partition using the "CVPartition" option.
Since cross validation is more computationally intense, you can reduce the computation time by reducing the number of ensemble learning cycles using the "NumLearningCycles" option.
Task
Create another ensemble of bagged trees named mdlEns2. Use 30 learners and the cross-validation partition cvpt. Calculate the k-fold loss and name it lossEns2.
Code:- mdlEns2 = fitcensemble(T,"faultCode","Method","Bag",...
    "NumLearningCycles",30,"CVPartition",cvpt);
lossEns2 = kfoldLoss(mdlEns2)

#Task3
You can use the templateTree function to customize a learner for the fitcensemble function.
t = templateTree(...
    "PropertyName1",PropertyValue1,...
    "PropertyName2",PropertyValue2)
Task
Create a template tree learner tmdl with the following properties:
Property Name	Property Value
"NumVariablesToSample"	15
"Prune"	"on"
Then create another ensemble named mdlEns3 using the template tree learners and the cross-validation partition cvpt. Calculate the k-fold loss and name it lossEns3
Code:- tmdl = templateTree("NumVariablesToSample",15,"Prune","on")
mdlEns3 = fitcensemble(T,"faultCode","Method","Bag",...
    "NumLearningCycles",30,"CVPartition",cvpt,...
    "Learners",tmdl);
lossEns3 = kfoldLoss(mdlEns3)
