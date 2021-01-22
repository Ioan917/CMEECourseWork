#!/bin/bash
# Author: Ioan ie917@ic.ac.uk
# Script: CompileLaTeX.sh
# Desc: Script to compile a LaTeX script file into a pdf.
# Arguments: none
# Date: Jan 2021

BASE="${1%.*}"
pdflatex $BASE.tex
bibtex $BASE
pdflatex $BASE.tex
pdflatex $BASE.tex
evince $BASE.pdf &

## Cleanup
#rm *~
#rm *.aux
#rm *.dvi
#rm *.log
#rm *.nav
#rm *.out
#rm *.snm
#rm *.toc

rm -f {*~,*.aux,*.bbl,*.blg,*.dvi,*.log,*.nav,*.out,*.snm,*.toc}

exit