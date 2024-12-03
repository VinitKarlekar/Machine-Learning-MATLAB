##Visualizing Observations in Clusters
With high-dimensional data, it is difficult to visualize the groups as points in space. How can you interpret the groups given by a clustering method?

Parallel Coordinates
Consider a data set in which each observation has 4 variables (measurements) x1, x2, x3, and x4. Suppose that you have created two clusters.
You can visualize the first observation by plotting its variable value on the y-axis and the variable number on the x-axis. Similarly, you can visualize the second observation. If the second observation is in a different cluster, visualize it using a different color.
After visualizing several observations, you can see that cluster 1 has higher values of x1 and x3 whereas cluster 2 has higher values of x2 and x4.
Instead of visualizing each observation one-by-one, use the function parallelcoords, which creates the graph shown above.

>> parallelcoords(X,"Group",g)
Inputs
  X	       Data, specified as a numeric matrix.
"Group"	   Property name.
  g	       A vector containing the observations' group or cluster identifiers.


##Parallel Coordinates
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads the data.
load data
whos X

##Task1
The matrix X contains 124 observations of 4 variables.
The kmeans function can return an optional second output which contains the centroids of each group.
[grpNum,centroids] = kmeans(data,k)
Task
Use kmeans to group X into three groups. Return the groups grp and the centroids C of each group.
Ans - [grp,C] = kmeans(X,3)

##Task2
You can use the parallelcoords function to visualize the results.
parallelcoords(data,...
    "PropertyName",PropertyValue)
Task
Use parallelcoords to plot each observation. Specify the grouping variable with the property "Group".   
Code:- Task 2
parallelcoords(X,"Group",grp)

##Taask3
When you have a large number of observations, visualizing every observation can create clutter. Instead, you can visualize only the centroid of each cluster.
Task
Use parallelcoords to plot the group centroids C. Specify the "Group" property value as the vector 1:3.
Code:- Task 3
parallelcoords(C,"Group",1:3)


##Task4
Another option is to plot the median values for each group with bounding lines.
In addition to specifying the "Group" property, you can use the "Quantile" property with a value between 0 and 1. If you specify the value α, then only the median, α, and 1-α quantile values are plotted for each group.
Task
Use parallelcoords to create a bounding plot on the data X with a quantile value of 0.25.
Code:- Task 4
parallelcoords(X,"Group",grp,"Quantile",0.25)


##Cross-Tabulation
In some data sets, the observations already have a category associated with them. You can use the crosstab function to study the distribution of clusters across the original categories.

counts = crosstab(yCat,grp)

The first input to crosstab corresponds with the rows of counts, and the second input corresponds with the columns of counts.
Task 1
Use crosstab to compare the original categories in yCat (rows) and the clusters in grp (columns). Name the output cts.
Code:- Task 1
cts = crosstab(yCat,grp)

##Task2
You can use the heatmap function to visualize the counts.
heatmap(counts)
Task
Create a heatmap of cts.
Code:- Task 2
heatmap(cts)

##Task3
You can label the original categories in the heatmap by using the "YDisplayLabels" property.
heatmap(counts,...
    "YDisplayLabels",categories(cats))
Task
Label the heatmap with the categories of yCat.
Code:- Task 3
heatmap(cts,"YDisplayLabels",categories(yCat))


##Quiz
Quiz
What information is required to use the crosstab function on your clusters?
The crosstab function requires at least two inputs: predefined categories for each observation and the output groupings from a clustering function.

##Evaluating Cluster Quality
Evaluating Cluster Quality
When using clustering techniques such as k-means and Gaussian mixture models, you have to specify the number of clusters. However, for high-dimensional data, it is difficult to determine the optimum number of clusters.

You can use the silhouette values to judge the quality of the clusters. An observation’s silhouette value is a normalized measure (between -1 and +1) of how close that observation is to other observations in the same cluster, compared to the observations in different clusters.

Silhouette Plots
A silhouette plot shows the silhouette value of each observation, grouped by cluster. Clustering schemes in which most of the observations have high silhouette value are desirable.
Use the silhouette function in MATLAB to create a silhouette plot.

In this case, dividing the data into 2 clusters instead of 3 produces better quality clusters. The silhouette plot of two clusters shows fewer negative silhouette values, and those negative values are of smaller magnitude than the negative values in the silhouette plot of three clusters.

Automate Cluster Quality Evaluation
Instead of manually experimenting with different numbers of clusters, you can automate the process with the evalclusters function.
The following function call creates 2, 3, 4, and 5 clusters using k-means clustering, and calculates the silhouette value for each clustering scheme.
 clustev = evalclusters(X,"kmeans","silhouette","KList",2:5)
The output variable, clustev, contains detailed information about the evaluation including the optimum number of clusters.
 kbest = clustev.OptimalK
In place of "silhouette", you can use other evaluation criteria such as "CalinskiHarabasz", "DaviesBouldin", and "gap".


##Silhouette Plots
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads the data.
load data2
whos X yCat
This code clusters the data into 2 groups using kmeans.
grp = kmeans(X,2);

##Task1
The observations in X have been divided into 2 groups using k-means clustering.
You can use the silhouette function to measure how close each observation is to other observations in the same cluster.
silhouette(data,groups)
Task
Create a silhouette plot of the results from kmeans.
Code:- Task 1
silhouette(X,grp)


##Task2
Task
Now use the kmeans function to group X into three groups, and name the output grp3. Create a second silhouette plot to visualize the results of using three groups.
Code:- Task 2
grp3 = kmeans(X,3)
silhouette(X,grp3)

##Task3
If you're not certain about how many groups to use, the evalclusters function can help you make the decision.
The following command uses the silhouette values with kmeans to evaluate the optimal number of clusters.
eva = evalclusters(data,...
    "kmeans","silhouette",...
    "KList",vectorOfPositiveIntegers)
Task
Evaluate k-means clustering using silhouette values for group sizes 2 through 5. Name the result clustEv.
Code:- Task 3
clustEv = evalclusters(X,"kmeans","silhouette","KList",2:5)

#Quiz
Quiz
Which of the following functions will plot each observation as a line against the variable number?  
Ans The parallel coordinates plot contains the multivariate data where each observation is represented by the sequence of its coordinate values plotted against the coordinate indices.


##Basketball Players
##Task1
The table data contains statistics for several basketball players. The players' positions are contained in data.pos.
The numeric statistics have been extracted and normalized in statsNorm, then used in a Gaussian mixture model (GMM) to divide the players into two groups in grp.
Task
Create a heatmap of the cross-tabulated values comparing player's position with their assigned group.
Code:- Task 1
Count = crosstab(data.pos,grp)
heatmap(Count)

##Task2
The Gaussian mixture model gmModel contains information about the underlying Gaussian distributions used to create the clusters. For example, you can extract the means of the distributions, which correspond to the centroids of the clusters.
centroids = model.mu
Task
Plot the centroid value of each group against the variable (coordinate) number.
Code:- Task 2
parallelcoords(gmModel.mu,"Group",1:2)
xticklabels(labels)
xtickangle(60)

##Task3
Task
Evaluate the GMM clustering of statsNorm for group sizes 2 through 4. Name the result cev.
Code:- Task 3
ev = evalclusters(statsNorm,"gmdistribution","DaviesBouldin","KList",2:4)
optK = cev.OptimalK


