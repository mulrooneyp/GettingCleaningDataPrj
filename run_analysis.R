## This script is mulrooneyp's effort Getting and Cleaning Data Course Project
##
## This script uses data collected from the accelerometers from the Samsung Galaxy S smartphone. 
## A full description is available at the site where the data was obtained: 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## Here are the data for the project: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##
## The script 
## 1) Merges the training and the test sets to create one data set.
## 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3) Uses descriptive activity names to name the activities in the data set
## 4) Appropriately labels the data set with descriptive variable names. 
## 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##
## The dataset is called the "UCI HAR Dataset" and the script assumes there is a directory called 
## UCI HAR Dataset in the working directory

setwd("./UCI HAR Dataset")


#step 1 - Merges the training and the test sets to create one data set.

  #read in the feature descriptions
  
    features<-read.table("./features.txt",header=FALSE)
    
  #READ IN THE TEST DATA
  
      #read in the sensor test data and set the column names to the feature descriptions
        SensorData<-read.table("./test/X_test.txt",col.names =
                               features[,2], header=FALSE)
      
      #add the activity ID data to the sensor test data
        SensorActivityID <-read.table("./test/y_test.txt",col.names = 
                                  c("Activity_ID"), header=FALSE)
        SensorData <- cbind(SensorActivityID[1],SensorData, header=FALSE)
      
      #add the subject ID data to the sensor test data
        SensorSubjectID <-read.table("./test/subject_test.txt",col.names = 
                                  c("Subject_ID"), header=FALSE)
        SensorData <- cbind(SensorSubjectID[1],SensorData, header=FALSE)
    
  #READ IN THE TRAINING DATA
  
      #read in the sensor training data and set the column names to the feature descriptions
        SensorData2<-read.table("./train/X_train.txt",col.names =
                               features[,2], header=FALSE)
      
      #add the activity ID data to the sensor training data
        SensorActivityID2 <-read.table("./train/y_train.txt",
                                 col.names = c("Activity_ID"), header=FALSE)
        SensorData2 <- cbind(SensorActivityID2[1],SensorData2, header=FALSE)
      
      #add the subject ID data to the sensor training data
        SensorSubjectID2 <-read.table("./train/subject_train.txt",col.names = 
                                  c("Subject_ID"), header=FALSE)
        SensorData2 <- cbind(SensorSubjectID2[1],SensorData2, header=FALSE)
  
  #COMBINE THE TEST AND TRAINNIG DATA

    SensorData <-rbind(SensorData,SensorData2)

#STEP2 - Extracts only the measurements on the mean and standard deviation for each measurement. 

    #extract the mean & standard deviation measurements
      SensorData <- SensorData[,grep((c("_ID|mean()|std()")),
                                   names(SensorData),value=TRUE,ignore.case = TRUE)]
    
# STEP 3 - Uses descriptive activity names to name the activities in the data set

    #add an activity labels column to the data
      ActivityLabels <- read.table("./activity_labels.txt", 
                                 col.names = c("Activity_ID","Activity_Label"), 
                                 header=FALSE)
    
      SensorData = merge(SensorData,ActivityLabels,by.x="Activity_ID",by.y="Activity_ID",all=TRUE)

# STEP 4 -  Appropriately labels the data set with descriptive variable names. 

  # note this step was partially completed in step 1, where the column names of SensorData was set to
  # the list of feature names in the features.txt file
  # in this step, we'll clean up the column manes by removing "..." and ".."

    names(SensorData) <- sub("...",".",names(SensorData), fixed=TRUE)
    names(SensorData) <- sub("..",".",names(SensorData), fixed=TRUE)

# STEP 5 - creates an independent tidy data set with the average of each variable for 
# each activity and each subject

library(reshape2)

#remove Activity_ID (no longer needed)
  SensorData$Activity_ID <- NULL

  SensorMelt <- melt(SensorData,id.vars=c("Activity_Label","Subject_ID"),
                  measures.var=names(SensorData))

  SensorAve <- dcast(SensorMelt,Activity_Label + Subject_ID ~ variable, mean)

  View(SensorAve)


