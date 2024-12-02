
##Import and Process Data

The readtable function creates a table in MATLAB from a data file.	
allStats = readtable("bballStats.txt");
playerInfo = readtable("bballPlayers.txt");


The categorical function creates a categorical array from data.	
positions = ["G","G-F","F-G","F","F-C","C-F","C"];
playerInfo.pos = categorical(playerInfo.pos,positions);


Assigning the empty array removes rows or columns. The rmmissing function removes any row with missing or undefined elements.	
allStats(19:end) = [];
playerInfo = rmmissing(playerInfo);


The groupsummary function calculates statistics grouped according to a grouping variable.	
playerStats = groupsummary(allStats,"playerID","sum");


The innerjoin function merges two tables, retaining only the common key variable observations.	
data = innerjoin(playerInfo,playerStats);

##Visualize and Engineer Features

The boxplot function can create separate box plots based on a grouping variable.	
boxplot(data.height,data.pos)


You can use indexing and element-wise division to scale variables in a table.	
data{:,8:22} = data{:,8:22}./data.minutes;
data.minutes = data.minutes./data.GP;


You can use the gscatter function to create a grouped scatter plot.	
gscatter(data.rebounds,data.points,data.pos)



##Train and Evaluate a Model
The fitcknn function fits a k-nearest neighbors classification model.	
knnmodel = fitcknn(data,"pos");

You can use property name-value pairs to modify model options.	
knnmodel = fitcknn(data,"pos","NumNeighbors",5,...
      "Standardize",true);

You can calculate the misclassification rate for a data set using the loss function.	
mdlLoss = loss(knnmodel,dataTest)
mdlLoss =
    0.4085

The predict function uses a classification model to predict classes for observations.	
predPos = predict(knnmodel,dataTest);

You can use the confusionchart function to visually compare true classes and predicted classes.	
confusionchart(data.pos,predPos);