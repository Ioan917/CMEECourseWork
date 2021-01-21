#!/usr/bin/env Rscript --vanilla

# Title: control_flow.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Example control flow scripts.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

################################ if statements #################################

a <- TRUE
if (a == TRUE){
    print ("a is TRUE")
} else {
    print ("a is FALSE")
}

z <- runif(1) #generate a uniformly distributed random number
if (z <= 0.5) {
    print ("Less than a half")
    } else {
        print ("More than a half")
    }

################################## for loops ###################################

for (i in seq(10)) {
    j <- i * i
    print (paste (i, "squared is", j))
}

# Vector of strings

for (species in c(  'Heliodoxa rubinoides',
                    'Boissonneaua jardini',
                    'Sula nebouxii')) {
    print (paste ('The species is', species) )
                    }

# Using pre-existing vector

v1 <- c("a", "bc", "def")
for (i in v1) {
    print(i)
}

################################# while loops ##################################

i <- 0
while (i < 10) {
    i <- i + 1
    print(i ^ 2)
}

print("Script complete!")