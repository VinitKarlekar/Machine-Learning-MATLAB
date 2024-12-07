##Decision Trees

Observations being classified according to a decision tree.
K-nearest neighbors (kNN) are distance-based classification models. Thus, they require all predictors to be numeric or all predictors to be categorical. Many data sets contain both numeric and categorical predictors. If you have mixed predictors, you cannot use all of your data with a kNN model.
In this lesson, you will learn to fit and customize decision trees. Decision trees, like kNN models, do not make any assumptions about the data, but they do allow a mixture of numeric and categorical predictors, given that they treat predictors independently.

##Decision Trees Overview
Function              fitctree
Performance           Fit Time              Prediction Time     Memory Overhead
                      ∝ Size of the data    Fast                Small
 
Common Properties       "SplitCriterion" – Formula used to determine optimal splits at each level.
                        "MinLeafSize" – Minimum number of observations in each leaf node.
                        "MaxNumSplits" – Maximum number of splits allowed in the decision tree.
Special Notes           Trees are a good choice when there is a significant amount of missing data.



##Classification Trees
Instructions are in the task pane to the left. Complete and submit each task one at a time.
Load the pump features from pumpFeatures.
load pumpFeatures
Partition into training and testing
rng(0)
cv = cvpartition(size(T,1), "HoldOut", 0.3);
dataTrain = T(cv.training,:)
dataTest = T(cv.test, :)

##Task1

To construct a classification tree, use the fitctree function with a table as input and specify the name of the response variable.
treeModel = fitctree(tableData,...
    "ResponseVariable");
You can visualize the decision tree with the view function.
view(treeModel,"mode","graph")
Task
Use the training data to construct a classification tree named mdl where the response variable is named "faultCode". You may want to visualize the decision tree by using the view function.
Code:- Task1
Task 1
mdl = fitctree(dataTrain,"faultCode")
view(mdl,"mode","graph")

Evaluate model
evalModel(dataTest, mdl)

##Task2
You can change the level of branching of the classification tree using the prune function.
prunedTreeModel = prune(treeModel,...
    "Level",integer);
Task
Prune the tree to level 2, and save it as mdlPruned. You can evaluate the model by calling the local function evalModel with dataTest and mdlPruned as inputs.
Code:- Task2
mdlPruned = prune(mdl,"Level",2)
view(mdl,"mode","graph")

Evaluate model
evalModel(dataTest, mdlPruned)

##Quiz
How many times can a classification tree make a split based on each predictor variable?
Each branch is defined by splits based on binary decisions. The tree makes as many decisions as are necessary to create the model.

Quiz
Which of the following properties does not belong to a fitted binary classification decision tree?
"MaxNumSplits"
"MinLeafSize"
"Numneighbours"
"Splitcriterion"

Three of the above properties are associated with fitctree and the other one is for fitcknn(Numneighbours).

##Classification Trees Countries
Instructions are in the task pane to the left. Complete and submit each task one at a time.
Load data from file. 
load citydata.mat
cities
Fit a default tree classifier and visualize boundaries for later comparison.
mdlTree = fitctree(cities,"Country");
plotBoundaries(mdlTree)

Tasks 1 & 2
mdlPruned = prune(mdlTree,"level",0  {levelsliderisgiven});
plotBoundaries(mdlPruned)

##Task1

Task
Prune the tree to level 3 by adjusting the numeric slider. Notice the new boundaries.

##Task2
With a pruning level of 3, the algorithm is still able to approximate the country boundaries.
Task
Increase the pruning level. What happens with the boundaries?
