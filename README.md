### Getting and Cleaning Data Course Project

#### Source files
**Original data source:** https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

**Files that were eventually used and manipulated in R:**

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

** *Descriptions above came from the README included with the dataset.* **  

All files not listed above were descriptive/narrative in nature.

#### Analysis files
- run_analysis.R - performs all the necessary steps to import the source files listed above and transform and tidy them to create the required deliverables.  Should be able to run from start to finish. May need certain packages, in which case uncomment and needed install functions at the top of the script.
    - tidy dataset that has only the measurements on the mean and standard deviation for each measurement
    - independent tidy data set with the average of each variable for each activity and each subject
- README.md - This file. Describes the files used and process used to arrive at the deliverables.
- Codebook.md - describes the variables, the data, and any transformations or work that you performed to clean up the data
 
#### Comments on decisions
- For the descriptive names for the measurements (from the "X" files), I used the features.txt file.  They're a little technical but definitely descriptive.
- For subject, once I figured out which file/variable it was (subject...txt), I called it subjectid.
- For activity, once I figure out which file/variable it was (ytest/train.txt), I called it activitylabel, once I merged on activity_labels to get them.
- Though it wasn't needed in actual output, I created a variable "test_flg" to differentiate where data came from once I merged everything into one data.frame/table.
- I also merged the files from the\Inertial Signals folders, though, again, ended up not needing it and actually having to ignore the work that went into doing it.  Wasn't perfect anyway since it was still a pivoted, so not 'tidy'.
- In summary, i believe the output is tidy for the most part according to these three principles of tidy data:
  1) Each variable forms a column
  2) Each observation forms a row
  3) Each type of observational unit forms a table
  The only thing it might violate is #2, in that the different measurements are columns in the output.  It can be argued that I could   create a "measurement" column to house the label, and a "value" column to house the actual values.  
