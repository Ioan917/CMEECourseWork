#!/bin/bash

if [[ "$#" = 1 ]] # if only one file selected
then
    NumLines=`wc -l < $1`
    echo "The file $1 has $NumLines lines"
    echo
    exit
elif [[ "$#" > 1 ]] # more than one file selected
then
    echo "one file at a time please"
elif [[ "$#" = 0  ]] # no file selected
then
    echo "no file selected"
else # some other error, not specified above
    echo "oh no! something else went wrong"
fi