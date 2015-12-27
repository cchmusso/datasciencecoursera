---
title: "Practical Machine Learning - Course Project"
author: "cchmusso"
date: "27 december 2015"
output: html_document
---
# Practical Machine Learning - Course Project
## Introduction
Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. </br> In this project, our goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. The goal of this project is to predict the manner in which they did the exercise.

## Load the data

```r
#Set working directory
setwd("~/Documents/Coursera/datasciencecoursera/PracticalMachineLearning/")

#Load libraries
library("caret")
```

```
## Loading required package: lattice
## Loading required package: ggplot2
```

```r
#Download the data
if(!file.exists("pml-training.csv")){download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", destfile = "pml-training.csv")}

if(!file.exists("pml-testing.csv")){download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", destfile = "pml-testing.csv")}


#Read the training data and replace empty values by NA
trData<- read.csv("pml-training.csv", sep=",", header=TRUE, na.strings = c("NA",""))
teData<- read.csv("pml-testing.csv", sep=",", header=TRUE, na.strings = c("NA",""))
dim(trData)
```

```
## [1] 19622   160
```

```r
dim(teData)
```

```
## [1]  20 160
```
Our data consists of 19622 values of 160 variables. 


## Clean the data  
We remove columns with missing value. 


```r
trData <- trData[,(colSums(is.na(trData)) == 0)]
dim(trData)
```

```
## [1] 19622    60
```

```r
teData <- teData[,(colSums(is.na(teData)) == 0)]
dim(teData)
```

```
## [1] 20 60
```
We reduced our data to 60 variables.


## Validation set
We want a 70% observation training dataset to train our model. We will then test it on the last 30%.


```r
set.seed(123) 
inTrain<- createDataPartition(trData$classe, p=0.70, list=FALSE)
training<- trData[inTrain, ]
testing<- trData[-inTrain, ]
dim(training) ; dim(testing)
```

```
## [1] 13737    60
```

```
## [1] 5885   60
```


## Preprocessing
We preprocess our data using a principal component analysis, leaving out the last column "classe". We then apply the pre-processing to both our training and validation subsets.


```r
classe_idx <-  which(colnames(training) =="classe")
preProc <- preProcess(training[, -classe_idx], method = "pca", thresh = 0.99)
training_preprocess <- predict(preProc, training[, -classe_idx])
testing_preprocess <- predict(preProc, testing[, -classe_idx])
dim(training_preprocess)
```

```
## [1] 13737    42
```

```r
dim(testing_preprocess)
```

```
## [1] 5885   42
```
Our data is now composed of 43 variables. 

## Model


```r
library(randomForest)
modFitrf <- train(training$classe ~ ., method = "rf", data = training_preprocess, trControl = trainControl(method = "cv", number = 5), tuneGrid=data.frame(mtry=20))
modFitrf
```

```
## Random Forest 
## 
## 13737 samples
##    41 predictor
##     5 classes: 'A', 'B', 'C', 'D', 'E' 
## 
## No pre-processing
## Resampling: Cross-Validated (5 fold) 
## Summary of sample sizes: 10989, 10988, 10990, 10991, 10990 
## Resampling results
## 
##   Accuracy   Kappa      Accuracy SD  Kappa SD   
##   0.9891533  0.9862775  0.003310013  0.004188325
## 
## Tuning parameter 'mtry' was held constant at a value of 20
## 
```

## Interpretation

Let's plot the importance of each individual variable


```r
varImpPlot(modFitrf$finalModel, sort = TRUE, type = 1, pch = 19, col = 1, cex = 0.6, main = "Importance of the Individual Principal Components")
```

```
## Error in imp[, i]: indice hors limites
```

This plot shows each of the principal components in order from most important to least important.

## Cross Validation Testing and Out-of-Sample Error Estimate

Let's apply our training model on our testing database, to check its accuracy. 

#### Accuracy and Estimated out of sample error

```r
predValidRF <- predict(modFitrf, testing_preprocess)
confus <- confusionMatrix(testing$classe, predValidRF)
confus$table
```

```
##           Reference
## Prediction    A    B    C    D    E
##          A 1672    2    0    0    0
##          B    7 1129    2    1    0
##          C    0   13 1011    2    0
##          D    0    0   11  949    4
##          E    0    0    0    3 1079
```
We can notice that there are very few variables out of this model.


```r
accur <- postResample(testing$classe, predValidRF)
modAccuracy <- accur[[1]]
modAccuracy
```

```
## [1] 0.9923534
```

```r
out_of_sample_error <- 1 - modAccuracy
out_of_sample_error
```

```
## [1] 0.007646559
```

The estimated accuracy of the model is 99% and the estimated out-of-sample error based on our fitted model applied to the cross validation dataset is 0.6%.

## Application of this model on the 20 test cases provided
We have already clean the test data base (teData). We delete the "problem id" column as it is useless for our analysis.

```r
test <- predict(preProc, teData[, -60])
pred_final <- predict(modFitrf, test)
pred_final
```

```
##  [1] B A C A A E D B A A B C B A E E A B B B
## Levels: A B C D E
```

Here are our results, we will use them for the submission of this course project in the coursera platform.