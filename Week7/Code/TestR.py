#!/usr/bin/env python3

"""Example using subprocess to run an R script from within python."""

__appname__ = 'TestR.py'
__author__ = 'Ioan Evans'
__email__ = 'ie917@ic.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

## Packages
import subprocess

subprocess.Popen("Rscript --verbose TestR.R > ../Results/TestR.Rout 2> ../Results/TestR_errFile.Rout", shell = True).wait()