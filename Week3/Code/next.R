#!/usr/bin/env Rscript --vanilla

# Title: next.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Illustrate the use of next in passing to the next iteration of a loop.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## for loop
for (i in 1:10) {
    if ((i %% 2) == 0) # check if the number is odd
    next #pass to next iteration of loop
    print(i)
}

print("Script complete!")