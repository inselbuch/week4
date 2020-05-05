"# week4" 

For week 4 of the data science course "Getting and Cleaning Data" we were tasked with loading and manipulating some data.
The source data is in a ridiculous format separated into numerous data files just to make this exercise more difficult.

All the source files are available from this URL

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

After unzipping that thing you will get this set of relevant files:

UCI HAR Dataset
   |
   +---  activity_labels.txt
   +---  features.txt
   +---  test
            |
            +---  subject_test.txt
            +---  X_test.txt
            +---  y_test.txt
   +---  train
            |
            +---  subject_train.txt
            +---  X_train.txt
            +---  y_train.txt

And this is what is in these files:

activity_labels.txt - associates an integer number with six (6) different activities in text
features.txt - identifies the 561 columns of measurements
subject_test.txt - a vector of integers indentifying the subject for each of the sets of measurements in the "test" data

X_test.txt - 2947 rows of measurements each with 561 columns
X_train.txt - 7352 rows of measurements each with 561 columns

y_test.txt - 2947 rows indicating the activity for the corresponding row in the X_test.txt file
   (and yes, this is a lowercase y whereas the X is uppercase in the corresponding file... I guess that is called tidy?)
y_train.txt - 7532 rows indicating the activity for the corresponding row in the X_train.txt file

The analysis is performed in the R source code file run_analysis.R which produces the following data sets:

oneDataSet

   contains rows from both the test and train data sets unioned together
   has the column activity which has been translated from a number to the text label
   contains columns for subject and activity plus columns containing the word "mean" or the word "std"
   i left the variable names alone as I thought those were descriptive just as they were thank you

secondDataSet

   average of each variable in oneDataSet grouped by subject and activity


