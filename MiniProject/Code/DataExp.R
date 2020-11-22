#### Going through previous examples with functional response data

## Housekeeping
rm(list=ls())
graphics.off()

### Model fitting using Non-linear least squares

## Load packages #####
require(dplyr)
require(ggplot2)
require(minpack.lm)

## The models to fit to the data #####

# Quadratic - phenomenological
quadMod <- function(x, b0, b1, b2) {
  return (b0 + (b1 * x) + (b2 * (x ^ 2)))
}

# Cubic - phenomenological
cubMod <- function(x, b0, b1, b2, b3) {
  return (b0 + (b1 * x) + (b2 * (x ^ 2)) + (b3 * (x ^ 3)))
}

# Holling Type II model - mechanistic
HollMod <- function(a,
                    xR,
                    h) {
  return ( (a * xR) / (1 + (h * a * xR) ) )
}
# response variable = consumption rate (c)
#   expressed in terms of biomass quantity or number of individuals of resource 
#     consumed per unit time per unit consumer

# Generalised functional model - mechanistic
HollMod <- function(a, xR, h) {
  return ( (a * ( xR ^ (q + 1) ) ) / (1 + (h * a * ( xR ^ (q + 1) ) ) ) )
}
# less mechanistic because of the phenomenological parameter q (no biological 
#   meaning) 

## Load the data #####
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

# Remove NAs
data <- data[!is.na(data$N_TraitValue),] # no NAs
data <- data[!is.na(data$ResDensity),] # no NAs

# Remove rows with 0s for N_TraitValue - CHECK IF THIS IS RIGHT!!!
data <- subset(data, N_TraitValue != "0")

# Create log(N_TraitValue) and log(ResDensity) columns
data$log_N_TraitValue <- log(data$N_TraitValue)
data$log_ResDensity <- log(data$ResDensity)

## Visualise data #####
plot(density(data$log_N_TraitValue),
     xlab = "log( Number of resources consumed per consumer per unit time )",
     ylab = "Density",
     main = "") # Bimodal

plot(density(data$log_ResDensity),
     xlab = "log( Resource abundance )",
     ylab = "Density",
     main = "") # Unimodal

## Plot N_TraitValue against ResDensity for each unuique ID #####

# Find number of unique IDs
length(unique(data$ID)) # 308

# for loop
# Find number of unique IDs
x <- unique(data$ID)

for(i in x) {
  setwd("../Plots/")
  
  pdf(paste("ID_", i))
  
  plot(data$log_N_TraitValue[data$ID == i] ~ data$log_ResDensity[data$ID == i],
       xlab="log( Resource abundance )", 
       ylab = "log( Number of resources consumed per consumer per unit time )",
       main=paste("ID = ", i),
       cex.main = 1,
       xlim = c(-5, 20),
       ylim = c(-12, 17))
  lines(Predic2PlotQuad ~ density, col = "blue", lwd = 2.5)
  lines(Predic2PlotCubic ~ density, col = "red", lwd = 2.5)
  
  graphics.off()
  
  setwd("../Code/")
}

## Plot N_TraitValue against ResDensity for each consumer species ID (ConTaxa) #####
# for loop
# Find number of unique consumer species IDs
y <- unique(data$ConTaxa)

for(i in y) {
  setwd("../Plots/")
  
  pdf(paste("ID_", i))
  
  plot(data$log_N_TraitValue[data$ConTaxa == i] ~ data$log_ResDensity[data$ConTaxa == i],
       xlab="log( Resource abundance )", 
       ylab = "log( Number of resources consumed per consumer per unit time )",
       main=paste("ID = ", i),
       cex.main = 1,
       xlim = c(-5, 20),
       ylim = c(-12, 17))
  lines(Predic2PlotQuad ~ density, col = "blue", lwd = 2.5)
  lines(Predic2PlotCubic ~ density, col = "red", lwd = 2.5)
  
  graphics.off()
  
  setwd("../Code/")
}

## Plot N_TraitValue against ResDensity for each resource species ID (ResTaxa) #####
# for loop
# Find number of unique resource species IDs
z <- unique(data$ResTaxa)

for(i in z) {
  setwd("../Plots/")
  
  pdf(paste("ID_", i))
  
  plot(data$log_N_TraitValue[data$ResTaxa == i] ~ data$log_ResDensity[data$ResTaxa == i],
       xlab="log( Resource abundance )", 
       ylab = "log( Number of resources consumed per consumer per unit time )",
       cex.main = 1,
       xlim = c(-5, 20),
       ylim = c(-12, 17))
  lines(Predic2PlotQuad ~ density, col = "blue", lwd = 2.5)
  lines(Predic2PlotCubic ~ density, col = "red", lwd = 2.5)
  
  graphics.off()
  
  setwd("../Code/")
}

## Plot N_TraitValue against ResDensity for each Citation #####
# for loop
# Find number of unique resource species IDs
w <- unique(data$Citation)

for(i in w) {
  setwd("../Plots/")
  
  pdf(paste("ID_", i))
  
  plot(data$log_N_TraitValue[data$Citation == i] ~ data$log_ResDensity[data$Citation == i],
       xlab="log( Resource abundance )", 
       ylab = "log( Number of resources consumed per consumer per unit time )",
       cex.main = 1,
       xlim = c(-5, 20),
       ylim = c(-12, 17))
  lines(Predic2PlotQuad ~ density, col = "blue", lwd = 2.5)
  lines(Predic2PlotCubic ~ density, col = "red", lwd = 2.5)
  
  graphics.off()
  
  setwd("../Code/")
}

## Fit the model to the data using NLLS - using log data #####
QuadFit <- nlsLM(data = data,
                 log_N_TraitValue ~ quadMod(log_ResDensity, b0, b1, b2),
                 start = list(b0 = .1, b1 = .1, b2 = .1))
summary(QuadFit)

CubicFit <- nlsLM(data = data,
                 log_N_TraitValue ~ cubMod(log_ResDensity, b0, b1, b2, b3),
                 start = list(b0 = .1, b1 = .1, b2 = .1, b3 = .1))
summary(CubicFit)

# Generate a vector of ResDensity for plotting
density <- seq(min(data$log_ResDensity), max(data$log_ResDensity), len = 200)
# Calculate the predicted line
# Extract the coefficient from the model fit object
coef(QuadFit)["b0"]
coef(QuadFit)["b1"]
coef(QuadFit)["b2"]
Predic2PlotQuad <- quadMod(density, 
                           coef(QuadFit)["b0"],
                           coef(QuadFit)["b1"],
                           coef(QuadFit)["b2"])

coef(CubicFit)["b0"]
coef(CubicFit)["b1"]
coef(CubicFit)["b2"]
coef(CubicFit)["b3"]
Predic2PlotCubic <- cubMod(density, 
                           coef(CubicFit)["b0"],
                           coef(CubicFit)["b1"],
                           coef(CubicFit)["b2"],
                           coef(CubicFit)["b3"])

# Plot the data and fitted model
plot(data$log_N_TraitValue ~ data$log_ResDensity,
     xlab = "log( Resource abundance )",
     ylab = "log( Number of resources consumed per consumer per unit time )")
lines(Predic2PlotQuad ~ density, col = "blue", lwd = 2.5)
lines(Predic2PlotCubic ~ density, col = "red", lwd = 2.5)

# Calculate confidence intervals on the estimated parameters
confint(QuadFit)
confint(CubicFit)

### Comparing models #####

## R^2 value - measure of model fit - don't use for model selection #####
RSS_Qua <- sum(residuals(QuadFit)^2)  # Residual sum of squares
TSS_Qua <- sum((data$log_N_TraitValue - mean(data$log_N_TraitValue))^2)  # Total sum of squares
RSq_Qua <- 1 - (RSS_Qua/TSS_Qua)  # R-squared value

RSS_Cub <- sum(residuals(CubicFit)^2)  # Residual sum of squares
TSS_Cub <- sum((data$log_N_TraitValue - mean(data$log_N_TraitValue))^2)  # Total sum of squares
RSq_Cub <- 1 - (RSS_Cub/TSS_Cub)  # R-squared value

RSq_Qua # 0.2345153
RSq_Cub # 0.2429945

## Akaike Information Criterion (AIC) #####
# declare winner if difference >2
# Compare Quadratic and Cubic
AIC(QuadFit) - AIC(CubicFit) # 47.52271 - cubic is better than quadratic
