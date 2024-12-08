##Neural Networks
Neural networks simulate the human brain's behavior through a set of connected neurons. These networks learn to recognize patterns by adjusting the connections between the neurons through trial and error.
This method does not make any assumptions about the data. However, it requires the data to be normalized.

#Neural Networks
Function                   fitcnet
Performance                Fit Time                   Prediction Time               Memory Overhead
                           Slow                       Slow                          Medium
                           ∝ Network & data size      ∝ Network & data size        ∝ Network & data size
 


 


Common Properties  
                  "LayerSizes" – Sizes of fully connected layers. (Default: 10)
                  "Activations" – Activation functions for fully connected layers. (Default: ReLU)
                  "ValidationData" – Validation data for training convergence detection.

Special Notes    Neural networks require data to be normalized. For normalizing the data, use the "Standardize" option.

                To train a neural network with more than one hidden layer specify the number of neurons per hidden layer as a vector. For example, "LayerSizes",[20,15] creates a network with two hidden layers with 20 and 15 neurons accordingly.

                Neural networks work well for "tall" data (more observations than predictors).

#Neural Networks
Load the pump features from pumpFeatures.
rng(3)
load pumpFeaturesNets.mat
The data has been divided into 3 sets: train, validation and test
whos dataTrain dataVal dataTest

#Task1
To fit a neural network for classification in MATLAB, use the fitcnet function with the table as input and specify the name of the response variable. By default, a neural network with one hidden layer consisting of 10 neurons is created. To specify the number of hidden neurons in the network, use the "LayerSizes" property:
nnModel = fitcnet(tableData,...
    "ResponseVariable",...
    "LayerSizes",24);
Task
Create a classification neural network named mdlNet with 48 hidden neurons. Train the model using dataTrain with response variable faultCode.
Code:- mdlNet = fitcnet(dataTrain,"faultCode","LayerSizes",48)

#Task2
Notice that all the observations in the test set were classified into one class. Neural networks require data to be standardized, otherwise they fail to converge to a solution. To address this, you can set the "Standardize" property to true.
nnModel = fitcnet(tableData,...
    "ResponseVariable",...
    "LayerSizes",24,...
    "Standardize",true);

Task
Modify mdlNet so that the data is standardized.
Code :-mdlNet = fitcnet(dataTrain,"faultCode","LayerSizes",48,"Standardize",true)

#Task3
To prevent overfitting a neural network, it is a good practice to use a validation set to stop training once the validation loss stops improving. You can use the "ValidationData" property to specify the data used for validation. Setting the "ValidationPatience" property tells the network to stop training if the validation loss has not improved after a certain number of iterations.
Task
Modify mdlNet to include dataVal as the validation data, and to stop training if the validation loss does not improve after 30 evaluations.
Code:- mdlNet = fitcnet(dataTrain,"faultCode","LayerSizes",48,"Standardize",true,"ValidationData",dataVal,"ValidationPatience",30)