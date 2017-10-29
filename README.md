# datacleaningproject

The associasted script is written as part of the final project for the Getting and Cleaning Data Coursera module. The attached R script, run_analysis.R, aims to achieve the following:

    First, it downloads the dataset if there isn't a pre-existing dataset of the same name in the working directory
    It first loads the activity and feature info, then loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation. Finally, it loads the activity and subject data for each dataset, and merges those columns with the dataset
    It then merges the two datasets
    Subsequently, it converts the activity and subject columns into factor variables.
    Finally, it forms a tidy dataset that consists of the mean value of each variable for each activity pair and subject.

The final result is displayed in the tidy.txt
