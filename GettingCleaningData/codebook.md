---
title: "CodeBOOK"
author: "Claire Musso"
date: "January 28, 2016"
output: html_document
---

# Original Data
* [source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* [description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


# Data Transformation Steps

The run_analysis.R script carries out the following:

* Check if the "UCI HAR Dataset" exisits
    * If it does not, the source file is downloaded from the web *download.file()* and unzipped *unzip()*. 
    * The unzipped files are the followings: 
        * UCI HAR Dataset/train/subject_train.txt
        * UCI HAR Dataset/test/subject_test.txt
        * UCI HAR Dataset/train/X_train.txt
        * UCI HAR Dataset/test/X_test.txt
        * UCI HAR Dataset/train/y_train.txt
        * UCI HAR Dataset/features.txt
        * UCI HAR Dataset/activity_labels.txt
* Load the data  
    * The training and test data for the measurements (X), the activities (Y) and subjects (Subj) are loaded from the train and test folders.
    * The features are loaded from features.txt from the root folder.
    * The activity labels are loaded from activity_labels.txt from the root folder.
    * The loading is carried out by *read.table()*, which takes a handle to the unzipped files, and returns a list containing 8 data frames (corresponding to train and test data for X, Y, and Subj, and features and activities).
* The training and test data for X, Y and Subj are merged.
    * This is done via the *rbind()* and *cbind()* functions. 
    * The tidy_dataset has dimension 10299x563 at that time.   
* Measurements that are not means or standard deviations are filtered out of X.
    * The target features are identified as those with mean or std in their names, note that we excluded meanFreq. This is done via grepping with the pattern *mean[^Freq]|std* on the second column of the features data frame.
* Use descriptive activity names to name the activities in the data set
    * The activity labels are used and we use capitalize juste the first letter with our own function *firstCap*
* Use appropriate labels the data set with descriptive variable names.
    * The strings "[()]" and "-" are replaced by "" an "_"respectively
* This dataset is then saved as *tidy_data.txt* with the function *write.table()*
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    * This is done via the *aggregate()* function
* This second dataset is saved as *tidy_data_averaged.txt*   

# Variable Descriptions

The output data is got by transforming data in the input zip source file mentioned in the Original Data section. The source has a file called "features_info.txt" in the root folder. This describes the variables in detail. Here is a subsection of the description:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are:

    mean(): Mean value
    std(): Standard deviation

There are 66 features in the source that correspond to means and standard deviations. The output files both have 68 columns - 1 for subject, 1 for activity, and the remaining 66 columns corresponding to the 66 mean and standard deviation features.

**tidy_data.txt**  
This file holds all the measurements of the 66 features for each subject and activity.

**tidy_data_averaged.txt**  
This file holds the averages for each mean / standard deviation measurement for each subject-activity pair.

# Data Columns
Here is the name of the 68 columns of the tidy_data:   

    subject
    activity
    tBodyAcc_mean_X
    tBodyAcc_mean_Y
    tBodyAcc_mean_Z
    tBodyAcc_std_X
    tBodyAcc_std_Y
    tBodyAcc_std_Z
    tGravityAcc_mean_X
    tGravityAcc_mean_Y
    tGravityAcc_mean_Z
    tGravityAcc_std_X
    tGravityAcc_std_Y
    tGravityAcc_std_Z
    tBodyAccJerk_mean_X
    tBodyAccJerk_mean_Y
    tBodyAccJerk_mean_Z
    tBodyAccJerk_std_X
    tBodyAccJerk_std_Y
    tBodyAccJerk_std_Z
    tBodyGyro_mean_X
    tBodyGyro_mean_Y
    tBodyGyro_mean_Z
    tBodyGyro_std_X
    tBodyGyro_std_Y
    tBodyGyro_std_Z
    tBodyGyroJerk_mean_X
    tBodyGyroJerk_mean_Y
    tBodyGyroJerk_mean_Z
    tBodyGyroJerk_std_X
    tBodyGyroJerk_std_Y
    tBodyGyroJerk_std_Z
    tBodyAccMag_mean
    tBodyAccMag_std
    tGravityAccMag_mean
    tGravityAccMag_std
    tBodyAccJerkMag_mean
    tBodyAccJerkMag_std
    tBodyGyroMag_mean
    tBodyGyroMag_std
    tBodyGyroJerkMag_mean
    tBodyGyroJerkMag_std
    fBodyAcc_mean_X
    fBodyAcc_mean_Y
    fBodyAcc_mean_Z
    fBodyAcc_std_X
    fBodyAcc_std_Y
    fBodyAcc_std_Z
    fBodyAccJerk_mean_X
    fBodyAccJerk_mean_Y
    fBodyAccJerk_mean_Z
    fBodyAccJerk_std_X
    fBodyAccJerk_std_Y
    fBodyAccJerk_std_Z
    fBodyGyro_mean_X
    fBodyGyro_mean_Y
    fBodyGyro_mean_Z
    fBodyGyro_std_X
    fBodyGyro_std_Y
    fBodyGyro_std_Z
    fBodyAccMag_mean
    fBodyAccMag_std
    fBodyBodyAccJerkMag_mean
    fBodyBodyAccJerkMag_std
    fBodyBodyGyroMag_mean
    fBodyBodyGyroMag_std
    fBodyBodyGyroJerkMag_mean
    fBodyBodyGyroJerkMag_stdTaper un message
