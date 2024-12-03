##kmeans Function
Use the kmeans function to perform k-means clustering.
>> idx = kmeans(X,k)
Outputs
idx	Cluster indices, returned as a numeric column vector.
Inputs
X	Data, specified as a numeric matrix.
k	Number of clusters.

Options
Distance Metric
By default, the euclidean distance is used to access the similarity between two observations. You can use other metrics such as correlation.
g = kmeans(x,2,"Distance","correlation");


Replicates

Another way to get optimum clustering is to perform the analysis multiple times with different starting centroids and then choose the clustering scheme which minimizes the sum of distances between the centroids and the observations (sumd).
This can be done by using the "Replicates" property. The following command repeats the clustering 5 times and returns the clusters with lowest sumd.

g = kmeans(x,2,"Replicates",5);


##Quiz
{Q}
Quiz
Which of the following properties specifies the initial centroid values in kmeans?
Ans "Start"
Quiz
Which is the default value of the "Distance" measure property in kmeans?
Ans "sqeuclidean"


##Task 1
{Q}
You can use the kmeans function to group data into k groups or clusters.
groupNum = kmeans(data,k)
Task
Group X into three groups. Name the output grp.
 Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads and displays the data.
load data
whos X
Code:- Task 1
grp = kmeans(X,3)

##Task2
{Q}
You can visualize the groups by viewing the data in a scatter plot and assigning each group a different color.
Provide the vector of groups as a third input argument to the gscatter function.
gscatter(X(:,1),X(:,2),grpNum)
Task
Use gscatter to create a scatter plot of the two columns of X. Assign each group a different color according to the vector grp.

Code:- Task 2
gscatter(X(:,1),X(:,2),grp)


##Options for k-Means Clustering
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads and displays the data.
load rData
whos X

Task1
{Q}
Task
Group X into three groups, and name the output grp
Code:- Task 1
grp = kmeans(X,3)

Task2
{Q}
Task
Group X into three groups again in grp. Set the following properties in kmeans to see how they impact your clusters.
         Property Name	Property Value
           "Start"	      "cluster"
         "Replicates"	  at least 3
Do not edit the command from Task 1 so that you can compare the two grp variables.

Code:- Task 2
grp = kmeans(X,3,"Start","cluster","Replicates",3)


##Basketball Players
Task
Use k-means clustering on statsNorm to group the data into two sets in grp. Set the number of replicates to five.
Code:- Task 1
grp = kmeans(statsNorm,2,"Replicates",5)
