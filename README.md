Before running the script, please do the following:


1. Install the sqldf package using install.packages("sqldf").

2. Make sure you have all of the required raw data sets, in the correct file structure, in the same directory as your run_analysis.R file.

3. Use setwd() to set your desired working directory, into which the "tidydataset.txt" output file will be written.


What the code does


Values from columns containing the phrases "std()" and "mean()" are extracted and bound with the values from the N and Activity columns, which are replaced with text values in place of numeric values.

The test and train datasets are then merged. Averages are calculated for each column in the merged dataset using the SQLDF package.

The merged dataset is written into the "tidydataset.txt" file.

