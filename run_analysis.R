# STEP 1: loading packages
     library(dplyr) 
     library(plyr)
     library(data.table)

# STEP 2: importing all of the necessary files, assuming they are in the working directory
    ## Testdata files
     x_test <- read.table("x_test.txt", sep = "")
     y_test <- read.table("y_test.txt", sep = "", col.names = "activity_id")
     subject_test <- read.table("subject_test.txt", sep = "", col.names = "subject")
    ## Traindata files
     x_train <- read.table("x_train.txt", sep = "")
     y_train <- read.table("y_train.txt", sep = "", col.names = "activity_id")
     subject_train <- read.table("subject_train.txt", sep = "", col.names = "subject")
    ## files for labelling
     variables_labels <- read.table("features.txt", sep = "",  col.names = c("variables_id", "variables_name"))
     activity_labels  <- read.table("activity_labels.txt", sep = "", col.names = c("activity_id", "activity_name"))

# STEP 3: labelling the variables and activities
      y_test_with_labels <- arrange(join(y_test,activity_labels),activity_id)
      y_train_with_labels <- arrange(join(y_train,activity_labels),activity_id)
      names(x_test) = variables_labels$variables_name
      names(x_train) = variables_labels$variables_name
      names(x_test)<-make.names(names(x_test),unique=TRUE) 
      names(x_train)<-make.names(names(x_train),unique=TRUE) 

# STEP 4: merging the data and create a wrapping it in a format from the dplyr package
      total_test  <- cbind(subject_test,y_test_with_labels,x_test)
      total_train <- cbind(subject_train,y_train_with_labels,x_train)
      total_set <- rbind(total_test,total_train)
      total_set_df <- tbl_df(total_set)
     
# STEP 5: cleaning all the original files and subtotal files
      rm("x_test", "y_test", "subject_test", "x_train", "y_train", "subject_train", "variables_labels", 
      "activity_labels", "y_test_with_labels", "y_train_with_labels", "total_test", "total_train", 
      "total_set")

# STEP 6: Subsetting data on mean and standaard deviation
      selection <- select(total_set_df, subject, activity_name, contains("mean"), contains("std"))

# STEP 7: Creating a tidy dataset
      count_col <- ncol(selection)
      aggregate_dataset <- aggregate(selection[, 3:count_col], by = list(subject = selection$subject, activity_name = selection$activity_name), FUN = mean)  
      arrange_dataset <- arrange(aggregate_dataset, subject, activity_name)

# STEP 8: writing the tidy dataset
      write.table(arrange_dataset, file = "tidy.txt", row.names=FALSE)
     
     