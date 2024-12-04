##Wine Color
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads and formats the data.
wineData = readtable("wineData.txt");
wineData.Color = categorical(wineData.Color);
This code extracts the numeric data.
numData = wineData{:,1:end-1};

##Task1
The table wineData contains several features which describe the chemical composition for many different wines. The numeric data is also stored in the matrix numData. Use this matrix for the following calculations.
Task
Use PCA to transform the numeric data. Save the transformed observations to scrs. Visualize the importance of the components with a Pareto chart
Code :- Task1
[~,scrs,~,~,pexp] = pca(numData);
pareto(pexp)

##Task2
Cluster the data into two groups saved in g. Experiment with k-means and/or GMM clustering. Use gscatter to make a scatter plot with the two groups identified
Code :- Task2
% k-Means
g = kmeans(numData,2,"Replicates",5);
% Gaussian mixture model
gmModel = fitgmdist(numData,2,"Replicates",5);
g = cluster(gmModel,numData);
% Plot by group
gscatter(scrs(:,1),scrs(:,2),g)

##Task3
Task
Compare the resulting clusters with the groups in the Color variable of wineData. Visualize the results in a heatmap and label it with the corresponding categories.
Code:- Task3
counts = crosstab(wineData.Color,g)
heatmap(counts,"YDisplayData",categories(wineData.Color))


##Corporate Bonds
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads the data and extracts the numeric data into a matrix.
bondData = readtable("bondData.txt");
bonds = bondData.Variables;

##Task1
Numeric data is stored in the matrix bonds. Use this matrix for the following calculations.
Task
Use k-means clustering to cluster the numeric data into three groups, with the "Distance" property set to the value "cosine". Save the groups to kGrp.
Code:- Task 1
kGrp = kmeans(bonds,3,"Distance","cosine")

##Task2
Task
Use evalclusters to determine the optimal number of clusters and save the output to a variable named eva.

Set the following properties for the cluster evaluation:
  Property            Name	Property Value
  Clustering          function	"kmeans"
  Criterion name	    "silhouette"
  "KList"	            2:7
  "Distance"	        "cosine"

  Code:- Task2
  eva = evalclusters(kGrp,"kmeans","silhouette","KList",2:7,"Distance","cosine")




##Wheat Seed Kernels
Instructions are in the task pane to the left. Complete and submit each task one at a time.
This code loads the data, then extracts the numeric data into a matrix and the existing group numbers into a vector.
data = readtable("seeds.txt");
numData = data{:,1:end-1};
variety = data.variety;

##Task 1
Numeric data is stored in the matrix numData. Use this matrix for the following calculations.
Task
Use k-means clustering, GMM clustering, and hierarchical clustering to cluster the numeric data into three groups. Save the groups in variables named grpK, grpGMM, and grpTree, respectively.
Code:- Task1
grpK = kmeans(numData,3)

group = fitgmdist(numData,3)
grpGMM = cluster(group,numData)

z = linkage(numData)
grpTree = cluster(z,"maxclust",3)
