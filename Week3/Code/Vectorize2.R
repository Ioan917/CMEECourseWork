#!/usr/bin/env Rscript --vanilla

# Title: Vectorize2.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Vectorizing a stochastic Ricker model.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Set the seed
set.seed(1)

## Runs the stochastic Ricker equation with gaussian fluctuations
stochrick <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears=100) {
  
  N <- matrix(NA, numyears, length(p0))  #initialize empty matrix
  
  N[1, ] <- p0
  
  for (pop in 1:length(p0)){ #loop through the populations
    
    for (yr in 2:numyears){ #for each pop, loop through the years
      
      N[yr, pop] <- N[yr-1, pop] * exp(r * (1 - N[yr - 1, pop] / K) + rnorm(1, 0, sigma)) # add one fluctuation from normal distribution
      
    }
    
  }
  return(N)
  
}

# Now write another function called stochrickvect that vectorizes the above 
# to the extent possible, with improved performance: 
stochrickvect <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears=100) {
  
  N <- matrix(NA, numyears, length(p0))  #initialize empty matrix
  
  N[1, ] <- p0
  
  for (yr in 2:numyears){ #for each pop, loop through the years
    
    N[yr, ] <- N[yr-1, ] * exp(r * (1 - N[yr - 1, ] / K) + rnorm(1, 0, sigma)) # add one fluctuation from normal distribution
    
  }
  
  return(N)
}

print("Non-vectorized Stochastic Ricker takes:")
print(system.time(normal<-stochrick()))

print("Vectorized Stochastic Ricker takes:")
print(system.time(vect<-stochrickvect()))

print("Script done!")