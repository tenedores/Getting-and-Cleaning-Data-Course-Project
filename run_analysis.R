#Install and load dplyr, data.table, and qdap
install.packages("dplyr")
install.packages("data.table")
install.packages("qdap")
library(dplyr)
library(data.table)
library(qdap)
#Set working directory
setwd("C:/Users/elisa/Documents/data")
#Download data
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile="activity.zip")
#Unzip data
unzip(zipfile = "activity.zip")
#Open data
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
Xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")
ytrain<-read.table("UCI HAR Dataset/train/y_train.txt")
Xtest<-read.table("UCI HAR Dataset/test/X_test.txt")
ytest<-read.table("UCI HAR Dataset/test/y_test.txt")
#Load activity labels and feature names
labels<-read.table("UCI HAR Dataset/activity_labels.txt")
features<-read.table("UCI HAR Dataset/features.txt")
#Pass features as colnames
featuresnames<-as.character(features[,2])
colnames(Xtest)<-featuresnames
colnames(Xtrain)<-featuresnames
#Create train and test datasets
train<-cbind(subject_train, Xtrain, ytrain)
test<-cbind(subject_test, Xtest, ytest)
#Assign colnames to the Subject and Activity columns
colnames(train)[1] <- "Subject"
colnames(test)[1] <- "Subject"
colnames(train)[563] <- "Activity"
colnames(test)[563] <- "Activity"
#1.	Merges the training and the test sets to create one data set.
alldata<-rbind(test, train)
#2.	Extracts only the measurements on the mean and standard deviation for each measurement.
statdata<-alldata[,grep("mean|std|Subject|Activity", names(alldata), value=TRUE)]
#3.	Uses descriptive activity names to name the activities in the data set
statdata$Activity <- as.character(statdata$Activity)
for (i in 1:6){
  statdata$Activity[statdata$Activity == i] <- as.character(labels[i,2])
}
statdata$Activity <- as.factor(statdata$Activity)
#4.	Appropriately labels the data set with descriptive variable names.
messy_names <- c("^t","^f","Acc","Mag","Gyro","BodyBody","std")
tidy_names <- c("Time","Frequency","Acceleration","Magnitude","Gyrometer","Body","Standard_Deviation")
names(statdata) <- mgsub(messy_names,tidy_names,names(statdata),fixed = FALSE)
#5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
mean_tidy_data<-statdata %>% group_by(Subject, Activity)%>%summarize_each(funs(mean))
write.table(mean_tidy_data,"mean_tidy_data.txt", row.name=FALSE, sep='\t')
