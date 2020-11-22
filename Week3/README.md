# Week3
## Brief description
Code and data files for the third week of the CMEE course, covering the introduction to R, data wrangling and plotting.
## Languages
* R
## Dependencies
* ggplot2
* maps
* tidyverse
## Installation
No specific instructions.
## Project structure and Usage
### Code
* apply1.R: Using apply on some of R's inbuilt functions.
* apply2.R: Using apply to define my own function.
* basic_io.R: Code to import a data file, remove column names and save as a new version in a new directory.
* boilerplate.R: First example of an R function; passing arguments to print their class.
* break.R: A while loop to illustrate the use of break in breaking out of loops.
* browse.R: Example of using browser() to insert a breakpoint in a for loop.
* control_flow.R: Control flow tools: if else statements, for and while loops.
* DataWrang.R: Example code wrangling the PoundHill dataset.
* DataWrangTidy.R: Practical exercise finding tidyverse alternatives to perform the same data wrangling as DataWrang.R.
* Girko.R: Practical plotting two dataframes, drawing the results of a simulation of Girko's circular law.
* GPDD.R: Practical exercise plotting latitude and longitude points onto a world map to describe the biases associated with the data provided.
* MyBars.R: Practical exemplifying commands used to annotate a plot.
* next.R: A for loop to illustrate the use of next in passing to the next iteration of a loop.
* plotLin.R: Practical exemplifying the mathematical annotation on an axis and in the plot area.
* PP_Dist.R: Practical exercise plotting density plots and writing data descriptors to a csv.
* PP_Regress.R: Practical exercise plotting regressions in subplots using ggplot and exporting linear model coefficients into a csv.
* preallocate.R: Two functions demonstrating the difference in memory allocation and therefore the speed of operations.
* R_conditionals.R: Three examples of using functions with conditionals: is.even, is.power2, is.prime.
* Ricker.R: Classic discrete population model i.e. Ricker model, originally used to model recruitment of stock in fisheries.
* sample.R: Example of vectorization involving lapply and sapply. Learning how sampling random numbers work.
* TAutoCorr.pdf: Brief summary of the TAutoCorr.R analysis and results.
* TAutoCorr.R: Practical looking at the correlation of temperatures over successive years in a given location.
* TAutoCorr.tex: Brief summary of the TAutoCorr.R analysis and results.
* TreeHeight.R: Using a simple function to calculate the height of trees from the trees.csv file and saving the result in TreeHts.csv.
* try.R: Code illustrating the try keyword to allow a program to continue despite an error and return a set error message.
* Vectorize1.R: Example script to illustrate the differences in speed of loops and the use of vectorization.
* Vectorize2.R: Practical exercise vectorizing a stochastic Ricker model.
### Data
* EcolArchives-E089-51-D1.csv: Dataset on Consumer-Resource bodyy mass ratios taken from the Ecological Archives of the ESA - used for some simple plotting and data exploration.
* Fig2.eps: Plot for TAutoCorr.tex.
* Fig3.eps: Plot for TAutoCorr.tex.
* GPDDFiltered.RData: Latitude and longitude data of sampled species.
* KeyWestAnnualMeanTemperature.RData: 
* PoundHillData.csv: Pound Hill dataset collected by students in past Silwood Field Course used as an example of data wrangling in R.
* PoundHillMetaData.csv: Meta data for the PoundHillData dataset.
* Results.txt: Data for MyBars.R.
* trees.csv: Test file for practicing importing and exporting data.
### Results
All results files are created by running the respective script.
## Author name and contact
Ioan Evans  
email: ie917@ic.ac.uk