GMM Clustering
Step 1 - Fit Gaussian Mixture Model
You can use the function fitgmdist to fit several multidimensional gaussian (normal) distributions.
The command shown fits a mixture gm of two distributions.
gm = fitgmdist(X,2);    

Step 2 - Identify Clusters
Now, the data can be clustered probabilistically, by calculating each observation’s posterior probability for each component.	
g = cluster(gm,X);

You can also return the individual probabilities used to determine the clusters.
The matrix p has two columns, one for each of the two clusters.	
[g,~,p] = cluster(gm,X);

##Quiz
Quiz
Which of the following functions will return the probabilities associated with each cluster for each observation?
Ans Cluster

{Q}
If there are m observations (rows) in X, n variables (columns) in X, and k distributions fit, what is the size of p?
gm = fitgmdist(X,k);
[~,~,p] = cluster(gm,X);

ans m-by-k 
Correct! The number of rows in p equals the number of observations in X, and the number of columns in p equals the number of clusters or groups (the second input to fitgmdist).


##Task1
You can use the fitgmdist function to fit a Gaussian mixture model to the data using k distributions.
gmModel = fitgmdist(data,k);
Task
Create a Gaussian mixture model that fits three distributions to the data in X. Name the output mdl.

code:-Tasks 1 
mdl = fitgmdist(X,3)

##Task2
The cluster function partitions the observations in data using gmModel.
grps = cluster(gmModel,data);
Task
Group the observations in X according to the GMM model. Name the output grp.
code:- Task 2
grp = cluster(mdl,X)

##Task3
You can visualize the groups by viewing the data in a scatter plot and assigning each group a different color.
gscatter(X(:,1),X(:,2),grpNum)
Task
Use gscatter to create a scatter plot of the two columns of X. Assign each group a different color according to the vector grp.
Code:-Task 3
gscatter(X(:,1),X(:,2),grp)


##Task4
You can specify the type of covariance matrix to use when fitting the distributions by setting the property "CovarianceType" in the function fitgmdist.
Task
Modify your command in Task 1 so that mdl has covariance set to "diagonal".
Code:-Tasks 1 & 4
mdl = fitgmdist(X,3,"CovarianceType","diagonal")


##Basketball Players
Task1
Task
Use a Gaussian Mixture model on statsNorm to group the data into two sets in grp and find the corresponding probabilities gprob used to determine the clusters. In fitgmdist, set the property "Replicates" to five and provide the "RegularizationValue" property the value 0.02.
Code:- Task 1
grp = fitgmdist(statsNorm,2,"Replicates",5,"RegularizationValue",0.02)
[grp,~,gprob] = cluster(grp,statsNorm)