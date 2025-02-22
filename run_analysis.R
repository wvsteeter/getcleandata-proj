  ##set up environment
library(dplyr)
originalpath = getwd()
if (!file.exists("~/ucidata")){
  dir.create("~/ucidata")
}
setwd("~/ucidata")


  
##Aquire data and unzip it
zfile = "dat.zip"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",zfile)
unzip(zfile,overwrite = TRUE)



##for this assignment, only use columns with "mean" or "std"
##form a vector (keycolumns)  to identify these columns
keycolumns = c()
headers <- readLines("UCI HAR Dataset/features.txt") ##column names to analyze
for (t in 1:NROW(headers)) {
  if (length(grep("std\\()", headers[t], value = TRUE)) > 0 | length(grep("mean\\()", headers[t], value = TRUE)) > 0) {
    keycolumns <- rbind(c(t), keycolumns)
  }
}
klength <- length(keycolumns)



##read and clean up raw Test data into a smaller, cleaner table
rawtest <- readLines("UCI HAR Dataset/test/X_test.txt")
subject <- readLines("UCI HAR Dataset/test/subject_test.txt")
activity  <- readLines("UCI HAR Dataset/test/y_test.txt")
cleanedtest <- data.frame(matrix(, nrow = 0, ncol = klength))  ##initialize cleaned-up destination 
for (x in 1:NROW(rawtest)) {
  for (y in 1:klength) {
    cleanedtest[x,y] = as.numeric(substr( rawtest[x], (16*( keycolumns[y]-1)) +1, (16*( keycolumns[y]-1))+16 ))
  }
}
additionalcolumns <- cbind(subject,activity)
cleanedtest <- cbind(cleanedtest,additionalcolumns) %>% mutate(dataset="test")



##read and clean up raw training data into a smaller, cleaner table
rawtrain <- readLines("UCI HAR Dataset/train/X_train.txt") 
subject <- readLines("UCI HAR Dataset/train/subject_train.txt")
activity <- readLines("UCI HAR Dataset/train/y_train.txt")
cleanedtrain <- data.frame(matrix(, nrow = 0, ncol = klength))  ##initialize cleaned-up destination
for (x in 1:NROW(rawtrain)) {
  for (y in 1:klength) {
    cleanedtrain[x,y] = as.numeric(substr( rawtrain[x], (16*( keycolumns[y]-1)) +1, (16*( keycolumns[y]-1))+16 ))
  }
}
additionalcolumns <- cbind(subject,activity)
cleanedtrain <- cbind(cleanedtrain,additionalcolumns) %>% mutate(dataset="train")



##merge the training and test tables
compTrainTest <- rbind(cleanedtrain, cleanedtest)



##Clean up variable names in the cleaned table
newcolnames = c()
for (i in klength:1) {
  newname = sub("\\()","",headers[keycolumns[i]])
  newname = tolower(gsub("-","",substr(newname,regexpr(" ",newname)+1,regexpr("$",newname))))
  colnames(compTrainTest)[colnames(compTrainTest) == names(compTrainTest[klength-i+1])] <- newname
  newcolnames[i] = newname
}


##construct the final tidy table. Write out both table and CSV versions
finalsummary <- select(compTrainTest,-dataset) %>% 
  group_by(subject,activity) %>% 
  summarise_each(funs(mean))
write.table(compTrainTest,file = "Composite-Cleaned-Data.txt",row.names = FALSE)
write.table(finalsummary,file = "Composite-Cleaned-Data-Summary.txt",row.names = FALSE)
write.csv(compTrainTest,file = "Composite-Cleaned-Data.csv",row.names = FALSE)
write.csv(finalsummary,file = "Composite-Cleaned-Data-Summary.csv",row.names = FALSE)

setwd(originalpath)