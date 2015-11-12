Output 

This program outputs to comma separated values file format, or CSV file format, with column headers as the first row.


Variables Used

N = the input source number from 1 to 30
Activity = The activity monitored in the input source containing text values from this list: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING

All other columns are named using the following naming convention: measurement_suffix

Possible suffixes:

mean - The mean of the measurements' mean values
std - The mean of the measurements' standard deviation values
mean_X - The mean of the measurements' X axis mean values
mean_Y - The mean of the measurements' Y axis mean values
mean_Z - The mean of the measurements' Z axis mean values
std_X - The mean of the measurements' standard deviation of X axis values
std_Y - The mean of the measurements' standard deviation of y axis values
std_Z - The mean of the measurements' standard deviation of z axis values

Data Sources

The dataset includes the following files:

test/X_test.txt, which is the test set
test/y_test.txt, which is the list of test labels
features_info.txt, which shows information about the variables used in the feature vector
features.txt, which is a list of all features
activity_labels.txt, which links the class labels to their activity names
train/X_train.txt, which is the training set
train/y_train.txt, which is the list of training labels
README.txt

