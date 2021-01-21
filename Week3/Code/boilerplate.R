#!/usr/bin/env Rscript --vanilla

# Title: boilerplate.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: A boilerplate script.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Script

MyFunction <- function(Arg1, Arg2) {

    # Statements involving Arg1, Arg2:
    print( paste( "Argument", as.character(Arg1), "is a", class(Arg1)))
    print( paste ( "Argument", as.character(Arg2), "is a", class(Arg2)))

    return (c(Arg1, Arg2))
}

MyFunction(1,2) # test the function
MyFunction("Riki","Tiki") # a different test

print("Script done!")