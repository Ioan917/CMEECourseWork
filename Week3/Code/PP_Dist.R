#!/usr/bin/env Rscript --vanilla

# Title: PP_Dist.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Exercise plotting density plots and writing data descriptors to a csv.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Load data
MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")

## Preparing the data

## Making log Predator, Prey and Size ratio interactions

MyDF$log.Predator.Mass <- log(MyDF$Predator.mass)
MyDF$log.Prey.Mass <- log(MyDF$Prey.mass)

MyDF$log.Prey.over.Predator <- log(MyDF$Prey.mass / MyDF$Predator.mass)

x <- unique(MyDF$Type.of.feeding.interaction) # list of feeding interactions

## 1. Predator mass by feeding interaction type

pdf("../Results/Pred_Subplots.pdf")

par(mfrow = c(5, 1)) # to create subplots

n = 0

for(i in x) {
        n = n + 1
        par(mfg = c(n, 1))
        plot(density(MyDF$log.Predator.Mass[MyDF$Type.of.feeding.interaction == i]),
             xlab="log( predator mass (g) )", 
             ylab = "Density", 
             main=i, 
             cex.main = 1)
}

graphics.off()

## 2. Prey mass by feeding interaction type

pdf("../Results/Prey_Subplots.pdf")

par(mfrow = c(5, 1)) # to create subplots

n = 0

for(i in x) {
        n = n + 1
        par(mfg = c(n, 1))
        plot(density(MyDF$log.Prey.Mass[MyDF$Type.of.feeding.interaction == i]),
             xlab="log( prey mass (g) )", 
             ylab = "Density", 
             main=i, 
             cex.main = 1)
}

graphics.off()

## 3. Size ratio of prey mass over predator mass by feeding interaction type

pdf("../Results/SizeRatio_Subplots.pdf")

par(mfrow = c(5, 1)) # to create subplots

n = 0

for(i in x) {
        n = n + 1
        par(mfg = c(n, 1))
        plot(density(MyDF$log.Prey.over.Predator[MyDF$Type.of.feeding.interaction == i]),
             xlab="Ratio ( log predator mass / log prey mass )", 
             ylab = "Density", 
             main=i, 
             cex.main = 1)
}

graphics.off()

## Calculate log mean and median predator mass, prey mass and predator-prey 
## size-ratios to a csv

Mean.predator <- as.vector(tapply(MyDF$log.Predator.Mass, 
                                  MyDF$Type.of.feeding.interaction, mean))
Median.predator <- as.vector(tapply(MyDF$log.Predator.Mass, 
                                    MyDF$Type.of.feeding.interaction, median))

Mean.prey <- as.vector(tapply(MyDF$log.Prey.Mass, 
                              MyDF$Type.of.feeding.interaction, mean))
Median.prey <- as.vector(tapply(MyDF$log.Prey.Mass, 
                                MyDF$Type.of.feeding.interaction, median))

Mean.ratio <- as.vector(tapply(MyDF$log.Prey.over.Predator, 
                               MyDF$Type.of.feeding.interaction, mean))
Median.ratio <- as.vector(tapply(MyDF$log.Prey.over.Predator, 
                                 MyDF$Type.of.feeding.interaction, median))

Feeding_type <- c("insectivorous", "piscivorous", "planktivorous", 
                  "predacious", "predacious/piscivorous")

df <- data.frame(Feeding_type, Mean.predator, Median.predator, 
                 Mean.prey, Median.prey, Mean.ratio, Median.ratio)

colnames(df) <- c("Feeding_type",
                  "Mean_log_Predator_mass", "Median_log_Predator_mass", 
                  "Mean_log_Prey_mass", "Median_log_Prey_mass",
                  "Mean_ratio", "Median_ratio")

write.csv(df, "../Results/PP_Results.csv")

print("Script done!")