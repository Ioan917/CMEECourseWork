#!/usr/bin/env python3

"""Example using subprocess to run an R script from python."""

__appname__ = 'run_fmr_R.py'
__author__ = 'Ioan Evans'
__email__ = 'ie917@ic.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

## Packages
import subprocess

try:
    subprocess.Popen("Rscript --verbose fmr.R > ../Results/fmr_plot.pdf 2> ../Results/fmr_errFile.Rout", shell = True).wait()
    print("Script run successfully!")
except:
    print("Generic error message.")