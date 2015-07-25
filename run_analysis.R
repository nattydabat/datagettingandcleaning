#==========================================================================
# Load Data
#--------------------------------------------------------------------------
# Loading feature and activity names.
feature.names <- read.table("./UCI HAR Dataset/features.txt", 
                            col.names = c("id", "feature"))

activity.names <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                             col.names = c("id", "activity"))

#--------------------------------------------------------------------------
# Loading training and test sets and mapping the feature names to each column.
training.set <- read.table("./UCI HAR Dataset/train/X_train.txt",
                           col.names = feature.names$feature)

test.set <- read.table("./UCI HAR Dataset/test/X_test.txt",
                        col.names = feature.names$feature)

#--------------------------------------------------------------------------
# Loading the activity ids for the test and training sets.
training.set.activity <- read.table("./UCI HAR Dataset/train/y_train.txt",
                                    col.names = c("activity.id"))
test.set.activity <- read.table("./UCI HAR Dataset/test/y_test.txt",
                                col.names = c("activity.id"))

#--------------------------------------------------------------------------
# Loading the subject Ids for the training and test sets
training.set.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                                   col.names = c("subject.id"))
test.set.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                               col.names = c("subject.id"))

#==========================================================================
# Combining Data
#--------------------------------------------------------------------------
# Mapping the Activty names to the activity ids
training.set.activity <- merge(training.set.activity, activity.names, 
                               by.x = "activity.id", by.y = "id")

test.set.activity <- merge(test.set.activity, activity.names, 
                               by.x = "activity.id", by.y = "id")

#--------------------------------------------------------------------------
# Combine columns for training set and activity set.....
training.set <- cbind(training.set.subject, training.set.activity, training.set)
test.set <- cbind(test.set.subject, test.set.activity, test.set)

#--------------------------------------------------------------------------
# Combine the training and test sets
full.set <- rbind(training.set, test.set)

#=========================================================================
# Filter Data
#-------------------------------------------------------------------------
# Get list of features that are only the means and standard deviations.
mean.std.columns <- 
  which(grepl("mean()", as.character(feature.names$feature), fixed = TRUE) |
        grepl("std()", as.character(feature.names$feature), fixed = TRUE))

# Since the feature.names does not include the subject.id, activity.id, 
# and activity.name columns, we must offset the mean.std.columns by
# 3.
full.set <- full.set[, c(1,2,3, mean.std.columns + 3)]

#=========================================================================
# Group the full set by subject and activity, and compute the mean
# for each feature column.
#-------------------------------------------------------------------------
mean.set <- aggregate(full.set[, 4:ncol(full.set)], 
               by = list(subject.id = full.set$subject.id, 
                         activity.id = full.set$activity.id,
                         activity = full.set$activity),
               FUN = mean)

#=========================================================================
# Write results to a text file
write.table(mean.set, "data_cleaning_project_results.txt", row.names = FALSE)
