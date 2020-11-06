#!/usr/bin/env R

i <- 0 # initialise i
while (i < Inf) {
    if (i == 10) {
        break
    } # break out of the while loop
    else {
        cat ("i equals", i, "\n")
        i <- i + 1 # update i
    }
}

print("Script complete!")