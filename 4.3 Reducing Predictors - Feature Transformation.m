#Reducing Predictors
High-dimensional Data
Machine learning problems often involve high-dimensional data with hundreds or thousands of predictors. For example:
Facial recognition problems can involve images with thousands of pixels and each pixel can be treated as a predictor.
Predicting weather can involve analyzing temperature and humidity measurements at thousands of locations.

#Reducing the Number of Predictors
Learning algorithms are often computationally intensive. Reducing the number of predictors can have significant benefits in calculation time and memory consumption.
Also, reducing the number of predictors results in simpler models, which are easier to interpret and typically generalize better.
This lesson and the next lesson (Reducing Predictors - Feature Selection) focus on two common ways to reduce the number of predictors in a model.
Feature transformation – Transform the coordinate space of the observed variables.
Feature selection – Choose a subset of the observed variables.

#Principal Component Analysis
Principal component analysis (PCA) transforms an n-dimensional feature space into a new n-dimensional space of orthogonal components. The components are ordered by the variation explained in the data.

>> [pcs,scrs,~,~,pctExp] = pca(X)

Outputs
pcs	               Principal components coefficients. The contribution of each predictor to the n principal components.
                   (n-by-n matrix)
scrs	           Principal component scores. The representations of the m observations in X in the principal component space.
                   (m-by-n matrix)
pctExp	           Percent of the variance in the data explained by each principal component.
                   (1-by-n vector)

Inputs
X	               Data matrix with m observations and n predictors.
                   (m-by-n matrix)

The transformed variables contain the same amount of information as the original data. However, assuming that the data contains some amount of noise, the components that contain the last few percent of explained variance are likely to represent noise more than information.
Reducing the Number of Predictors

PCA can be used for dimensionality reduction by discarding the principal components beyond a chosen threshold of explained variance. The pareto function can be used to visualize the variance explained by the principal components.
In the following example, the input X has 11 columns but the first 9 principal components explain more than 95% of variance.

[pcs,scrs,~,~,pctExp] = pca(X);
pareto(pctExp)

Xreduced = scrs(:,1:9);


#Interpreting Principal Components
The principal components by themselves have no physical meaning. However, the coefficients of the linear transformation indicate the contribution of each variable in the principal component.
For example, if the coefficients of the first principal component are 0.8, 0.05, and 0.3, the first variable has the largest contribution followed by the third and the second variable.

Biplot
You can visualize any two principal components using the function biplot. It's commonly used to visualize the first two principal components, which explain the greatest amount of variance in the data.
In the following biplot, you can see that the predictive variables Age, InducedSTDep, METS, and ExerciseDuration contribute heavily to the first principal component, but not to the second principal component.

biplot(pcs(:,1:2),"VarLabels",varnames)

#Heat Map
You can also visualize the contributions of each variable to the principal components as a heat map.
For example, the following heat map visualizes the first three principal components. You can see that METS, MaxHeartRate, and ExerciseDuration contribute heavily to the first principal component.

heatmap(abs(pcs(:,1:3)),...
    "YDisplayLabels",varnames);
xlabel("Principal Component")


#Parallel Coordinates Plot
PCA can be performed independent of the response variable. However, when the data has a response variable that has multiple categories (for example, true and false), a parallel coordinates plot of the principal component scores can be useful.
In the following plot, notice that the observations from one group (false) have high values of the first principal component and the observations from the second group (true) have low values.
 parallelcoords(scrs,"Group",y,"Quantile",0.25)

 #Principal Component Analysis
 Instructions are in the task pane to the left. Complete and submit each task one at a time.
 This code loads and displays the data.
 load pumpFeatures
 T
 This code fits a 10-fold cross-validated Naive Bayes model to the original data and calculates the loss.
 rng(1)
 mdlOrig = fitcnb(T,"faultCode","KFold",10);
 kfoldLoss(mdlOrig)

 #Task1
 To perform PCA, you need to standardize your data so that all variables have the same standard deviation. You can do this using the zscore function.
normData = zscore(rawData) 
Task
Use the function zscore to standardize the predictive variables in table T.
Coede:- T{:,1:end-1} = zscore(T{:,1:end-1});

#Task2
You can use the pca function to get transformed data and the percent variance explained by each principal component.
[~,tfmData,~,~,pctExp] = pca(rawData)
Task
Perform PCA on the predictive variables of the table T and save transformed data in scrs. Save the percentage explained as pexp.
Code:- [pcs,scrs,~,~,pexp] = pca(T{:,1:end-1});

#Task3
You can use the pareto function to visualize the variance explained by the principle components.
pareto(pctExp)
Task
Create a Pareto chart of the percent variance explained values.
Code:- pareto(pexp)

#Task4
The Pareto chart shows that the first ten principal components explain approximately 90% of the variance. How many principal components do we need to explain at least 99% of the variance?
Task
Calculate the cumulative sum of pexp. Find the position pos in which this cumulative sum is greater than 99%.
Code:- pos = find(cumsum(pexp) >= 99, 1)

#Task5
The first 28 principal components explain more than 99% of the variance.
Task
Create a variable PCApreds that contains the first 28 columns of scrs.
Code:- PCApreds = scrs(:,1:pos);

#Task6
Task
Fit a 10-fold cross-validated Naive Bayes model to the data containing the selected principal components PCApreds. Name the result mdl. Then calculate the loss of mdl and save it as mdlLoss.
Code:- mdl = fitcnb(PCApreds,T.faultCode,"KFold",10);
mdlLoss = kfoldLoss(mdl)

#Quiz
Which of the following functions performs feature transformation?
Ans The functions biplot and pareto are for visualization.

#PCA in Classification Learner
You can apply PCA to your data in the Classification Learner and train models using the selected components. For this interaction, we have loaded a Classification Learner session with a trained Gaussian Naive Bayes model and a template Gaussian Naive Bayes model on normalized data.
Task
Select the Gaussian Naive Bayes model template (second model). Expand the PCA dropdown in the Summary tab. Check Enable PCA and then train the model.

#Task2
You can specify the components to use according to the variance explained. By default, the Classification Learner uses the PCA components that explain 95% of the variance.
Task
Create a new Gaussian Naive Bayes model template. Expand the PCA dropdown in the Summary tab. Change the variance explained to 99 and train the model.

#Task3
Task
Create a new Gaussian Naive Bayes model. Expand the PCA dropdown in the Summary tab. Change Component reduction criterion to Specify number of components. Set the Number of numeric components to 20, and train the model.