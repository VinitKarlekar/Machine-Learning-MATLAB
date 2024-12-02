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
