#mproving Predictive Models
There are many algorithms available to train a predictive model on your data set.
Before you stop experimenting and put your model into production, can you do more to refine it?

#Cross Validation
Evaluating a Model
A simple way to evaluate the performance of a model is to divide the data into a subset for training the model and another for testing: you fit a model to the training set, and then calculate the loss using the test set.
When you want to select the best learning algorithm or method, you can calculate the loss for each method and pick the method with the smallest loss.

However, the loss is calculated on a specific subset of the data. It's possible that a learning algorithm performs well on that particular subset, but doesn't generalize well to other data.

#Cross Validation

You can reduce the effect on model evaluation of the specific test subset by using cross validation.
The idea behind cross validation is to repeat the model evaluation process multiple times. Each time, the process uses different training and test subsets, and fits a model to the training set and calculates the loss using the corresponding test set.

#Using Cross Validation
When you create a model, the model variable contains information about both the mathematical model and the data set.
The information about the partitions for cross validation will also be stored in the model variable.

#
Fitting Cross-Validated Models
To create a model with cross validation, provide one of the following options in the model-creation function.

         mdl = fitcknn(data,"Response","PropertyName",PropertyValue)


         Property Name	                Property Value	           Type of validation
         "CrossVal"	                     "on"	                   10-fold cross validation
         "Holdout"	                    scalar from 0 to 1	        Holdout with the given fraction reserved for validation.
         "KFold"	                     k (scalar)	                k-fold cross validation
         "Leaveout"	                          "on"	                Leave-one-out cross validation



 
If you already have a partition created using the cvpartition function, you can provide that to the fitting function instead.

cvpt = cvpartition(data.Response,"KFold",k)
mdl = fitcknn(data,"Response","CVPartition",cvpt)
Calculating the Loss
To evaluate a cross-validated model, use the kfoldLoss function.
mdlLoss = kfoldLoss(mdl)

#Quiz
(T/F) A smaller value of k will generally give a more reliable evaluation.
  cvpt = cvpartition(y,"KFold",k)
  True As k increases, the reliability of the evaluation increases.

#Quiz
(T/F) A larger value of k will generally take more computational effort.
  cvpt = cvpartition(y,"KFold",k);
  True  As k increases, so does computational effort.



