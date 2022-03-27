#Coursera Getting and Cleaning Data Course Project
#Brenda Raíssa de Oliveira
# March 27, 2022

# runAnalysis.r will:

# Input UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

######

setwd("./UCI HAR Dataset/") # changes the current directory as a working directory

features <- as.data.frame(read.delim2("features.txt", header= FALSE, sep = " ")) # read TXT file using "space" as sep and trasnform in data frame

names(features)[1] <- 'n'
names(features)[2] <- 'feature' # rename columns 

activity_labels <- as.data.frame(read.delim("activity_labels.txt", header = FALSE, sep = " ")) # read TXT using "space" as sep file and trasnform in data frame


names(activity_labels)[1] <- 'code'
names(activity_labels)[2] <- 'activity' # rename columns 

setwd("./test/") # changes the current directory as a working directory


subject_test <- as.data.frame(read.delim('subject_test.txt', header = FALSE, sep = " ")) # read TXT file using "space" as sep and trasnform in data frame

x_test <- read.table("X_test.txt", col.names = features$feature) # read Txt file as table using column feature of features object as column name

y_test <- read.table("y_test.txt", col.names = 'label')

setwd("../") # changes two previous directories as a working directory

setwd("./train/") # changes the current directory as a working directory


subject_train <- as.data.frame(read.delim('subject_train.txt', header = FALSE, sep = " ")) # read TXT file using "space" as sep and trasnform in data frame


x_train <- read.table("X_train.txt", col.names = features$feature) # read Txt file as table using column feature of features object as column name

y_train <- read.table("y_train.txt", col.names = 'label')

library(dplyr) 

# merge datas sets:

values_train <- cbind.data.frame(y_train, x_train) # merge data frame columns 

values_test <- cbind.data.frame(y_test, x_test) # merge data frame columns 

join_values<- full_join(values_train, values_test) # merge data sets 

join_subject <- full_join(subject_train, subject_test) # merge data sets 

names(join_subject)[1] <- 'subject' # rename data frame column name

values_ <- cbind.data.frame(join_subject, join_values) # merge data frame columns 

####

acc <- factor(join_values$label,
              labels = activity_labels$activity) # associate labels in data frame with its activity name

f<- cbind.data.frame(acc, join_values) # merge acc with data frame

values <- cbind.data.frame(join_subject, f) # merge data frames columns

tidy <- values %>% select(contains("subject"),contains("label"), contains("acc"),contains("mean"),contains("std")) # select columns that contains theses strings

average_ <- tidy %>% group_by(subject, acc) %>% summarise(across(everything(), mean)) # grouped and apply mean to everything columns   
# across : apply the same transformation to multiple columns and everything : all columns


write.table(average_, "Tidy_data.txt", sep="\t")
