#!/usr/bin/env Rscript --vanilla

# Title: TreeHeight.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Calculate tree heights and save results to a csv.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

# This function calculates heights of trees given distance of each tree
# from its base and angle to its top, using the trigonometric formula
# 
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees: The angle of elevation of tree
# distance: The distance from base of tree (e.g. meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

## Loading data
tree_data <- read.csv("../Data/trees.csv")

## Function
TreeHeight <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    
    return(height)
}

print(paste("The heigh of a tree with an angle of 37 degrees at distance 40m is", as.character(TreeHeight(37,40))))

## Assigning the output of the function to a column
tree_data$Tree.Height.m <- TreeHeight(tree_data$Angle.degrees, tree_data$Distance.m)

## Creating a csv output
write.csv(tree_data, "../Results/TreeHts.csv", row.names = FALSE)

## Message to state complete
print("Done")