
#create new directory
if (!file.exists("assignment4")){dir.create("assignment4")}

#download the file and unzip the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "data_file.zip")
unzip("data_file.zip")

library(data.table)

#load activity labels and features data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_labels$V2 <- as.character(activity_labels$V2)

features <- read.table("./UCI HAR Dataset/features.txt")
features$V2 <- as.character(features$V2)

#load the test data and put them together to form a test dataset
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
test <- cbind(subject_test, y_test, X_test)

#load the train data and put them together to form a train dataset
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
train <- cbind(subject_train, y_train, X_train)

#merge two datasets, train dataset and test dataset, assign variables names
All_data <- rbind(train,test)
colnames(All_data) <- c("Subject", "Activity", features[,2])

#convert Activity and Subject to factor and change the labels of activity data
All_data$Activity <- factor(All_data$Activity, levels = activity_labels[,1], labels = activity_labels[,2])
All_data$Subject <- as.factor(All_data$Subject)

#select only variables names containing the mean and the standard deviation of each measurement
pattern <- c(".*mean.*", ".*std.*")
VariablesNeeded <- grep(paste(pattern, collapse = "|"), features[,2], value = TRUE)

#create a list for variables names 
VariablesNames <- c("Subject", "Activity", c(VariablesNeeded))

#create tidy data with selection variables names for the mean and the standard deviation
tidy_data <- All_data[VariablesNames]

#change the variable names
namesTidyData <- names(tidy_data)
namesTidyData <- gsub("-mean", "Mean", namesTidyData)
namesTidyData <- gsub("-std", "Std", namesTidyData)
namesTidyData <- gsub("[-()]", "", namesTidyData)
colnames(tidy_data) <- namesTidyData

#create another data set to record average of each variable and each subject
library(reshape2)
tidy_data_melt <- melt(tidy_data, id = c("Subject", "Activity"))
tidy_data_mean <- dcast(tidy_data_melt, Subject + Activity ~ variable, mean)

write.table(tidy_data_mean, "tidy.txt", row.names = FALSE)
