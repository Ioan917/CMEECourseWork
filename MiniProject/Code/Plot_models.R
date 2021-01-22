#!/usr/bin/env Rscript --vanilla

# Title: boilerplate.R
# Author details: Author: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Plot fitted models to data subsets.
# Copyright statement: none

################################################################################
################################ PLOTTING DATA #################################
################################################################################

## Housekeeping
rm(list=ls())
graphics.off()
set.seed(1)

## Load packages
require(AICcmodavg) # for calculating AICc
require(cowplot)
require(dplyr)
require(ggplot2)
require(minpack.lm)

## Source necessary scripts
source("my_functions.R") # HollMod and GenFunMod

################################################################################
############################ LOAD AND VISUALIZE DATA ###########################
################################################################################

################################ LOAD THE DATA #################################
data <- read.csv("../Data/CRat.csv")
# Based on instructions, the 2 main fields of interest are:
#   N_TraitValue - number of resources consumed per consumer per unit time
#   ResDensity - resource abundance

# Individual response curves identified by ID values
# each ID corresponds to 1 curve - 308 IDs
#   or, reconstruct as: 
#       unique combinations of Citations - where functional response dataset came from - 113 citations
#       ConTaxa - consumer species ID - 125
#       ResTaxa - resource species ID - 123

## Remove NAs
data <- data[!is.na(data$N_TraitValue),] # no NAs
data <- data[!is.na(data$ResDensity),] # no NAs

# Remove rows with 0s for N_TraitValue - CHECK IF THIS IS RIGHT!!!
# data <- subset(data, N_TraitValue != "0")
# Remove ID 39835 - causes problems
data <- subset(data, ID != "39835")

## Load .csv files containing coefficients for non-linear
coef_TypeII <- read.csv("../Data/TypeII_coefficients.csv")
coef_TypeIII <- read.csv("../Data/TypeIII_coefficients.csv")
coef_General <- read.csv("../Data/General_coefficients.csv")

################################################################################
################################ PLOTTING LOOP #################################
################################################################################

## Create list of unique IDs
x <- unique(data$ID) # 308

#################################### LINEAR ####################################

for(i in x) {
  
  ## Subset the data
  SubsetData <- subset(data, ID == i)
  
  ## Generate a vector of ResDensity for plotting
  Lengths <- seq(min(SubsetData$ResDensity), max(SubsetData$ResDensity), len = 200)
  
  ####################### Fit the phenomenological models ######################
  
  LineFit <- lm(N_TraitValue ~ poly(ResDensity, 1), data = SubsetData)
  Predic2PlotLine <- predict.lm(LineFit, data.frame(ResDensity = Lengths))
  
  QuadFit <- lm(N_TraitValue ~ poly(ResDensity, 2), data = SubsetData)
  Predic2PlotQua <- predict.lm(QuadFit, data.frame(ResDensity = Lengths))
  
  try(CubicFit <- lm(N_TraitValue ~ poly(ResDensity, 3), data = SubsetData), TRUE)
  try(Predic2PlotCub <- predict.lm(CubicFit, data.frame(ResDensity = Lengths)), TRUE)
  
  ################################## Plotting ##################################
  
  setwd("../Plots/Phenomenological/")
  
  pdf(paste("ID_linear_", i, ".pdf"))
  
  par(mfrow = c(1, 1))
  #par(oma = c(4, 4, 2, 2)) # make room for the overall x and y axis titles
  #par(mar = c(2, 4, 1, 1)) # make the plots be closer together
  
  plot(SubsetData$N_TraitValue ~ SubsetData$ResDensity,
       xlab = "Resource abundance", 
       ylab = "Resources consumed per consumer per unit time",
       main = "")
  try(lines(Lengths, Predic2PlotLine, col = "#B0B8B4FF", lwd = 2.5), TRUE)
  try(lines(Lengths, Predic2PlotQua, col = "#184A45FF", lwd = 2.5), TRUE)
  try(lines(Lengths, Predic2PlotCub, col = "#FC766AFF", lwd = 2.5), TRUE)
  
  graphics.off()
  
  setwd("../../Code/")
  
}

################################## NON-LINEAR ##################################

j <- 1

for(i in x) {
  
  ## Subset the data
  SubsetData <- subset(data, ID == i)
  
  ## Generate a vector of ResDensity for plotting
  Lengths <- seq(min(SubsetData$ResDensity), max(SubsetData$ResDensity), len = 200)
 
  ######################### Fit the mechanistic models #########################
  
  ############################ Holling Type I model ############################
  
  TypeIFit <- lm(N_TraitValue ~ 0 + ResDensity, data = SubsetData)
  
  Predic2PlotTypeI <- predict.lm(TypeIFit, data.frame(ResDensity = Lengths))
  
  ########################### Holling Type II model ############################
  
  coef_TypeII_current <- subset(coef_TypeII, ID == i)
  
  try(Predic2PlotTypeII <- HollModII(x = Lengths, 
                                     a = coef_TypeII_current$a,
                                     h = coef_TypeII_current$h), TRUE)
  
  ########################## Holling Type III model ############################
  
  coef_TypeIII_current <- subset(coef_TypeIII, ID == i)
  
  try(Predic2PlotTypeIII <- HollModIII(x = Lengths, 
                                       a = coef_TypeIII_current$a,
                                       h = coef_TypeIII_current$h), TRUE)
  
  ######################## Generalized functional model ########################
  
  coef_General_current <- subset(coef_General, ID == i)
  
  try(Predic2PlotGeneral <- GenFunMod(x = Lengths, 
                                      a = coef_General_current$a,
                                      h = coef_General_current$h,
                                      q = coef_General_current$q), TRUE)
  
  ################################## Plotting ##################################
  
  setwd("../Plots/Mechanistic/")
      
  pdf(paste("ID_nonlinear_", i, ".pdf"))
      
  par(mfrow = c(1, 1))
  #par(oma = c(4, 4, 2, 2)) # make room for the overall x and y axis titles
  #par(mar = c(2, 4, 1, 1)) # make the plots be closer together
  
  plot(SubsetData$N_TraitValue ~ SubsetData$ResDensity,
       xlab = "Resource abundance", 
       ylab = "Resources consumed per consumer per unit time",
       main = "",
       ylim = c(0, 1.2*max(SubsetData$N_TraitValue)))
  try(lines(Lengths, Predic2PlotTypeI, col = "#F23557", lwd = 2.5), TRUE)   # red
  try(lines(Lengths, Predic2PlotTypeII, col = "#F0D43A", lwd = 2.5), TRUE)  # yellow
  try(lines(Lengths, Predic2PlotTypeIII, col = "#22B2DA", lwd = 2.5), TRUE) # blue
  try(lines(Lengths, Predic2PlotGeneral, col = "#3B4A6B", lwd = 2.5), TRUE) # dark blue

  graphics.off()
      
  setwd("../../Code/")
  
  j <- j+1
}


################################################################################
################################# USING GGPLOT #################################
################################################################################

## Selected ID for 'pretty' plotting, to be used in write-up
# Selected based on visual inspection of simple, base R plots for having a good 
# fit for all models
chosen_ID <- "39894"

# Subset the data
SubsetData <- subset(data, ID == chosen_ID)

# Generate a vector of ResDensity for plotting
Lengths <- seq(min(SubsetData$ResDensity), max(SubsetData$ResDensity), len = 200)

#################################### LINEAR ####################################

LineFit <- lm(N_TraitValue ~ poly(ResDensity, 1), data = SubsetData)
Predic2PlotLine <- predict.lm(LineFit, data.frame(ResDensity = Lengths))

QuadFit <- lm(N_TraitValue ~ poly(ResDensity, 2), data = SubsetData)
Predic2PlotQua <- predict.lm(QuadFit, data.frame(ResDensity = Lengths))

try(CubicFit <- lm(N_TraitValue ~ poly(ResDensity, 3), data = SubsetData), TRUE)
try(Predic2PlotCub <- predict.lm(CubicFit, data.frame(ResDensity = Lengths)), TRUE)

predictions_df <- data.frame(Lengths, Predic2PlotLine, Predic2PlotQua, Predic2PlotCub)

############################ Plot the linear models ############################

## Set colors ready for plotting
colors <- c("Straight line" = "#B0B8B4FF", "Quadratic" = "#184A45FF", "Cubic" = "#FC766AFF")

p <- ggplot(SubsetData, aes(x = ResDensity, y = N_TraitValue)) +
  
  geom_point(shape = I(3), size = 2) +
  
  # Add predicted lines
  geom_line(data = predictions_df, aes(x = Lengths, y = Predic2PlotLine, color = "Straight line"),
            size = 0.5) +
  geom_line(data = predictions_df, aes(x = Lengths, y = Predic2PlotQua, color = "Quadratic"),
            size = 0.5) +
  geom_line(data = predictions_df, aes(x = Lengths, y = Predic2PlotCub, color = "Cubic"),
            size = 0.5) +
  
  theme_bw() +
  
  # Add legend
  scale_color_manual(name = "Models",
                     values = colors,
                     breaks = c("Straight line", "Quadratic", "Cubic")) +
  
  theme(aspect.ratio = 1,
        legend.position = "bottom",
        legend.key = element_rect(colour = "grey", fill = "lightgrey")) +
  
  labs(titles = NULL) + 
  
  ylab("Consumption rate") +
  
  theme(axis.title.x=element_blank(),
        axis.title.y = element_text(vjust=3),
        plot.margin=unit(c(0.5,0.5,1,0.5),"cm"),
        text = element_text(size=15)) + 
  
  ylim(0, 0.0015)

################################## NON-LINEAR ##################################

############################ Holling Type I model ############################

TypeIFit <- lm(N_TraitValue ~ 0 + ResDensity, data = SubsetData)

Predic2PlotTypeI <- predict.lm(TypeIFit, data.frame(ResDensity = Lengths))

########################### Holling Type II model ############################

coef_TypeII_current <- subset(coef_TypeII, ID == chosen_ID)

Predic2PlotTypeII <- HollModII(x = Lengths, 
                               a = coef_TypeII_current$a,
                               h = coef_TypeII_current$h)

########################## Holling Type III model ############################

coef_TypeIII_current <- subset(coef_TypeIII, ID == chosen_ID)

Predic2PlotTypeIII <- HollModIII(x = Lengths, 
                                 a = coef_TypeIII_current$a,
                                 h = coef_TypeIII_current$h)

######################## Generalized functional model ########################

coef_General_current <- subset(coef_General, ID == chosen_ID)

Predic2PlotGeneral <- GenFunMod(x = Lengths, 
                                a = coef_General_current$a,
                                h = coef_General_current$h,
                                q = coef_General_current$q)

########################## Plot the non-linear models ##########################

predictions_df <- data.frame(Lengths, Predic2PlotTypeI, Predic2PlotTypeII, Predic2PlotTypeIII, Predic2PlotGeneral)

## Set colors ready for plotting
colors <- c("Type I" = "#F23557", "Type II" = "#F0D43A", "Type III" = "#22B2DA", "Generalised" = "#3B4A6B")

q <- ggplot(SubsetData, aes(x = ResDensity, y = N_TraitValue)) +
  
  geom_point(shape = I(3), size = 2) +
  
  # Add predicted lines
  geom_line(data = predictions_df, aes(x = Lengths, y = Predic2PlotTypeI, color = "Type I"),
            size = 0.5) +
  geom_line(data = predictions_df, aes(x = Lengths, y = Predic2PlotTypeII, color = "Type II"),
            size = 0.5) +
  geom_line(data = predictions_df, aes(x = Lengths, y = Predic2PlotTypeIII, color = "Type III"),
            size = 0.5) +
  geom_line(data = predictions_df, aes(x = Lengths, y = Predic2PlotGeneral, color = "Generalised"),
            size = 0.5) +
  
  theme_bw() +
  
  # Add legend
  scale_color_manual(name = "Models",
                     values = colors,
                     breaks = c("Type I", "Type II", "Type III", "Generalised")) +
  
  theme(aspect.ratio = 1,
        legend.position = "bottom",
        legend.key = element_rect(colour = "grey", fill = "lightgrey")) +
  
  labs(titles = NULL) + 
  
  ylab("Consumption rate") +
  
  theme(axis.title.x=element_blank(),
        axis.title.y = element_text(vjust=3),
        plot.margin=unit(c(0.5,0.5,1,0.5),"cm"),
        text = element_text(size=15)) + 
  
  ylim(0, 0.0015)

################################# COMBINE PLOTS ################################

final_plot <- plot_grid(p + theme(legend.position = "right"), 
                        q + theme(legend.position = "right"),
                        labels = c("a","b"), 
                        hjust = -2,
                        nrow = 2) +
  draw_label("Resource density", x = 0.45, y = 0.02, vjust = 0, angle = 0)

pdf(paste("../Results/Example_fit_ID_", chosen_ID, ".pdf", sep = ""), width = 6, height = 7)
print(final_plot)
dev.off()



print("Plotting model fits done!!")