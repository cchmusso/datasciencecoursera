### Project

## Introduction
Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, your goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. The goal of this project is to predict the manner in which they did the exercise.

## Preprocessing
Firstly, we noticed that they were a lot of missing values (NAs or empty) so we decided to remove them. But we had still too much variables. This is why we used PCA to acquire the variables that explained 95% or the outcome value (the class). 

## Training
Having reduced our set of variables, we applied different algorithm such as random forest, naive bayes, linear regression model and  multivariate model with different tuning parameters to speed up these algorithms. 
We computed the accuracy for each model with a cross validation of 5 folds. The best algorithm was random forest with an accuracy of 0.96. 

## Prediction
Finally, we used our final model to estimate the 20 test cases. We obtained successfully a good estimate for each test case. 


We then tested it on the test data base. Here are our results : B A C A A B D B A A B C B A E E A B B B.


B A C A A 
**E** D B A A 
B C B A E 
E A B B B





