# Readme file
=============
## how the script “run_analysis.R” works 
----------------------------------------

### STEP 1: loading packages
To make sure that all of the package are avaibele 

### STEP 2: importing all of the necessary files, assuming they are in the working directory
Importing the files for the original source in R data tables. To make sure that non of the data is lost 

### STEP 3: labelling the variables and activities
Because the x-test and x-train didn’t have any column names the are added from the file variables_label that was imported from features.txt in step 2. This is done by naming the columns with names(). The names then made unique.
The files y-test and y-train had only id’s so the descriptive names ware added from the file activity_labels.txt that was imported in step 2 and put into R-datatable activity_labels. This is done by joining the y-files with activity_labels file 

### STEP 4: merging the data and create a wrapping it in a format from the dplyr package
To get a one total set of the data. The files are merged. First to merge the subject, x, and y file for the test and train data with the cbind() function
Then merge those two datasets with the rbind() function. Finally putting the total set in a tbl_df from the dplyr package 

### STEP 5: cleaning all the original files and subtotal files
Removing the files that are not necessary after creating the total dataset

### STEP 6: Subsetting data on mean and standaard deviation
Selection only the measerments with the mean of std with the select() function of the dplyr package

### STEP 7: Creating a tidy dataset
Creating a tidy data set by doing a aggregation by the columns subject and activity_name. After the aggregation arrange the dataset for a more readable dataset. The coun_col() function is for counting the amout of column for the aggregate() function

### STEP 8: writing the tidy dataset
Wrinting the dataset to a file.     
