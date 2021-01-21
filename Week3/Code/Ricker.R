#!/usr/bin/env Rscript --vanilla

# Title: Ricker.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Discrete population model.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Ricker model
Ricker <- function( N0=1, 
                    r=1, # intrinsic growth rate
                    K=10, # carrying capacity
                    generations=50) {
    
    # Runs a simulation of the Ricker model
    # Returns a vector of length generations

    N <- rep(NA, generations) # Creates a vector of NA

    N[1] <- N0 
    for (t in 2:generations) {
        N[t] <- N[t-1] * exp(r*(1.0-(N[t-1]/K)))
    }
    return(N)
}

plot(Ricker(generations=10), type="l")

print("Script done!")