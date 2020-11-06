#!/usr/bin/env R

## Load packages

library(maps)

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