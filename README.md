
README
====================================================

In this project the training and test files with participating subjects and activiy files collected from the accelerometers 
from the Samsung Galaxy S smartphone are given. Write a run_analysis R script that prepares a tidy data that can be used for later analysis.

This project has 4 files:

1. ReadMe markdown document (this file),  at Github repo
2. Codebook markdown document,  at Github repo
3. run_analysis R script, at Github repo
4. tidy data text file called 'tidy_train_test_data_average.txt' uploaded at Course project site. 


Files loaded and used by run_analysis R script to create the tidy data:

 1. 'features.txt': List of all features that are used as variables and will form the column names.
 
 Training files:
 2. 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. 
     Its range is from 1 to 30.
 3. 'train/X_train.txt': Training set
 4. 'train/y_train.txt': Training activity labels.
 
 Test files:
 5. 'train/subject_test.txt': Test subject.
 6. 'test/X_test.txt': Test set.
 7. 'test/y_test.txt': Test activity labels.
 
 8. 'activity_labels.txt': Links the class labels with their activity name.

How run_analysis R script processes the above files and create the rquried tidy data sets:


Step 1: Merges the training and the test sets to create one data set.

	- Import the features.txt file as feature_data
	- 
	- Import the training files.
	- 
	- Import the test files.
	- 
	- Combine the imported training files as 'subject_activity_train_data' data.frame.
	- 
	- Combine the imported test files as 'subject_activity_test_data' data.frame.
	
	- Merge the training (subject_activity_train_data) data set and test (subject_activity_test_data) data set as 
	  one data set called 'train_test_data'


Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
	- Extract the meaurment variables from feature_data second column, remove'()', and hold the values in the 
	  'measurment_column_names'
	- Name the first two columns as "subject' and 'activity' and attach them to the 'measurment_column_names' 
	   to form the entire 'column_names' for the 'train_test_data data set'.
	- Assign the column_names to the train_test_data.
	- The measurements on the mean and standard deviation are variable names that have the words 'mean' and 'std'
	  followed by (). But the () has been replaced by <<parenthesis>> and now they are on the form of 
	  mean<<parenthesis>> and std<<parenthesis>>. Select the columns with name that has one of these forms along 
	  with 'subject' and activity' columns using the grep function in R regular expression.
	- Assign the new data set selected using grep to a new data set called 'train_test_data_mean_std'

Step 3: Uses descriptive activity names to name the activities in the data set.
	- The activity names are given in the activity_labels.txt file. Map these names to the corresponding labels
	  which are in the activity clolumn in the 'train_test_data_mean_std' data set.

Step 4: Appropriately labels the data set with descriptive variable names.
  - Copy the column names of the 'train_test_data_mean_std' to 'column_names_mean_std'
	- Remove the <<parenthesis>> from 'column_names_mean_std'.
	- Search tBody, tGravity, fBody, and Acc and replace with timeBody, timeGravity, frequencyBody, and 
	  Acceleration recpectively inside the 'column_names_mean_std'.
	- Assign column_names_mean_std as the column names of the 'train_test_data_mean_std' data set.
	- At this stage the data is tidy and rename 'train_test_data_mean_std' as 'tidy_train_test_data_mean_std' data set.


Step 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
	- For this step "data.table" library package of R is used for easier calulation of the average (mean).
	- Convert the 'tidy_train_test_data_mean_std' data set which is a data.frame to data.table format and rename it 
	  as 'tidy_train_test_data_average'.
	- .SD (Subset of Data) by default holds all the columns of the data.table i.e. tidy_train_test_data_average except 
	  the ones specified in "by" and only accessible in columns. 
	- Loop through the columns of .SD using lapply to calclaute the mean (average) of each variable 
	  in 'tidy_train_test_data_average'.
	- Reorder the tidy_train_test_data_average data set by 'subject' column.
  - Write the tidy_train_test_data_average data set to a text file called 'tidy_train_test_data_average.txt'.
  - Submit/Upload the 'tidy_train_test_data_average.txt' file at course project site.
