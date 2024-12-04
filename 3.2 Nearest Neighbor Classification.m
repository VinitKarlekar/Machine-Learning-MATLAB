##Nearest Neighbor Classification
One of the most straightforward ways of categorizing a new sample is to find known samples that are similar to the new sample, and assign the new sample to the same class. This is a basic idea behind k-nearest neighbors classification.
When using this method, we do not have to make any assumptions about the underlying distribution of the data.

##k-Nearest Neighbor Overview
Function                fitcknn
Performance             Fit Time
                         Fast
                        Prediction Time
                        Fast
                         ∝ (Data Size)2
                        Memory Overhead
                         Small
Common Properties  
                "NumNeighbors" – Number of neighbors used for classification. (Default: 1)
                "Distance" – Metric used for calculating distances between neighbors.
                "DistanceWeight" – Weighting given to different neighbors.

Special          Notes  For normalizing the data, use the "Standardize" option.
                 The "cosine" distance metric works well for “wide” data (more predictors than observations) and data with many predictors.


##Nearest Neighbor Classification
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads the pump features and partitions it into training and testing
load pumpFeatures
rng(0)
cv = cvpartition(size(T,1), "HoldOut", 0.3);
dataTrain = T(cv.training,:);
dataTest = T(cv.test, :)

##Task1
To construct a k-nearest neighbor classifier in MATLAB, use the fitcknn function with the data table as input and specify the name of the response variable. By default, a single neighbor is used for the classification (k = 1). To specify k in the model, use the "NumNeighbors" property:
knnModel = fitcknn(tableData,...
    "ResponseVariable",...
    "NumNeighbors",4);
Task
Construct a k-nearest neighbor classifier named mdlkNN where k = 3. Train the model using dataTrain with the response variable faultCode.
Code:- Task1
mdlkNN = fitcknn(dataTrain,"faultCode","NumNeighbors",3)


##Task2
Using more neighbors for the predictions may reduce the risk of overfitting.
Instead of modifying the fitcknn function call, you can change the number of neighbors after the model has been created.
To change k after model creation, use dot notation with the NumNeighbors property.
model.PropertyName = newPropertyValue
Task
Modify mdlkNN to increase the number of nearest neighbors to 7.
Code:- Task2
mdlkNN = fitcknn(dataTrain,"faultCode","NumNeighbors",7)


##Task3
You may want to train this algorithm using different parameters to best fit your data. Some common parameters to modify are "Distance" and "DistanceWeight".
knnModel = fitcknn(tableData,"ResponseVariable",...
                  "NumNeighbors",4,...
                  "Distance","cosine",...
                  "DistanceWeight","inverse");

Task
Construct a k-nearest neighbor classifier named mdlkNN where k = 7, the "Distance" is "correlation", and the "DistanceWeight" is "squaredinverse".
Code:_ Task3
mdlkNN = fitcknn(dataTrain,"faultCode","Distance","correlation","DistanceWeight","squaredinverse","NumNeighbors",7)

##Quiz
Quiz
{Q} Which syntax will set the number of nearest neighbors used for the kNN model to one?
Ans - The default number of neighbors for the "NumNeighbors" property is one. So, although all of the responses are valid, the first answer is the most succint.
{Q} Quiz
(T/F) You can use the documentation for fitcknn to help you determine if the following statement is true or false.
You can set a custom distance weighting function to calculate which group the observation belongs to. For example, you can weigh the neighbors such that nearer neighbors count more than ones farther away.
Ans - True 
The "DistanceWeight" property allows you to enter your own function handle to define the weighting function.

Quiz
You can use the documentation for fitcknn to find the answer to the following question.
When the nearest neighbor returns a tie, which of the following methods is the default tie-breaking algorithm?
ans - Suppose that you use four nearest neighbors, and they are split into two categories. You can find the default tie-breaking algorithm by looking at the BreakTies property of fitcknn.


##Country Boundries
#Task1 
Look at the top right corner observation on the map, that is Borkum, an island in Germany. Since the number of neighbors is 1, the algorithm classified it correctly.
Task
Change the number of neighbors to be 5 by adjusting the numeric slider. What occurs with that boundary? Can you identify other changes in the boundaries?

##Task2
Task
The default distance metric is "euclidean". Select from the dropdown cosine for the "Distance" property. How is the boundary affected?

##Task3
Cosine is usually used to calculate the similarity and direction between two vectors, thus it is not appropiate for our dataset. Such as with cosine, not all distance metrics will perform well in every dataset.
Task
Change the "Distance" to spearman. What occurs with the boundaries?