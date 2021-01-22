#!/bin/bash
# Author: Ioan ie917@ic.ac.uk
# Script: run_MiniProject.sh
# Desc: Script to run all MiniProject scripts and compile the write up script in the form of a pdf.
# Arguments: none
# Date: Jan 2021

# Data analysis and plotting
Rscript Extract_values.R
Rscript Plot_models.R
Rscript Akaike_weights.R
Rscript Habitat_comparisons.R

# Word count
texcount -nosub Write_up.tex > wordcount.txt
sed -n '3,3p' wordcount.txt > new_wordcount.txt

# Compile to .pdf
bash CompileLaTeX.sh Write_up.tex
bash CompileLaTeX.sh Supplementary_figures.tex

# Move final write-up document to Results directory
#mv Write_up.pdf ../Results/
#mv Supplementary_figures.pdf ../Results/

echo "BEHOLD (hopefully) THE FINAL WRITE-UP!!"

exit