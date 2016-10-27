## Get the data
#### 1. Download data from Internet 

    source.URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    stopifnot(url.exists(source.URL))
    source.zip <- getBinaryURL(source.URL, ssl.verifypeer=FALSE)
    home.dir <- "/home/petr0vsk"
    project.dir <- "coursera"
    stopifnot(dir.exists(file.path(home.dir, project.dir)))
