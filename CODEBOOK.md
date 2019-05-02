# Code Book
## Download and Unzip
Download the dataset from the url and unzip it into the working directory
## Read files
* testMeasurements : measurement data in test group
* trainMeasurements : measurement data in train group
* testsubID : subject ID in test
* trainsubID : subject ID in train
* testActivity : Activity in test
* trainActivity : Activity in train
* activityLabel : Description of Activity 
* features : Description of measurement (variable) in test and train

## Merge and add description labels to dataset
* row_names : store subject ID and measurement names as a row name 
* testMeasurement : merged dataset of test measurement and subject ID
* trainMeasurement : merged dataset of train measurement and subject ID
* testset : merged dataset of test measurement, subject ID and activity
* trainset : merged dataset of train measurement, subject ID and activity
* totalset : merged dataset of testset and trainset

## Extact only the measurements on the mean and standard deviation for each measurement
* selectedset_meanstd_index : store the indexes of the mean() or std() in the names of measurement
* selectedset : extracted subset (columns) of totalset where mean() or std() are contained in the names of measurement

## Descriptive activity names to name the activities in the dataset
* activity_factor : a factor vector coerced from the activity in dataset matched with activity labels
* totalset: now dataset with descriptive activity labels

## create a second, independent tidy dataset
* totalset_melt : totalset melted with subject ID and Activities as rows and measurement variables as columns
* mean_totalset_melt : tidy data set with subject ID and Activities as rows and mean of measurement variables as columns

