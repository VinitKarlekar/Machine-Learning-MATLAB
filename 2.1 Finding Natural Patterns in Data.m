2.2 Low Dimensional Visualixation
##Multidimensional Scaling
(MDS) is a technique used to visualize high-dimensional data in a lower-dimensional space. 

Step 1 - Calculate pairwise distances

You can use the function pdist to calculate the pairwise distance between the observations. Note that the input should be a numeric matrix.
>> D = pdist(data,"distance")
Outputs
D	A distance or dissimilarity vector containing the distance between each pair of observations. D is of length m(m-1)/2.

Inputs
data	An m-by-n numeric matrix containing the data. Each of the m rows is considered an observation.

"distance"	An optional input that indicates the method of calculating the distance or dissimilarity. Commonly used methods are "euclidean" (default), "cityblock", and "correlation".


Step 2 - Perform multidimensional scaling

You can now use the dissimilarity vector as an input to the function cmdscale. 
>> [x,e] = cmdscale(D)
Outputs
x	
m-by-q matrix of the reconstructed coordinates in q-dimensional space.
q is the minimum number of dimensions needed to achieve the given pairwise distances.
e	Eigenvalues of the matrix x*x''.

Inputs
D	A distance or dissimilarity vector.

You can use the eigenvalues e to determine if a low-dimensional approximation to the points in x provides a reasonable representation of the data. If the first p eigenvalues are significantly larger than the rest, the points are well approximated by the first p dimensions (that is, the first p columns of x).


##Classical Multidimensional Scaling

Task1
{Q}
The matrix X has 4 columns, and therefore would be best visualized using 4 dimensions. In this activity, you will use multidimensional scaling to visualize the data using fewer dimensions, while retaining most of the information it contains.

To perform multidimensional scaling, you must first calculate the pairwise distances between observations. You can use the pdist function to calculate these distances.
distances = pdist(data);
Task
Calculate the pairwise distances between rows of X, and name the result D.

Code:- Task 1
D = pdist(X)


Task2 {Q}
The cmdscale function finds a configuration matrix and its corresponding eigenvalues for a set of pairwise distances.
[configMat,eigVal] = cmdscale(distances);
Task
Find the configuration matrix and its eigenvalues for the distance matrix D, and name them Y and e, respectively.
Code:-Task 2
[Y,e] = cmdscale(D)


Task3
{Q}
You can use the pareto function to create a Pareto chart, which visualizes relative magnitudes of a vector in descending order.
pareto(vector)
Task
Create a Pareto chart of the eigenvalues e.
Code:- Task 3
pareto(e)

Task4
{Q}
From the Pareto chart, you can see that over 90% of the distribution is described with just two variables.

You can use the scatter function to create a scatter plot of the first two columns of a matrix M.
scatter(M(:,1),M(:,2))
Task
Use scatter to create a scatter plot of the first two columns of Y.
Code:- Task 4
scatter(Y(:,1),Y(:,2))

Task5
{Q}
From the Pareto chart, notice that 100% of the distribution is described with three variables.

The scatter3 function creates a three-dimensional scatter plot. You can use scatter3 to create a scatter plot of three columns of a matrix M.
scatter3(M(:,1),M(:,2),M(:,3))
Task
Use scatter3 to create a scatter plot of the first three columns of Y.
Code:- Task 5
scatter3(Y(:,1),Y(:,2),Y(:,3))



##Nonclassical Multidimensional Scaling

Task1
{Q}
When you use the cmdscale function, it determines how many dimensions are returned in the configuration matrix.

To find a configuration matrix with a specified number of dimensions, you can use the mdscale function.
configMat = mdscale(distances,numDims);
Task
Calculate the pairwise distance between rows of X, and name it D. Then find the configuration matrix in two dimensions of the distances and name it Y.
Code:- Task 1
load data
whos X
D = pdist(X)
Y = mdscale(D,2)

Task2{Q}
Task
Create a scatter plot of the two columns of Y.
Code:- Task 2
scatter(Y(:,1),Y(:,2))



##Principal Component Analysis
Another commonly used method for dimensionality reduction is principal component analysis (PCA). Use the function pca to perform principal component analysis.
>> [pcs,scrs,~,~,pexp] = pca(data)

Task1
{Q}
You can use the pca function to perform principal component analysis on raw data.
[coeffs,score,~,~,expl] = pca(data);
Task
Calculate the principal component coefficients pcs, principal component scores scrs, and the percentage of total variance explained by each principal component of each variable, pexp, of X.   
Code:- Task 1
load data
whos X
[pcs,scrs,~,~,pexp] = pca(X)


Task2
{Q}
How much variance in the data is explained by the first two or three principal components? You can visualize the percent variance explained using a Pareto chart.
Task
Create a Pareto chart with the variance explained vector
Code:- Task 2
pareto(pexp)


Task3
{Q}
From the Pareto chart, you can see that over 90% of the data is explained by the first two principal components.
Task
Use scatter to create a two-dimensional scatter plot of the first two columns of scrs.
Code:- Task 3
scatter(scrs(:,1),scrs(:,2))

Further Practice
Compare this dimensionality reduction with the results from classical multidimensional scaling.
Y = cmdscale(pdist(X));
hold on
scatter(Y(:,1),Y(:,2))
hold off

Code:-
Y = cmdscale(pdist(X));
hold on
scatter(Y(:,1),Y(:,2))
hold off


Quiz:-
which function takes two distance as an input?
(ans) cmdscale
Which function takes the raw observations as input?
(ans) pca


##Basketball Players
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads and formats the data.
data = readtable("bball.txt");
data.pos = categorical(data.pos);
This code extracts and normalizes the columns of interest.
stats = data{:,[5 6 11:end]};
statsNorm = normalize(stats);


Task1{Q}
The statsNorm variable contains numeric statistics for several basketball players, normalized to have mean 0 and standard deviation 1.
Task
Use classical multidimensional (CMD) scaling to find the reconstructed coordinates and corresponding eigenvalues for the data in statsNorm. Plot the Pareto chart of the eigenvalues
Code:-
Task 1
distMat = pdist(statsNorm);
[Y,e] = cmdscale(distMat);
pareto(e)


Task2{Q}
Task
Make a three-dimensional scatter plot of the first three reconstructed coordinates in order.
You may use the view function to set the view of the three-dimensional plot.
view(110,40)
Code:-Task 2
scatter3(Y(:,1),Y(:,2),Y(:,3))
view(110,40)

Task3{Q}
Task
Perform principal component analysis (PCA) on the data in statsNorm. Find the principal component scores and the percentage of total variance explained by each principal component.
Plot the Pareto chart of the percent variance explained.
Code:-Task 3
[pcs,scrs,~,~,pexp] = pca(statsNorm)
pareto(pexp)

Task4{Q}
Task
Make a three-dimensional scatter plot of the first three principal component scores in order.

You may use the view function to set the view of the three-dimensional plot.
view(110,40)
Code:-Task 4
scatter3(scrs(:,1),scrs(:,2),scrs(:,3))
view(110,40)

Further Practice
For the scatter plot of the CMD values, try taking the negative of the third variable.
scatter3(Y(:,1),Y(:,2),-Y(:,3))
How do the results compare with the PCA plot?

Try plotting the positions as different colors in the scatter plot. Give the vector of positions as an additional fifth input argument to the scatter3 function.
scatter3(Y(:,1),Y(:,2),-Y(:,3),10,data.pos)
c = colorbar;
c.TickLabels = categories(data.pos);

You may see that there is some degree of clustering of the positions.

##Quiz
The results from principal component analysis will always be different from those in multidimensional scaling.
(ans) False
Correct! Classicial multidimensional scaling will give the same results (within a potential minus sign) as principal component analysis when using the 2-norm as the distance metric.
