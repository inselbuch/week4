#
#
#  run_analysis.R
#
#  getting and cleaning data, week 4, peer-graded assignment
#
#  May 4, 2020 - Inselbuch
#     new module
#
#
#
rm(list=ls())
# options(width=105)
# packageVersion("dplyr")

setwd('c:/users/frank.inselbuch/git/coursera/w4')
#
library(dplyr)
#

# read the activity labels (I was going to hard code this, but...)
# activities = c('WALKING','WALKING_UPSTAIRS','WALKING_DOWNSTAIRS','SITTING','STANDING','LAYING')
fn = "./data/UCI HAR Dataset/activity_labels.txt"
activities <- read.table(fn,header=FALSE,sep="",strip.white=TRUE,
   col.names=c('code','activity'))

# read the features
fn = "./data/UCI HAR Dataset/features.txt"
features <- read.table(fn, col.names = c("n","functions"))


# get the test data
fn = "./data/UCI HAR Dataset/test/X_test.txt"
testX <- read.delim(fn,header=FALSE,sep="",dec=".",strip.white=TRUE,fill=TRUE,
   stringsAsFactors=FALSE, col.names = features$functions)
testX <- tbl_df(testX)

fn = "./data/UCI HAR Dataset/test/Y_test.txt"
testY <- read.delim(fn,header=FALSE,sep="",dec=".",strip.white=TRUE,fill=TRUE,stringsAsFactors=FALSE)

fn = "./data/UCI HAR Dataset/test/subject_test.txt"
testSubject <- read.table(fn,header=FALSE,sep="",dec=".",strip.white=TRUE,fill=TRUE,
   stringsAsFactors=FALSE,col.names=c("subject"))


# get the train data
fn = "./data/UCI HAR Dataset/train/X_train.txt"
trainX <- read.delim(fn,header=FALSE,sep="",dec=".",strip.white=TRUE,fill=TRUE,
   stringsAsFactors=FALSE, col.names = features$functions)
trainX <- tbl_df(trainX)

fn = "./data/UCI HAR Dataset/train/Y_train.txt"
trainY <- read.delim(fn,header=FALSE,sep="",dec=".",strip.white=TRUE,fill=TRUE,
   stringsAsFactors=FALSE)

fn = "./data/UCI HAR Dataset/train/subject_train.txt"
trainSubject <- read.delim(fn,header=FALSE,sep="",dec=".",strip.white=TRUE,fill=TRUE,
   stringsAsFactors=FALSE)


# layer in the activity codes
testDS <- mutate(testX,activity=testY$V1)
trainDS <- mutate(trainX,activity=trainY$V1)

# layer in the subject
testDS <- mutate(testDS,subject=testSubject$V1)
trainDS <- mutate(trainDS,subject=trainSubject$V1)

# merge the data sets
oneDataSet <- bind_rows(testDS,trainDS)

# overwrite the activity column by indexing the integer into the string vector
oneDataSet$activity =activities[oneDataSet$activity,2]

# only pick out columns that contain the word "mean" or "std")
# filter would be choosing rows
# select is choosing columns
# so the third column will be the columns that contain the word mean
# the fourt column will be the columns that contain te word std
oneDataSet <- select(oneDataSet,subject,activity,contains("mean"),contains("std"))

secondDataSet <- oneDataSet %>% group_by(subject,activity) %>% summarize_all(mean)

# as instructed
write.table(secondDataSet,"secondDataSet.txt", row.name=FALSE)
