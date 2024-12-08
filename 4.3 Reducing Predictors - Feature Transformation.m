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