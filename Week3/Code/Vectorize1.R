#!/usr/bin/env Rscript --vanilla

# Title: Vectorize1.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Example illustrating the differences in speed of loops and the use of vectorization.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Loop function
M <- matrix( runif(1000000), 1000, 1000)

SumAllElements <- function(M) {
    Dimensions <- dim(M)
    Tot <- 0
    for (i in 1:Dimensions[1]) {
        for (j in 1:Dimensions[2]) {
            Tot <- Tot + M[i, j]
        }
    }
    return (Tot)
}

print("Using loops, the time taken is:")
print( system.time(SumAllElements(M)))

print("Using the in-built vectorized function, the time taken is:")
print(system.time(sum(M)))

print("Script done!")