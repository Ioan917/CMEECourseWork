#!/usr/bin/env Rscript --vanilla

# Title: break.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Illustrating the use of break in breaking out of loops.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Loop
i <- 0 # initialise i
while (i < Inf) {
    if (i == 10) {
        break
    } # break out of the while loop
    else {
        cat ("i equals", i, "\n")
        i <- i + 1 # update i
    }
}

print("Script complete!")