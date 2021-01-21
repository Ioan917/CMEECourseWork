#!/usr/bin/env Rscript --vanilla

# Title: browse.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Using browser() to insert a breakpoint out of loops.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Loop function
Exponential <- function(N0 = 1, r = 1, generations = 10){
  # Runs a simulation of exponential growth
  # Returns a vector of length generations
  
  N <- rep(NA, generations) # Creates a vector of NA
  
  N[1] <- N0
  for (t in 2:generations) {
    N[t] <- N[t-1] * exp(r)
    browser() # inserts a breakpoint
  }
  return (N)
}

plot(Exponential(), type="l", main="Exponential growth")

print("Script done!")