#!/usr/bin/env R

################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

library(tidyverse)

############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- read_csv("../Data/PoundHillData.csv", col_names = FALSE)

# header = true because we do have metadata headers
MyMetaData <- read_csv2("../Data/PoundHillMetaData.csv", col_names = TRUE)

############# Inspect the dataset ###############
dplyr::slice(MyData, 1:5)
dplyr::glimpse(MyData)
utils::View(MyData)
utils::View(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- MyData %>%
  tibble::rownames_to_column() %>%  
  pivot_longer(-rowname) %>% 
  pivot_wider(names_from=rowname, values_from=value) 

dplyr::slice(MyData, 1:5)

############# Replace species absences with zeros ###############
MyData <- MyData %>% replace(is.na(.), 0)

############# Convert raw matrix to data frame ###############

# Remove first column
MyData <- MyData[, -1]

# Make first row the header
names(MyData) <- as.matrix(MyData[1, ])
MyData <- MyData[-1, ]
MyData[] <- lapply(MyData, function(x) type.convert(as.character(x)))

############# Convert from wide to long format  ###############

# use gather() from tidyr

MyWrangledData <- gather(MyData, key = "Species", value = "Count", factor_key = FALSE, -Cultivation, -Block, -Plot, -Quadrat)

MyWrangledData[, "Cultivation"] <- as_factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as_factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as_factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as_factor(MyWrangledData[, "Quadrat"])

dplyr::slice(MyWrangledData, 1:5)

print("Script done!")

############# Exploring the data (extend the script below)  ###############
