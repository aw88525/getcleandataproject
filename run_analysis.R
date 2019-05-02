#download the files
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile = "data.zip", method = "curl")
if(!file.exists("UCI HAR Dataset")){
  unzip("data.zip", files = NULL, exdir = ".")
}

#load the measurement data in the test group
testMeasurements <- read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors = F)
#load the activity data in the test group
testActivity <- read.table("UCI HAR Dataset/test/y_test.txt", stringsAsFactors = F)
#load the id of subject in test group
testsubID <- read.table("UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = F)
#load the measurement data in the train group
trainMeasurements <- read.table("UCI HAR Dataset/train/X_train.txt", stringsAsFactors = F)
#load the activity data in the train group
trainActivity <- read.table("UCI HAR Dataset/train/y_train.txt", stringsAsFactors = F)
#load the id of subject in train group
trainsubID <- read.table("UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = F)
#load the activity labels 
activityLabel <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = F)
#load the features 
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = F)
#bind subject id to features in order to assign to head for measurement data set
row_names <- rbind(c(0, 'ID'), features)


#Appropriate label the dataset with descriptive variable names
#I need to bind the subject id to the measurements
testMeasurements <- cbind(testsubID, testMeasurements)
colnames(testMeasurements) <- row_names[,2]
trainMeasurements <- cbind(trainsubID, trainMeasurements)
colnames(trainMeasurements) <- row_names[,2]
#name the train and test activity
names(trainActivity) <- "Activity"
names(testActivity) <- "Activity"
#I need to bind the activity to the measurements
testset <- cbind(testMeasurements, testActivity)
trainset <- cbind(trainMeasurements, trainActivity)
#Merge the training and test sets to create 
totalset <- rbind(testset, trainset)


#Extact only the measurements on the mean and standard deviation for each measurement
selectedset_meanstd_index <- grep("std\\(|mean\\(", names(totalset))
selectedset <- totalset[,selectedset_meanstd_index]
selectedset <- cbind(totalset$ID,selectedset)



#Use descriptive activity names to name the activities in the dataset
activity_factor <- factor(totalset$Activity)
levels(activity_factor) <- activityLabel[,2]
totalset$Activity <- activity_factor

#create a second, independent tidy dataset with the average of each variable for 
#each activity and each subject
require(reshape2)
totalset_melt <- melt(totalset, id=c(1,length(totalset)))
mean_totalset_melt <- dcast(totalset_melt, ID + Activity ~ variable, mean)
names(mean_totalset_melt)[3:length(mean_totalset_melt)] <- 
  paste("mean of", names(mean_totalset_melt)[3:length(mean_totalset_melt)])

write.table(mean_totalset_melt, file = "tidy_data.txt", sep = ",", row.names = FALSE)
write.csv(mean_totalset_melt, file = "tidy_data.csv")