#!/usr/bin/env Rscript --vanilla

# Title: apply1.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Applying some of R's inbuilt functions.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Build a random matrix
M <- matrix(rnorm(100), 10, 10)

## Take the mean of each row
RowMeans <- apply(M, 1, mean)
print(RowMeans)

## Now the variance
RowVars <- apply(M, 1, var)
print(RowVars)

## By column
ColMeans <- apply(M, 2, mean)
print(ColMeans)

print("Script done!")