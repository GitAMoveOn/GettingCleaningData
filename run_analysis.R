#********************************************************************************************************************** 
# Getting and Cleaning Data Course Project
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. 
# You will be graded by your peers on a series of yes/no questions related to the project. 
# 
#********************************************************************************************************************** 
# You will be required to submit: 
# 1) a tidy data set as described below, 
# 2) a link to a Github repository with your script for performing the analysis 
# 3) a code book that describes the variables, the data, and any transformations or work that you performed 
#   to clean up the data called CodeBook.md. 
#   You should also include a README.md in the repo with your scripts. 
#   This repo explains how all of the scripts work and how they are connected.
#********************************************************************************************************************** 
# 
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article. 
#  http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/
# 
# Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
# The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
#
# A full description is available at the site where the data was obtained:
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# Here are the data for the project:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
#********************************************************************************************************************** 
# You should create one R script called run_analysis.R that does the following.
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and 
#     each subject.
#********************************************************************************************************************** 

#---------------------------------------------------------------------------------------------------------------------- 
#---------------------------------------------------------------------------------------------------------------------- 
# 0 Start with clean list of variables / save defaults / load libraries
rm( list = ls() )
setwd( "D:/Work/Dropbox/Coursera/Data" )
# install.packages( "stringr" )
library(stringr)
# install.packages( "tidyr" )
library(tidyr)
# install.packages( "dplyr" )
library(dplyr)
library(tools)
#---------------------------------------------------------------------------------------------------------------------- 
#---------------------------------------------------------------------------------------------------------------------- 
# 1 download file
urlstr <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filenm <- "wear.zip"
download.file( urlstr, filenm )

#---------------------------------------------------------------------------------------------------------------------- 
#---------------------------------------------------------------------------------------------------------------------- 
# 2 Was a zip file, so unzip. Stick in folder named "wear" for now so I know which one it is
unzip( filenm, exdir="wear" )

#---------------------------------------------------------------------------------------------------------------------- 
#---------------------------------------------------------------------------------------------------------------------- 
# 3 explore this unzipped folder
setwd( "wear")
dir()
# Looks like the zipped folder was named "UCI HAR Dataset". move into it
setwd( "UCI HAR Dataset" )
dir()

#---------------------------------------------------------------------------------------------------------------------- 
#---------------------------------------------------------------------------------------------------------------------- 
# 4 First assignment direction -> "1. Merges the training and the test sets to create one data set."
#   IMPORT DATA FILES

# 4.1 get all files under "UCI HAR Dataset"
currfiles <- dir()

for( i in 1:length(currfiles) ) {
  print(currfiles[i])
  
  if( file_ext( currfiles[i] ) == "" ) {
    
  } else {
    temp <- read.table( currfiles[i] )
    assign( gsub( "_", "", strsplit( currfiles[i], ".txt") ), temp )
    rm( temp )
  }
}

dir()

# 4.2 get all files under "test"
setwd( "test" )
dir()

currfiles <- dir()

for( i in 1:length(currfiles) ) {
  print(currfiles[i])
  
  if( file_ext( currfiles[i] ) == "" ) {
    
  } else {
    temp <- read.table( currfiles[i] )
    assign( gsub( "_", "", strsplit( currfiles[i], ".txt") ), temp )
    rm( temp )
  }
}

# 4.2.1 what's in this folder "Inertial Signals"?
setwd( "Inertial Signals" )
dir()
# Need these files too
currfiles <- dir()

for( i in 1:length(currfiles) ) {
  print(currfiles[i])
  
  if( file_ext( currfiles[i] ) == "" ) {
    
  } else {
    temp <- read.table( currfiles[i] )
    assign( gsub( "_", "", strsplit( currfiles[i], ".txt") ), temp )
    rm( temp )
  }
}
dir()

# 4.3 Now get all files under "train" folder
getwd()
setwd("..")
setwd("..")
setwd("train")
dir()

currfiles <- dir()

for( i in 1:length(currfiles) ) {
  print(currfiles[i])
  
  if( file_ext( currfiles[i] ) == "" ) {
    
  } else {
    temp <- read.table( currfiles[i] )
    assign( gsub( "_", "", strsplit( currfiles[i], ".txt") ), temp )
    rm( temp )
  }
}
dir()

# 4.3.1 Now get all files under "train/Inertial Signals"
setwd("Inertial Signals")
dir()

currfiles <- dir()

for( i in 1:length(currfiles) ) {
  print(currfiles[i])
  
  if( file_ext( currfiles[i] ) == "" ) {
    
  } else {
    temp <- read.table( currfiles[i] )
    assign( gsub( "_", "", strsplit( currfiles[i], ".txt") ), temp )
    rm( temp )
  }
}

dir()
setwd("..")
setwd("..")
getwd()

#---------------------------------------------------------------------------------------------------------------------- 
#---------------------------------------------------------------------------------------------------------------------- 
# 5     START MERGING
# 5.1   "test" data first

# "features" looks like it might have the headers for Xtest
head(features)
# the labels are in the second column
colnames( Xtest ) <- features[,2]
head(Xtest)
head(Xtest[,1:10])
V
# Start cbinding tables that appear to have same number of rows
head( subjecttest )
names( subjecttest )[1] <- "subjectid"
head( subjecttest )

head( ytest )
names( ytest )[1] <- "activitycode"
head( ytest )

test <- cbind( subjecttest, ytest )
head( test )

head( activitylabels )
names( activitylabels ) <- c( "activitycode", "activitylabel" )
head( activitylabels )

test <- merge( test, activitylabels, by="activitycode", sort=FALSE )
head( test )

# I don't like this order, so I will redo, and don't need activitycode anymore
test <- test[,c(2,3)]
head( test )
dim( test )

# Bind Xtest onto the subjectids
test <- cbind( test, Xtest )
head( test )
head( test[,1:8] )
dim( test )

# Now go through all the Inertial Signals data frames and relabel the columns
# to make more intuitive sense (for now)

# Process "Inertial Signal" df's
vars <- ls()

dflist <-as.vector( vars[c(grep( "^body.*test$", vars ) ) ] )
dflist2 <-as.vector( vars[c(grep( "^total.*test$", vars ) ) ] )
dflist
dflist2
dflist <- append( dflist, dflist2 )
rm( dflist2 )

#loop through each frame and relabel its columns with better descriptor, then cbind it to the test df
for( i in 1:length( dflist ) ) {
  print( dflist[i] )
  temp <- get( dflist[i] )
  
  for( j in 1:ncol( temp ) ){
    names(temp)[j] <- paste0( strsplit(dflist[i],"test"), "obs", str_pad( j, 3, pad="0") )
  }  
  assign( dflist[i], temp )
  
  test <- cbind( test, get(dflist[i]) )
  
}
names(test)
dim(train)

# Add test/train flag to back end
coltest <- as.data.frame( rep( "test", nrow( test ) ) )
names(coltest) <- "test_flg"
test <- cbind( coltest, test )

#---------------------------------------------------------------------------------------------------------------------- 
# 5.2 Now do "train" data 

# "features" looks like it might have the headers for Xtrain
head(features)
# the labels are in the second column
colnames( Xtrain ) <- features[,2]
head(Xtrain)
head(Xtrain[,1:10])

# Start cbinding tables that appear to have same number of rows
head( subjecttrain )
names( subjecttrain )[1] <- "subjectid"
head( subjecttrain )

head( ytrain )
names( ytrain )[1] <- "activitycode"
head( ytrain )

train <- cbind( subjecttrain, ytrain )
head( train )

head( activitylabels )
names( activitylabels ) <- c( "activitycode", "activitylabel" )
head( activitylabels )

train <- merge( train, activitylabels, by="activitycode", sort=FALSE )
head( train )

# I don't like this order, so I will redo, and don't need activitycode anymore
train <- train[,c(2,3)]
head( train )
dim( train )

# Bind Xtrain onto the subjectids
train <- cbind( train, Xtrain )
head( train )
head( train[,1:8] )
dim( train )

# Now go through all the Inertial Signals data frames and relabel the columns
# to make more intuitive sense (for now)

# Process "Inertial Signal" df's
vars <- ls()

dflist <-as.vector( vars[c(grep( "^body.*train$", vars ) ) ] )
dflist2 <-as.vector( vars[c(grep( "^total.*train$", vars ) ) ] )
dflist
dflist2
dflist <- append( dflist, dflist2 )
rm( dflist2 )

#loop through each frame and relabel its columns with better descriptor, then cbind it to the train df
for( i in 1:length( dflist ) ) {
  print( dflist[i] )
  temp <- get( dflist[i] )
  
  for( j in 1:ncol( temp ) ){
    names(temp)[j] <- paste0( strsplit(dflist[i],"train"), "obs", str_pad( j, 3, pad="0") )
  }  
  assign( dflist[i], temp )
  
  train <- cbind( train, get(dflist[i]) )
  
}
names(train)
dim(train)

# Add test/train flag to back end
# Add test/train flag to back end
coltrain <- as.data.frame( rep( "train", nrow( train ) ) )
names(coltrain) <- "test_flg"
train <- cbind( coltrain, train )

#---------------------------------------------------------------------------------------------------------------------- 
# 5.3 Now make single mega table 
dim(test)
dim(train)
alldat <- rbind( test, train )
dim(alldat)
head( alldat[,1:7] )

names(test)
names(test)[1:564]

#---------------------------------------------------------------------------------------------------------------------- 
#---------------------------------------------------------------------------------------------------------------------- 
# 6 TIDY FOR ACTUAL DELIVERABLE, CREATE FIRST ASSIGNMENT OUTPUT

# Only need value columns related to mean and standard devation.  Welp.
names( alldat )

# Explore the names for variations on mean, std, etc.
rep('mean',names( alldat ) )
names(alldat)[ grep('mean',names( alldat ) ) ]
names(alldat)[ grep('mean\\()',names( alldat ) ) ]
names(alldat)[ grep('std\\()',names( alldat ) ) ]
names(alldat)[ grep('dev',names( alldat ) ) ]
names(alldat)[ grep('standard',names( alldat ) ) ]

# 3rd and 4th option appear to capture the relevant columns create temp dfs for them
alldatmean <- alldat[ , grep('mean\\()',names( alldat ) ) ] 
dim( alldatmean )
alldatstd <- alldat[ , grep('std\\()',names( alldat ) ) ] 
dim( alldatstd )

# Now make a useable table with just the relevant columns
names( alldat )[ 1:29 ]

alldatuse <- cbind( alldat[2:3], alldatmean, alldatstd ) # I really won't need test vs. train

# clean up
rm( alldatmean )
rm( alldatstd )


# Will use tables from dplyr to make summarization easier :)
tblalldat <- tbl_df( alldatuse )
dim( tblalldat )
head(tblalldat)

### ASSIGNMENT OUTPUT
tblalldattidy <- gather( tblalldat, measurement, value, -( c( subjectid, activitylabel ) ) )

# checks
head(tblalldattidy)
dim(tblalldattidy)

#---------------------------------------------------------------------------------------------------------------------- 
#---------------------------------------------------------------------------------------------------------------------- 
# 7 - 2ND ASSIGNMENT OUTPUT
# "Create a second, independent tidy data set with the average of each variable for each activity and each subject."

bysubact <- group_by( tblalldattidy, subjectid, activitylabel, measurement )
head( bysubact )

### ASSIGNMENT OUTPUT
bysubactsmry <- summarize( bysubact, mean(value) )

# checks
dim( bysubactsmry )
head( bysubactsmry, 12 )

