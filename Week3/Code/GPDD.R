#!/usr/bin/env Rscript --vanilla

# Title: GPDD.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Plot latitude and longitude points onto a world map.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Load packages
require(maps)

## Load data
load("../Data/GPDDFiltered.RData")

## Create world map
map(database = "world")

points(gpdd$long, gpdd$lat, pch =  3, cex = 0.5, col = "blue")
map.axes()

print("Script done!")

## Biases
#  The majority of datapoints are in the Northern hemisphere, specifically 
#  around the Western United States, along the Northern edge of the US / 
#  Southern to Central Canada, and across (mostly the UK and western) Europe.
#  Similar latitude (climate, seasonal effect, etc.)
#  Similar levels of urban development (habitat transformation -> homogenization 
#  of biodiversity)