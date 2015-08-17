#Download assignment file
  if(!file.exists("./data")){dir.create("./data")}
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./data/Dataset.zip")

#Unzip and list the files
  unzip(zipfile="./data/Dataset.zip",exdir="./data")
  path_rf <- file.path("./data" , "UCI HAR Dataset")
  files<-list.files(path_rf, recursive=TRUE)
  files

# Read data from the files into the variables

  ## Read the Activity files
  dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
  dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
  
  ## Read the Subject files
  dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
  dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
  
  ## REad the Features files
  dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
   dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

# Properties of files
  str(dataActivityTest)
  str(dataActivityTrain)
  str(dataSubjectTrain)
  str(dataSubjectTest)
  str(dataFeaturesTest)
  str(dataFeaturesTrain)
  
# Merge Training set and Test set to create a data set
  
  ## Concatenate data tables by rows
  dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
  dataActivity<- rbind(dataActivityTrain, dataActivityTest)
  dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)
  
  ## Set name to variables
  names(dataSubject)<-c("subject")
  names(dataActivity)<- c("activity")
  dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
  names(dataFeatures)<- dataFeaturesNames$V2
  
  ## Merge columns to get data frame
  dataCombine <- cbind(dataSubject, dataActivity)
  Data <- cbind(dataFeatures, dataCombine)

# Extract measurement for mean and standard deviation
  subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
  selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
  Data<-subset(Data,select=selectedNames)
  str(Data)

# Descriptive activity names to the activity in data sets
  activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
  head(Data$activity,30)
  
# Label the data
  names(Data)<-gsub("^t", "time", names(Data))
  names(Data)<-gsub("^f", "frequency", names(Data))
  names(Data)<-gsub("Acc", "Accelerometer", names(Data))
  names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
  names(Data)<-gsub("Mag", "Magnitude", names(Data))
  names(Data)<-gsub("BodyBody", "Body", names(Data))
  
# Create tidy data
  library(plyr);
  Data2<-aggregate(. ~subject + activity, Data, mean)
  Data2<-Data2[order(Data2$subject,Data2$activity),]
  write.table(Data2, file = "tidydata.txt",row.name=FALSE)
