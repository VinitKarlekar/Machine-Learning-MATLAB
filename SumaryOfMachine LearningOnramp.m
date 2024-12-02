
Import and Process Data

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