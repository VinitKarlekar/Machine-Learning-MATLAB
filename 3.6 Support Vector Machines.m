##Support Vector Machines
Suppose you want to classify the data into two classes. Which of the three linear boundaries do you think is better at classifying the data?
Boundary 1 misclassifies no yellow data points, but several blue data points.
Boundaries 2 and 3 misclassify both yellow and blue data points, but fewer data points overall than boundary 1. They also misclassify the same data points. How would you decided between boundary 2 and boundary 3?
A Support Vector Machine (SVM) algorithm classifies data by finding the “best” hyperplane that separates all data points.
In this case, an SVM will calculate the boundary to be near boundary 2.

#Support Vector Machines Review
Function  fitcsvm
Performance              Fit Time                                 Prediction Time                           Memory Overhead
                         Fast                                     Very Fast                                 Moderate
                         ∝ square of the size of the data         ∝ square of the size of the data

Common Properties         "KernelFunction" – Variable transformation to apply.
                          "KernelScale" – Scaling applied before the kernel transformation. (Default value: 1)
                          "BoxConstraint" – Regularization parameter controlling the misclassification penalty. (Default value: 1)
Special Notes  
                          SVMs use a distance based algorithm. For data that is not normalized, use the "Standardize" option.
                          Linear SVMs work well for “wide” data (more predictors than observations). Gaussian SVMs often work better on “tall” data (more observations than predictors).

#Quiz
An SVM requires how many groups in the response?
2
A single SVM operates on binary data, but it can also handle data of one class. To classify data into more than two groups, multiple SVMs can be used

#Support Vector Machines
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads the pump features.
load pumpFeaturesSVM
dataTrain
dataTest

#Task1
To construct a Support Vector Machine (SVM), use the fitcsvm function.
svmModel = fitcsvm(tableData,...
    "ResponseVariable");
Task
Construct an SVM classifier named mdlSVM for the data in dataTrain. The response variable is named "faultCode".
Code:- Task1
mdlSVM = fitcsvm(dataTrain,"faultCode")
Evaluate model
evalModel(dataTest, mdlSVM)

#Task2
How did the model separate the groups? The optimal hyperplane of the SVM optimization is influenced by the scale of the input data. Therefore, it is recommended to standardize the data when using this algorithm. You can do this prior to training using the normalize function. Alternatively, you can set the "Standardize" property in the model to true. 
svmModel = fitcsvm(tableData,...
    "ResponseVariable",... 
    "Standardize",true);
Task
Create a new SVM model mdlSVM. Set the model property "Standardize" to the value true to see if it improves the fit.
Cod:- Task2
mdlSVM = fitcsvm(dataTrain,"faultCode","Standardize",true)
Evaluate model
evalModel(dataTest, mdlSVM)

#Task3
By default, fitcsvm uses a linear support vector. You can modify this by changing the "KernelFunction" property.
Task
Create a new SVM model mdlSVM with standardized data. Set the model property "KernelFunction" to "polynomial".
code:- Task3
mdlSVM = fitcsvm(dataTrain,"faultCode","Standardize",true,"KernelFunction","polynomial")

#SVM with Concentric Data
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads, partitions, and plots the data.
load points
rng(123)
cvpt = cvpartition(points.group,"Holdout",0.38);
trainPoints = points(training(cvpt),:);
testPoints = points(test(cvpt),:);
plotGroup(points,points.group,"x")

#Task1 
The training data set is in the trainPoints table with the response variable named "group".
Task
Create an SVM model named mdl using the training data set trainPoints. Try different values of the "KernelFunction" property so that the model has a < 1% misclassification rate (loss < 0.01) for the test set testPoints.
Code:- Task1
mdl = fitcsvm(trainPoints,"group","KernelFunction","polynomial");
mdlLoss = loss(mdl,testPoints)

#Quiz
True or False: You should only use SVMs with data that is separated by a linear hyperplane.
False 
You can provide a kernel function to transform the data before calculating the boundaries




##Multiclass Support Vector Machine Models
The underlying calculations for classification with SVMs are binary by nature. You can perform multiclass SVM classification by creating an error-correcting output codes (ECOC) classifier.
Creating Multiclass Support Vector Machines
Creating a multiclass SVM model is a two-step process.

1. Create a template for a binary classifier – Create a template for a binary SVM using the function templateSVM. 

>> template = templateSVM("PropertyName",PropertyValue)


         Outputs                                                   Inputs           
template	An SVM classifier.                       "PropertyName"      Optional property name, e.g.,"KernelFunction".           
                                                      PropertyValue      Property value, e.g., "polynomial".
                                                      You can provide multiple property name-value pairs 

2. Create multiclass SVM classifier – Use the function fitcecoc to create a multiclass SVM classifier.

>> ecocModel = fitcecoc(dataTrain,"y","Learners",template)       

         Outputs                                                   Inputs
ecocModel	ECOC classifier.                           dataTrain	Training data.
                                                        "y"	         Response variable name.
                                                       "Learners"	Property name for specifying the binary classifier.
                                                        template	Binary classifier.


##Multiclass Support Vector Machines
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads the pump features and partitions it into training and testing
load pumpFeatures
rng(0)
cv = cvpartition(size(T,1), "HoldOut", 0.3);
dataTrain = T(cv.training,:);
dataTest = T(cv.test, :)


#Task1 
To construct a multiclass Support Vector Machine (SVM), use the fitcecoc function.
msvmModel = fitcecoc(tableData,...
    "ResponseVariable");

To set SVM model options, create a template learner by passing the property name-value pairs to the templateSVM function.
t = templateSVM("PropertyName",PropertyValue);

Then provide the template learner to the fitcecoc function as the value for the Learners property.
mdl = fitcecoc(tableData,"Response",...
        "Learners",t);
Task
Create a multiclass SVM classifier named mdlMSVM using the training data dataTrain and the response variable "faultCode". Set it such that it uses the value true for the "Standardize" property.
Code:- Task1
t = templateSVM("Standardize",true);
mdlMSVM = fitcecoc(dataTrain,"faultCode",...
    "Learners",t);

#Task2
Task
Modify mdlMSVM so that it uses the value "polynomial" for the "KernelFunction" property.
Code:- Task2
t = templateSVM("Standardize",true,"KernelFunction","polynomial");
mdlMSVM = fitcecoc(dataTrain,"faultCode",...
    "Learners",t);




#Multiclass SVM Countries
Instructions are in the task pane to the left. Complete and submit each task one at a time.
Load data from file. 
load citydata.mat
cities
Fit a default multiclass SVM classifier and visualize boundaries for later comparison.
mdlSVM = fitcecoc(cities,"Country");
plotBoundaries(mdlSVM)
#Task1
By default, SVM uses linear boundaries. To change this, you can set the "KernelFunction" property in the SVM template. For example, you can use a polynomial kernel, which is a more generalized representation of the linear kernel. However it is less efficient in terms of time to train and memory.
Task
Set the "KernelFunction" to polynomial. Notice the change in boundaries, are these accurate?
Code:- Task1
t = templateSVM("KernelFunction",(Slider)"polynomial");
mdl = fitcecoc(cities,"Country","Learners",t);
plotBoundaries(mdl)

#Task2
The Gaussian or RBF function (default for one class learning) is one of the most preferred and used kernel functions for non-linear data. It is helpful when there is no prior knowledge of a given dataset.
Task
Set the "KernelFunction" to gaussian.
Code:- Task2
t = templateSVM("KernelFunction","gaussian");
mdl = fitcecoc(cities,"Country","Learners",t);
plotBoundaries(mdl)




	
	

