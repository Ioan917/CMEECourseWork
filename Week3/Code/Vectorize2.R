#!/usr/bin/env R

set.seed(1)

# Runs the stochastic Ricker equation with gaussian fluctuations

rm(list=ls())

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

##### ALTERNATIVE IDEA #####

#stochrickvect<-function(
#  p0 = runif(100,.5,1.5),
#  r = 1.2, # intrinsic growth rate
#  K = 1, # carrying capacity
#  sigma = 0.2,
#  numyears = 100) {
#  
#  #initialize
#  N <- matrix(NA, numyears, 1000) # creates a vector of NA
#  N[, 1] <- p0
#  sig <- replicate(length(p0), rnorm(1, 0, sigma))
#  
#  for (pop in 2:1000) {
#    
#    N[,pop] <- N[, pop - 1] * exp(r * (1 - N[, pop - 1] / K) + rnorm(1,0,sigma))
#    
#  }
#  
#  return(N)
#  
#}