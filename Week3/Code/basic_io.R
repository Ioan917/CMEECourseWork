#!/usr/bin/env Rscript --vanilla

# Title: basic_io.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: A simple script to illustrate R input-output
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Run line by line and check inputs to understand what it is doing

MyData <- read.csv("../Data/trees.csv", header = TRUE) # import with headers

write.csv(MyData, "../Results/MyData.csv") # write it out as a new file

write.table(MyData[1,], file = "../Results/MyData.csv", append = TRUE) # append to it

write.csv(MyData, "../Results/MyData.csv", row.names=TRUE) # write row names

write.table(MyData, "../Results/MyData.csv", col.names = FALSE) # ignore column names

print("Script complete!")