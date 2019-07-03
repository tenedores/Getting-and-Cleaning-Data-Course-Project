# Getting-and-Cleaning-Data-Course-Project

Coursera Data Science Certificate - Getting and Cleaning Data final project

Description
This repo is to satisfy the final project of the Getting and Cleaning Data course of the Coursera JHU Data Science Certificate.
The data comes from a Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
UCI project website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
UCI data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Files
run_analysis.R : The R script
README.md : This Readme
mean_tidy_data.txt : The output (a tidy data set)
CodeBook.md : A description of the variables, the data, and the transformations I performed to clean up the data 

What it Does
Running run_analysis.R downloads the UCI data, reads it as R data objects, merges data sets, modifies variable names and factors to be more descriptive, and lastly outputs a summary of means and stds grouped by subject and activity (mean_tidy_data.txt)
