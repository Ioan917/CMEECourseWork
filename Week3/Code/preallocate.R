#!/usr/bin/env Rscript --vanilla

# Title: preallocate.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Demonstrate the difference in memory allocation and the speed of operations.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Functions
NoPreallocFun <- function(x) {
    a <- vector() # empty vector
    for (i in 1:x) {
        a <- c(a, i)
        print(a)
        print(object.size(a))
    }
}

print(system.time(NoPreallocFun(10)))

PreallocFun <- function(x) {
    a <- rep(NA, x) # pre-allocated vector
    for (i in 1:x) {
        a[i] <- i
        print(a)
        print(object.size(a))
    }
}

print(system.time( PreallocFun(10)))

print("Script done!")