This readme is mulrooneyp's effort at the Getting and Cleaning Data Course Project

### Introduction

	This script uses data collected from the accelerometers from the Samsung Galaxy S smartphone. 
	A full description is available at the site where the data was obtained: 

	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

	Here are the data for the project: 
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

	The script 
		1) Merges the training and the test sets to create one data set.
		2) Extracts only the measurements on the mean and standard deviation for each measurement. 
		3) Uses descriptive activity names to name the activities in the data set
		4) Appropriately labels the data set with descriptive variable names. 
		5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

	The dataset is called the "UCI HAR Dataset" and the script assumes there is a directory called 
	UCI HAR Dataset in the working directory


### STEP 1 Merges the training and the test sets to create one data set.

	1) Use read.table to load feature data from X_test.txt), the Activity_ID from y_text.txt and the
	Subject_ID from Subject_test.txt into separate dataframes
	2) The row names for X_test.txt are extracted from the file features.txt
	3) Repeat 1&2 for the training data "X_train.txt", "y_train.txt" and "Subject_train.txt"
	4) Combine the test and training data into a single dataframne called "SensorData" using rbind

### STEP 2 Extract only the measurements on the mean and standard deviation for each measurement. 

	Use the grep function to subset on the column names of SensorData, where the pattern is
	"_ID|mean()|std()"

### STEP 3 Use descriptive activity names to name the activities in the data set

	Load the Activity_ID and Activity_Label from "activity_labels.txt" into a dataframe called
	"ActivityLabels"
	Merge ActivityLables and SensorData on the common variable "Activity_ID"

### STEP 4 Appropriately labels the data set with descriptive variable names.

	This step was partially completed in step 1, where the column names of SensorData was set when the
	data was read in from X_test.txt
	In step 1, The row names for X_test.txt and X_train.txt are extracted from the file features.txt 
	However the column names are a bit messy, "-()" was replaced bu "..."  and "()" was replaced by ".."
	in this step, we'll clean up the column manes by removing "..." and ".."

### STEP 5 create an independent tidy data set with the average of each variable for each activity and	each subject
	uses the reshape2 library
	Activity_ID is removed from SensorData, as it's no longer required (replaced by the more descriptive
	"ActivityLabels")
	The SensorData dataframe is melted from a 87 variable data frame into a 4 variable dataframe.
		The two ID variables are set to ""ActivityLabels" and "Subject_ID"
		The remaining 85 feature variables are melted into the "variable" and "value" columns
	The melted dataframe is then cast into a tidy data set with the average of each variable for each
	activity and each subject using dcast() and mean
 

