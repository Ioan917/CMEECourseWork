#!/usr/bin/env Rscript --vanilla

# Title: try.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Example use of the try keyword.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Writing the function
doit <- function(x) {
    temp_x <- sample(x, replace = TRUE)
    if( length( unique(temp_x)) > 30) { # only take mean if sample was sufficient
        print( paste("Mean of this sample was:", as.character(mean(temp_x))))
    }
    else {
        stop("Couldn't calculate mean: too few unique values!")
    }
}

## Generate a population
popn <- rnorm(50)
hist(popn)

## Running the function using lapply
result <- lapply(1:15, function(i) try(doit(popn), FALSE))
# lapply must include try attribute if stop() has been used

## Inspecting the result object
class(result)
result

## Alternatively using a loop to manually store the results
result <- vector("list", 15) # Preallocate / Initialize
for (i in 1:15) {
    result[[i]] <- try(doit(popn), FALSE)
}

print("Script done!")