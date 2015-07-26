# Getting and Cleaning Data Project

## Description
### Source Data
A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The source data
can be [downloaded here](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip).

### Description of Final results
The result of the provided script is a clean data set, that contains the average value of each feature grouped
by both the subject (participate) and the activity. The average values included for each feature is the mean and the mean standard deviation. To distiguish between values, each feature named according to
``[feature_name]-[metric]-[axis]``

## Data Cleaning Operations
The following describes the process used to clean the data.

* 1) Load the feature and activity names.
* 2) Load the training and test sets and map the feature names to each column.
* 3) Load the subject IDs and activity IDs for the training and test sets.
* 4) Map the activity names to the activity IDs for each row in the training and test sets.
* 5) Combine the subject IDs, activity IDs, activity names and features into one table for each of the test
and training sets.
* 6) Combine the test and training sets into one set of data.
* 7) Determine which columns correspond to the Mean and Standard deviation columns for
each feature.
* 8) Filter the full dataset on only the selected feature columns and the subject IDs, activity IDs and activity
names columns.
* 9) Group the full dataset by subject ID, activity ID and activity name, and compute the mean of each
feature column.
* 10) Write the final data set to a .txt file.