# This script loads a training, test, participating subjects and activiy files 
# collected from the accelerometers from the Samsung Galaxy S smartphone. 
# The script then prepares a tidy data that can be used for later analysis.

### Step 1: Merge the training and the test sets to create one data set.

# Import the features.txt  file.
features_data = read.table("./data/features.txt")

# Import the training files.
subject_train_data = read.table("./data/train/subject_train.txt")
x_train_data = read.table("./data/train/X_train.txt")  
y_train_data = read.table("./data/train/y_train.txt")  

# Import the test files.
subject_test_data = read.table("./data/test/subject_test.txt")
x_test_data = read.table("./data/test/X_test.txt")  
y_test_data = read.table("./data/test/y_test.txt")  

# Combine the train data.
subject_activity_train_data <- cbind(subject_train_data, y_train_data, x_train_data)

# Combine the test data.
subject_activity_test_data <- cbind(subject_test_data, y_test_data, x_test_data)

# Merge the train and test data as one data set.
train_test_data <- rbind(subject_activity_train_data, subject_activity_test_data)

#head(train_test_data)
#dim(train_test_data)

### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement

# The meaurment variables are inside the second column of the feature_data. For easier manupliation
# replace the parenthesis '()' by '<<parenthesis>>' and hold the valuses in measurment_column_names.
measurment_column_names <- gsub("\\(\\)", "<<parenthesis>>", features_data$V2) 

# Combine the subject and activity column names with the measurment_column_names to form the 
# entire column names for the train_test_data data set.
column_names <- c("subject", "activity", measurment_column_names)

# Assign the column names to the train_test_data.
colnames(train_test_data) <- column_names

# check the column names have been assigned correctly to the train_test_data data set. 
head(names(train_test_data))

# The measurements on the mean and standard deviation are variable names that have the words 'mean' and 'std'
# followed by (). But the () has been replaced by <<parenthesis>> and now they are on the form of 
# mean<<parenthesis>> and std<<parenthesis>>. Select the columns with name that has one of these forms along
# with 'subject' and activity' columns.
train_test_data_mean_std <- train_test_data[,grep("subject|activity|mean<<parenthesis>>|std<<parenthesis>>|meanFreq<<parenthesis>>", names(train_test_data), ignore.case = TRUE, perl = TRUE)]

#head(train_test_data_mean_std)
#dim(train_test_data_mean_std)

### Step 3: Uses descriptive activity names to name the activities in the data set.

# The activity names are given in the activity_labels.txt file. Assign these names to the corresponding labels
# which are the activity clolumn values.
train_test_data_mean_std$activity <- factor(train_test_data_mean_std$activity, labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")) 

#head(train_test_data_mean_std$activity)


### Step 4: Appropriately labels the data set with descriptive variable names.

# Remove the <<parenthesis>> from the variable names (column names). Also Search tBody, tGravity, fBody, 
# and Acc and replace with timeBody, timeGravity, frequencyBody, and Acceleration recpectively. 
column_names_mean_std <- names(train_test_data_mean_std)
column_names_mean_std <- gsub("<<parenthesis>>", "", column_names_mean_std) 
column_names_mean_std <- gsub("tBody", "timeBody", column_names_mean_std) 
column_names_mean_std <- gsub("tGravity", "timeGravity", column_names_mean_std) 
column_names_mean_std <- gsub("fBody", "frequencyBody", column_names_mean_std)
column_names_mean_std <- gsub("Acc", "Acceleration", column_names_mean_std)

# Assign the descriptive variable names as the column names of the train_test_data_mean_std data set.
colnames(train_test_data_mean_std) <- column_names_mean_std

# Now the train_test_data_mean_std is a tidy data set with descriptive variable names.
# Rename it to tidy_train_test_data_mean_std.
tidy_train_test_data_mean_std <- train_test_data_mean_std

#head(tidy_train_test_data_mean_std)
#dim(tidy_train_test_data_mean_std)


### Step 5: From the data set in step 4, create a second, independent tidy data set with the average of each 
### variable for each activity and each subject.

# load the data.table library package of R for easier calulation of the average (mean) of each 
# variable for each activity and each subject.
library("data.table")

# Convert the tidy_train_test_data_mean_std data.frame to data.table format and rename it as tidy_train_test_data_average.
tidy_train_test_data_average <- data.table(tidy_train_test_data_mean_std)


# .SD (Subset of Data) by default holds all the columns of the data.table i.e. tidy_train_test_data_average 
# except the ones specified in "by" and only accessible in columns. The script loops through the columns 
# of .SD using lapply to calclaute the mean (average) of each variable in tidy_train_test_data_average data.table. 
tidy_train_test_data_average <- tidy_train_test_data_average[, lapply(.SD, mean), by = c("subject","activity")]

# Reorder the tidy_train_test_data_average data set by 'subject' column
tidy_train_test_data_average <- tidy_train_test_data_average[order(tidy_train_test_data_average$subject),]

#head(tidy_train_test_data_average)
#dim(tidy_train_test_data_average)

# Write the tidy_train_test_data_average to a text file called tidy_train_test_data_average.txt.
write.table(tidy_train_test_data_average, "tidy_train_test_data_average.txt", row.names = FALSE)

# Check the structure of the data set, also the output to be used with code book.
str(tidy_train_test_data_average)
