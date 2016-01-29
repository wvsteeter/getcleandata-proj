### Getting and Cleaning Data Course Project

This project contains the following files to satisfy the requirements of the "Getting and Cleaning Data" course final project:

readme.MD (this file)
run_analysis.R (the R script)
gcdprojCodeBook.pdf (codebook for the output files)
Composite-Cleaned-Data.csv  (CSV format of final merged data)
Composite-Cleaned-Data.txt  (txt format of final merged data)
Composite-Cleaned-Data-Summary.csv  (CSV format of final merged data summarized by activity and subject)
Composite-Cleaned-Data-Summary.txt  (txt format of final merged data summarized by activity and subject)

The scrpit creates a new directory ("ucidata") for processing the following data set:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip



The script will add 4 output files to the "ucidata" directory:

* Composite-Cleaned-Data.txt - This file is a merged data set of the 2 original raw data sets in the downloaded zip file; train and test. Only variables which represent a mean or standard deviation are pulled from the original raw data.

* Composite-Cleaned-Data.csv - Same as Composite-Cleaned-Data.txt but in csv format

* Composite-Cleaned-Data-summary.txt - This file is a summarized version of Composite-Cleaned-Data.txt. It provides a mean of each variable in Composite-Cleaned-Data.txt grouped by subject and activity.

* Composite-Cleaned-Data-summary.csv - Same as Composite-Cleaned-Data-summary.txt but in csv format



The script and resulting data where assembled with:
R v.3.2.3
RStudio 0.99.489
Windows 10 PC
