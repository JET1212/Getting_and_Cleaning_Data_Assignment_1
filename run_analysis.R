## Loads the sqldf library items.
## Be sure to install the package first by using install.package("sqldf").
library(sqldf)

## Our working directory
dir <- "UCI HAR Dataset"

## Gets the names of the columns
drawColumnNames <- function(){
    columns <- read.table(paste(dir, "\\", "features.txt", sep=""), stringsAsFactors=FALSE)[,2]
    temp <- c(grep("-mean()", columns, fixed = T), grep("-std()", columns, fixed = T))
    names = character()
    for (a in 1:length(columns)) {
        if (a %in% temp) {
            b <- columns[a]
            b <- gsub("\\(", "", b)
            b <- gsub("\\)", "", b)
            b <- gsub("\\-", "_", b)
            names <- c(names, b)  
        } 
    }
    names
}

## Gets the widths of the columns
drawColumnWidths <- function(){
    columns <- read.table(paste(dir, "\\", "features.txt", sep=""), stringsAsFactors=FALSE)[,2]
    temp <- c(grep("-mean()", columns, fixed = T), grep("-std()", columns, fixed = T))
    widths = numeric()
    for (a in 1:length(columns)) {
        widths <- c(widths, if (a %in% temp) 16 else -16)
    }
    widths
}

## Gets the data from the raw data sets
drawData <- function(df, lf, sf){
    theFile <- paste(dir, "\\", df, sep = "")
    result <- read.fwf(theFile,  widths = drawColumnWidths())
    colnames(result) <- drawColumnNames()
    theFile <- paste(dir, "\\", lf, sep = "")
    d <- read.fwf(theFile, widths=c(5))
    names(d) <- c("Activity")
    result$Activity <- d[, "Activity"]        
    labels <- read.table(paste(dir, "\\", "activity_labels.txt", sep=""), sep=" ", stringsAsFactors=FALSE)
    names(labels) <- c("id", "name")   
    for (e in 1:nrow(result)) {
        c <- labels[labels$id == result[e, "Activity"], "name"]
        result[e, "Activity"] <- c
    }    
    theFile <- paste(dir, "\\", sf, sep = "")
    d <- read.fwf(theFile, widths=c(5))
    names(d) <- c("N")
    result$N <- d[, "N"]    
    result
}

# Function for building a sql command that will be executed during the analysis.
buildCommand <- function(dataset){
    statement <- "SELECT N, Activity"   
    names <- drawColumnNames()
    for(name in names){
        statement <- paste(statement, ", AVG(", name, ") AS ", name, sep = "")
    }
    paste(statement, "FROM", dataset, "GROUP BY N, Activity", sep = " ")
}

# Function that initiates the analysis process.
run_analysis <- function(){	
    dataSet <- drawData("train\\X_train.txt", "train\\Y_train.txt", "train\\subject_train.txt")
    dataSet2 <- drawData("test\\X_test.txt", "test\\Y_test.txt", "test\\subject_test.txt")
    dataSet <- rbind(dataSet2, dataSet)
    dataSet2 <- NULL
    dataSet <- sqldf(buildCommand("dataSet"))
    write.csv(dataSet, file="tidydataset.txt", quote=FALSE, row.names=FALSE)      
}

# Start analyzing the data.
run_analysis()