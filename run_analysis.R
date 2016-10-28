# --------------------------------------------
# Getting and Cleaning Data Course Project
# petr0vskjy.aleksander@gmail.com
# -------------------------------------------
library(RCurl)
library(tidyr)
library(dplyr)
library(plyr)
library(stringr)
# --- get and unzip data  from Inet ---
source.URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
stopifnot(url.exists(source.URL))
source.zip <- getBinaryURL(source.URL, ssl.verifypeer=FALSE)
home.dir <- "/home/petr0vsk"
project.dir <- "coursera"
stopifnot(dir.exists(file.path(home.dir, project.dir)))
setwd( file.path(home.dir, project.dir)) 
conn  <- file("Data.zip", open = "wb")
writeBin(source.zip, conn)
close(conn)
rm(source.zip)
unzip("Data.zip")
file.remove("Data.zip")
setwd("UCI\ HAR\ Dataset")
# load data from files
x.train <- read.table("train/X_train.txt") # values of varibles features
y.train <- read.table("train/y_train.txt") # values of varible activity
subject.train <- read.table("train/subject_train.txt") # values of varible subject

x.test <- read.table("test/X_test.txt") # values of varibles features
y.test <- read.table("test/y_test.txt") # values of varible activity
subject.test <- read.table("test/subject_test.txt") # values of varible subject

features <- read.table("features.txt") # names of variable features

activity.labels <- read.table("activity_labels.txt") # levels of varible activity

# -- 1. Merges the training and the test sets to create one data set ----
# create 'x','y' and 'subject' data set's
x.data <- bind_rows(x.train, x.test)
y.data <- bind_rows(y.train, y.test)
subject.data <- bind_rows(subject.train, subject.test)

# -- 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

mean.std.features <-  filter( features, str_detect(features$V2, "-(mean|std)\\(\\)" ) ) 
x.data <- select(x.data, mean.std.features$V1)
names(x.data) <- mean.std.features$V2
  
# -- 3. Uses descriptive activity names to name the activities in the data set
# replase values with correct activity labels
y.data[, 1] <- activity.labels[y.data[, 1], 2]
# set column name
names(y.data) <- "Activities"

# -- 4. Appropriately labels the data set with descriptive variable names.  
# set column name
names(subject.data) <- "Subject"
# bind all the data in a single final data set
final.data.set <- bind_cols(x.data, y.data, subject.data)

# -- 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# aggregate and find means
tidy.data.set <- ddply(final.data.set, .(Subject, Activities), function(x) colMeans(x[, 1:66]))
# make names of columns some more readable
names(tidy.data.set)<-gsub("^t", "time", names(tidy.data.set))
names(tidy.data.set)<-gsub("^f", "frequency", names(tidy.data.set))
names(tidy.data.set)<-gsub("Acc", "Accelerometer", names(tidy.data.set))
names(tidy.data.set)<-gsub("Gyro", "Gyroscope", names(tidy.data.set))
names(tidy.data.set)<-gsub("Mag", "Magnitude", names(tidy.data.set))
names(tidy.data.set)<-gsub("BodyBody", "Body", names(tidy.data.set))
# save hard copy of result
write.csv(tidy.data.set, "tidy_data_set.csv", row.names = F )


