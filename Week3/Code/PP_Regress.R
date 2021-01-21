#!/usr/bin/env Rscript --vanilla

# Title: PP_Regress.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Plot regression in subplots using ggplot and export linear model coefficients to a csv.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Load packages
require(ggplot2)

## Load data
MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")

## Plotting
p <- ggplot(MyDF, aes(x = log(Prey.mass), 
                      y = log(Predator.mass), 
                      col =  Predator.lifestage)) +  
  
  geom_point(shape = I(3)) + 
  
  facet_wrap( .~ Type.of.feeding.interaction, strip.position = "right", ncol = 1) +
  
  geom_smooth(method = lm, se = TRUE, fullrange = TRUE, size = 0.5) +
  
  theme_bw() +
  
  theme(aspect.ratio = 0.5,
        legend.position = "bottom", 
        legend.key = element_rect(colour = "grey", fill = "lightgrey")
        ) +
  
  guides(colour = guide_legend(nrow = 1)) +
  
  labs(titles = NULL,
       x = "log Prey mass in grams",
       y = "log Predator mass in grams")

pdf("../Results/PP_Regress.pdf")
print(p)
dev.off()

## Calculate the regression results corresponding the lines fitted in the figure

## log columns
MyDF$log.Predator.mass <- log(MyDF$Predator.mass)
MyDF$log.Prey.mass <- log(MyDF$Prey.mass)

df = data.frame(matrix(vector(), 1, 7,
                       dimnames=list(c(), 
                                     c("Feeding_type", 
                                       "Predator_lifestage",
                                       "Regression_intercept", 
                                       "Regression_slope", 
                                       "R^2", 
                                       "F-statistic", 
                                       "p-value"))),
                stringsAsFactors=F)

pp <- subset(MyDF, Type.of.feeding.interaction == "predacious/piscivorous")
pi <- subset(MyDF, Type.of.feeding.interaction == "piscivorous")
pl <- subset(MyDF, Type.of.feeding.interaction == "planktivorous")
pr <- subset(MyDF, Type.of.feeding.interaction == "predacious")
ins <- subset(MyDF, Type.of.feeding.interaction == "insectivorous")

## predacious / piscivorous
for(i in unique(pp$Predator.lifestage)) {
  model <- lm(pp$log.Prey.mass[pp$Predator.lifestage == i] ~ 
              pp$log.Predator.mass[pp$Predator.lifestage == i])
    
  stage <- i
  a <- summary(model)$coefficients[1:2] # regression intercept, slope
  c <- summary(model)$r.squared # R^2
  d <- summary(model)$fstatistic[[1]] # F-value
  e <- anova(model)$'Pr(>F)'[1] # p-value of F
    
  new_line <- c("predacious/piscivorous", stage, a, c, d, e)
  
  df <- rbind(df, new_line)
    
}

## piscivorous
for(i in unique(pi$Predator.lifestage)) {
  model <- lm(pi$log.Prey.mass[pi$Predator.lifestage == i] ~ 
              pi$log.Predator.mass[pi$Predator.lifestage == i])
  
  stage <- i
  a <- summary(model)$coefficients[1:2] # regression intercept, slope
  c <- summary(model)$r.squared # R^2
  d <- summary(model)$fstatistic[[1]] # F-value
  e <- anova(model)$'Pr(>F)'[1] # p-value of F
  
  new_line <- c("piscivorous", stage, a, c, d, e)
  
  df <- rbind(df, new_line)
  
}

## planktivorous
for(i in unique(pl$Predator.lifestage)) {
  model <- lm(pl$log.Prey.mass[pl$Predator.lifestage == i] ~ 
              pl$log.Predator.mass[pl$Predator.lifestage == i])
  
  stage <- i
  a <- summary(model)$coefficients[1:2] # regression intercept, slope
  c <- summary(model)$r.squared # R^2
  d <- summary(model)$fstatistic[[1]] # F-value
  e <- anova(model)$'Pr(>F)'[1] # p-value of F
  
  new_line <- c("planktivorous", stage, a, c, d, e)
  
  df <- rbind(df, new_line)
  
}

## predacious
for(i in unique(pr$Predator.lifestage)) {
  model <- lm(pr$log.Prey.mass[pr$Predator.lifestage == i] ~ 
              pr$log.Predator.mass[pr$Predator.lifestage == i])
  
  stage <- i
  a <- summary(model)$coefficients[1:2] # regression intercept, slope
  c <- summary(model)$r.squared # R^2
  d <- summary(model)$fstatistic[[1]] # F-value
  e <- anova(model)$'Pr(>F)'[1] # p-value of F
  
  new_line <- c("predacious", stage, a, c, d, e)
  
  df <- rbind(df, new_line)
  
}

## insectivorous
for(i in unique(ins$Predator.lifestage)) {
  model <- lm(ins$log.Prey.mass[ins$Predator.lifestage == i] ~ 
              ins$log.Predator.mass[ins$Predator.lifestage == i])
  
  stage <- i
  a <- summary(model)$coefficients[1:2] # regression intercept, slope
  c <- summary(model)$r.squared # R^2
  d <- summary(model)$fstatistic[[1]] # F-value
  e <- anova(model)$'Pr(>F)'[1] # p-value of F
  
  new_line <- c("insectivorous", stage, a, c, d, e)
  
  df <- rbind(df, new_line)
  
}

df <- df[-1,]

write.csv(df, "../Results/PP_Regress_Results.csv", row.names = FALSE)

print("Script done!")