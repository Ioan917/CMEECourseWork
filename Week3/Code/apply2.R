#!/usr/bin/env Rscript --vanilla

# Title: apply2.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Defining my own function.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Function
SomeOperation <- function(v) {
    if (sum(v) > 0) { # note that sum(v) is a single (scalar) value
    return (v * 100)
    }
    return (v)
}

M <- matrix(rnorm(100), 10, 10)
print( apply(M, 1, SomeOperation))

print("Script done!")