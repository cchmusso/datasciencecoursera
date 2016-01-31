Getting and Cleaning Data: Course Project
=========================================

Introduction
------------
This repository contains my solution for the course project of the Coursera course "Getting and Cleaning data".

The data
--------
The data was obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Data for this project was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The data are divided into several text files.
The features in the X_test.txt and X_train.txt are unlabelled. 
The activity labels are in the y_test.txt and y_train.txt files.
The activity labels names are in activity_labels.txt.
The subjects for test are in the subject_test.txt file.
The subjects for trian are in the subject_train.txt file.
The feature names are in the features.txt file.

The script and the tidy dataset
-------------------------------
I wrote a script called run_analysis.R. The script merges the test and training sets together.
The UCI HAR Dataset must be available in a directory called "UCI HAR Dataset"

After merging testing and training, labels are added. Only columns that have words mean or standard deviation (std) in the label are kept. Other columns are dropped.

After preparing training and testing data the script creates a tidy data set containing the means of all the columns per test subject and per activity.
This tidy dataset is written to a text file called tidy.txt.

The Code Book
-------------------
The CodeBook.md file contains transformation steps and the resulting data.

