#!/bin/bash
# Author: Ioan ie917@ic.ac.uk
# Script: tiff2png.sh
# Desc: Convert a .tif file to a .png file.
# Arguments: A .tif file e.g. bash tiff2png.sh <file.tif>
# Date: Oct 2020

BASE="${1%.*}"

if [[ -f $BASE.tif ]] && [[ "$#" = 1 ]] 
then
    for f in *.tif;
        do
            echo "Converting $f";
            convert "$f" "$(basename "$f" .tif).png";
        done
elif [[ "$#" > 1 ]] # more than one file selected
then
    echo "one file at a time please"
elif [[ "$#" = 0 ]]
then
    echo "no file selected"
elif [[ ! -f $BASE.tif ]] && [[ "$#" = 1 ]] 
then
    echo "wrong input, only tiff please"
else # some other error, not specified above
    echo "something else went wrong"
fi

exit