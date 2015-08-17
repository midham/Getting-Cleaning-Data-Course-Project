#Description

Additional information about the variables, data and transformations used in the course project for the Johns Hopkins Getting and Cleaning Data course.

#Source Data

A full description of the data used in this project can be found at The UCI Machine Learning Repository
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Get Data
Download and unzip data using download.file and unzip into UCI HAR DataSet

#Read data from files  into variables
Read Activity files, Subject files and Features files

#Properties of files
 str(dataActivityTest)
        str(dataActivityTrain)
        
        str(dataSubjectTrain)
        
        str(dataSubjectTest)
        
        str(dataFeaturesTest)
        
        str(dataFeaturesTrain)

#Merge files to create a dataset
Concatenate data tables by rows
Set name to variables
Merge column to get data frame

#Extract measurement for mean and standard deviation
Use Data as the variable

#Labelling Data
names(Data)<-gsub("^t", "time", names(Data))
        names(Data)<-gsub("^f", "frequency", names(Data))
        
        names(Data)<-gsub("Acc", "Accelerometer", names(Data))
        
        names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
        
        names(Data)<-gsub("Mag", "Magnitude", names(Data))
        
        names(Data)<-gsub("BodyBody", "Body", names(Data))

#Create tidy data
Name tidy data file as tidydata.txt



