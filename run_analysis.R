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


# merge datas sets:

values_train <- cbind.data.frame(y_train, x_train) # merge data frame columns 

values_test <- cbind.data.frame(y_test, x_test) # merge data frame columns 

join_values<- full_join(values_train, values_test) # merge data sets list 

join_subject <- full_join(subject_train, subject_test) # merge data sets list 

names(join_subject)[1] <- 'subject' # rename data frame column name

values_end <- cbind.data.frame(join_subject, join_values) # merge data frame columns 


acc <- factor(data_set$type,
               labels = c("toy", "food", "electronics", "drinks"))

library(tidyr)


