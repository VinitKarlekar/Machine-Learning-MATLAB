##Hierarchical Clustering
Step 1 – Determine Hierarchical Structure

Finding the hierarchical structure involves calculating the distance between each pair of points and then using these distances to link together pairs of “neighboring” points.
Use the linkage function to create the hierarchical tree.
The optional second and third inputs specify the methods for calculating the distance between clusters (default: "single") and calculating the distance between points (default: "euclidean").	
Z = linkage(X,"ward","cosine");

Step 2 – Divide Hierarchical Tree into Clusters
You can use the cluster function to assign observations into groups, according to the linkage distances Z.
 Z = linkage(X,"centroid","cosine");
 dendrogram(Z)
 grp = cluster(Z,"maxclust",3)

 ##Hierarchical Tree
 Instructions are in the task pane to the left. Complete and submit each task one at a time.
 This code loads the data.
 load data
 whos X

 ##Task1
 You can use the linkage function to encode a tree of hierarchical clusters from a set of observations.
Z = linkage(data)
Task
Use the linkage function on the observations in X. Name the output Z.
Code:- Task1
Z = linkage(X)

##Task2
You can use the dendrogram function to visualize the hierarchy of a binary cluster tree.
dendrogram(linkages)
Task
Visualize the linkages Z as a dendrogram.
Code:- Task2
dendrogram(Z)

##Task3

You can modify the way that linkage computes the distance between clusters by passing an optional second input. For example, the "ward" method computes the inner squared distance using Ward's minimum variance algorithm.
Task
Use linkage on X again, this time using the "ward" method to calculate the distance between clusters. Name the output Zcomp. Visualize Zcomp as a dendrogram.
Code:- Task3
Zcomp = linkage(X,"ward")
dendrogram(Zcomp)

##Hierarchical Clustering
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads the data.
load data
whos X
This code creates a tree of hierarchical clusters.
Z = linkage(X);
dendrogram(Z)

##Task1
You can use the cluster function to assign observations to one of k groups according to the linkage distances Z.
grp = cluster(Z,"maxclust",k)
Task
Construct three clusters from the linkages in Z. Name the output grp.
Code:- Task1
grp = cluster(Z,3)


##Task2
The Cophenetic correlation coefficient quantifies how accurately the tree represents the distances between observations. Values close to 1 indicate a high-quality solution.
You can use pdist to compute the pairwise distances of the original data, then use the cophenet function to calculate the Cophenetic correleation coefficient.
ccc = cophenet(linkages,distances)
Task
Compute the pairwise distances of the original data X. Name the result Y. Calculate the Cophenetic correlation coefficient and name it c.
Code:- Task2
Y = pdist(X)
c = cophenet(Z,Y)

##Quiz'
uiz
(T/F) Generally, you create the hierarchical tree structure before you determine the number of clusters.
T = Hierarchical clustering is generally performed in two steps: 
1 determine the hierarchical structure;
2 divide the hierarchical tree into clusters.

##Basketball Players
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads, formats, and normalizes the data.
data = readtable("bball.txt");
data.pos = categorical(data.pos);
stats = data{:,[5 6 11:end]};
labels = data.Properties.VariableNames([5 6 11:end]);
statsNorm = normalize(stats);
This code extracts the data for the guard position (G).
posStats = statsNorm(data.pos == "G",:);

##Task1 
Task
Use hierarchical clustering with the "ward" method to measure distance between clusters to cluster the data stored in posStats into two groups in gc2, and three groups in gc3.

Cod:- Task 1
Z = linkage(posStats,"ward")
gc2 = cluster(Z,"maxclust",2)
gc3 = cluster(Z,"maxclust",3)

##Task2
Task
Visualize the hierarchy in a dendrogram. Evaluate the hierachical clustering of posStats for group sizes 2 through 8. Name the result ec.
Code:- Task 2
dendrogram(Z)
ec = evalclusters(posStats,"linkage","silhouette","KList",2:8)