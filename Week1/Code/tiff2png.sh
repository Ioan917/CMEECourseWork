#!/bin/bash

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