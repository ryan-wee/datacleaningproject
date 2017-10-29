library(reshape2)

file <- "getdata_dataset.zip"

## First, download and unzip the dataset of interest:
if (!file.exists(file)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, file, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(file) 
}

# This loads activity labels and features
actLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
actLabels[,2] <- as.character(actLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# The following code extracts only the data on mean and standard deviation
featWanted <- grep(".*mean.*|.*std.*", features[,2])
featWanted.names <- features[featWanted,2]
featWanted.names = gsub('-mean', 'Mean', featWanted.names)
featWanted.names = gsub('-std', 'Std', featWanted.names)
featWanted.names <- gsub('[-()]', '', featWanted.names)


# This part loads the relevant datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featWanted]
trainAct <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainAct, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Then, merge the datasets and add labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featuresWanted.names)

# Convert the activities & subjects into factor variables
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

#Finally, display final tidy dataset into a 'txt' file
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
