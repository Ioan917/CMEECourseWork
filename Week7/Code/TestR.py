#!/usr/bin/env python3

"""Example using subprocess to run an R script from within python."""

import subprocess

subprocess.Popen("Rscript --verbose TestR.R > ../Results/TestR.Rout 2> ../Results/TestR_errFile.Rout", shell = True).wait()