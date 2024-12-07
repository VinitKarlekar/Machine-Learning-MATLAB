##Support Vector Machines
Suppose you want to classify the data into two classes. Which of the three linear boundaries do you think is better at classifying the data?
Boundary 1 misclassifies no yellow data points, but several blue data points.
Boundaries 2 and 3 misclassify both yellow and blue data points, but fewer data points overall than boundary 1. They also misclassify the same data points. How would you decided between boundary 2 and boundary 3?
A Support Vector Machine (SVM) algorithm classifies data by finding the “best” hyperplane that separates all data points.

In this case, an SVM will calculate the boundary to be near boundary 2.