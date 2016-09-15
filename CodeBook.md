CodeBook

The data is a modification from data set available from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The original dat set contains a README file which explain the data completely.

The scripts, run_analysis.R, contains steps to obtain the required form.
1. The two data sets, "train" and "test" data set, were uploaded in to R and a data table was created for each data set.
2. The two data tables were then merged to make a combined data set.
3. A new data set was created, from the combined data set, which only contain variables for mean and standard deviation.
4. The variable names and activity names were altered.
5. A new data set, in tidy.txt, was created recording the mean for each measurement in the data and for each subject.

