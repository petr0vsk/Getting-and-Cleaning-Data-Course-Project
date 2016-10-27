## Get the data
#### 1. Download data from Internet 

    source.URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    stopifnot(url.exists(source.URL))
    source.zip <- getBinaryURL(source.URL, ssl.verifypeer=FALSE)
    home.dir <- "/home/petr0vsk"
    project.dir <- "coursera"
    stopifnot(dir.exists(file.path(home.dir, project.dir)))
    setwd( file.path(home.dir, project.dir)) 
    writeBin(source.zip, conn)
    close(conn)
    rm(source.zip)
#### 2. Unzip the file and set working directory
    unzip("Data.zip")
    file.remove("Data.zip")
    setwd("UCI\ HAR\ Dataset")
    
#### 3. Read data from the targeted files (See the README.txt file) 
    x.train <- read.table("train/X_train.txt") # values of varibles features
    y.train <- read.table("train/y_train.txt") # values of varible activity
    subject.train <- read.table("train/subject_train.txt") # values of varible subject
    x.test <- read.table("test/X_test.txt") # values of varibles features
    y.test <- read.table("test/y_test.txt") # values of varible activity
    subject.test <- read.table("test/subject_test.txt") # values of varible subject
    features <- read.table("features.txt") # names of variable features
    activity.labels <- read.table("activity_labels.txt") # levels of varible activity
    
#### 3. let`s do step One and Merges the training and the test sets to create one data set 


