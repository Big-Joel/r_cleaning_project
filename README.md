# r_cleaning_project

Only one script is required, run_analysis.R.
## Usage:
simply set the working directory (line 2) and ensure you have the Samsung data in this working directory.

### Details:

The script combined the training and testing data to form one data set. Variable (column) names were added and the activity numbers were replaced with the activity names, to give the data more meaning. Original values other than the mean and standard deviation have been dropped. Finally, the data was grouped into subsets by ActivityName and subject in order to calculate the average (mean) for each subset. 