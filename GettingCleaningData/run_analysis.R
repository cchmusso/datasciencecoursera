##############################################
### run_analysis.R
### Script cleans sensor data from Galaxy S device for analysis.
### 1. Merges the training and the test sets to create one data set.
### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
### 3. Uses descriptive activity names to name the activities in the data set
### 4. Appropriately labels the data set with descriptive variable names.
### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##############################################


## Load required libraries.
library(plyr)
library(Hmisc)
library(stringi)
## If data does not exist, dowload it. 
if(!dir.exists("UCI HAR Dataset")) {
  fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="zipfile.zip",method="curl")
  unzip("zipfile.zip", files = NULL, list = FALSE, overwrite = TRUE,
        junkpaths = FALSE, exdir = ".", unzip = "internal",
        setTimes = FALSE)
}

## Read raw data files into memory for processing.
trainSubj<-read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE, col.names = "subject")
testSubj<-read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE, col.names = "subject")

trainX<-read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)
testX<-read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)

trainY<-read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE, col.names = "activity")
testY<-read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE, col.names = "activity")

featuresLabels<-read.table("UCI HAR Dataset/features.txt",header=FALSE, col.names = c("id", "name"))
activityLabels<-read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE, col.names = c("id", "name"))

### 1. Merges the training and the test sets to create one data set.
tidy_dataset<-rbind(trainSubj, testSubj)

activities<-rbind(trainY, testY)
tidy_dataset$activity <-activityLabels$name[activities$activity]

features <- rbind(trainX, testX)
colnames(features) <- featuresLabels$name
tidy_dataset <- cbind(tidy_dataset, features)


### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## Extracting the columns representing the measurements on the mean and standard deviation
extract<-grep("(mean|std)",colnames(tidy_dataset), value = TRUE)

## Keep only extracted columns, subject and activity
tidy_dataset<-tidy_dataset[,c("subject","activity",extract)]


### 3. Uses descriptive activity names to name the activities in the data set
tidy_dataset$activity<-gsub("_"," ",tidy_dataset$activity)
tidy_dataset$activity<-stri_trans_totitle(tidy_dataset$activity)


### 4. Appropriately labels the data set with descriptive variable names.
colnames(tidy_dataset)<-gsub("[()]","",colnames(tidy_dataset))
colnames(tidy_dataset)<-gsub("-","_",colnames(tidy_dataset))

write.table(tidy_dataset,"tidy_data.txt",row.names=F)

### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_dataset_averaged <- aggregate( . ~ activity+subject, data= tidy_dataset, mean)

write.table(tidy_dataset_averaged,"tidy_data_averaged.txt",row.names=F)

message("Please find the tidy data in the tidy_data_averaged.txt file saved the working directory")