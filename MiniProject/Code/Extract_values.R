#!/usr/bin/env Rscript --vanilla

# Title: Extract_values.R
# Author details: Author: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Extract model coefficients, compute and plot pairwise and overall winners.
# Copyright statement: none

################################################################################
#### EXTRACT R^2 AND CALCULATE AICc AND BIC FOR EACH MODEL AND ADD TO A DF #####
################################################################################

## Housekeeping
rm(list = ls())
graphics.off()
set.seed(1)

## Load packages
require(AICcmodavg) # for calculating AICc
require(cowplot) # for plotting side by side ggplots
require(dplyr)
require(formattable)
require(ggplot2)
require(minpack.lm)
require(xtable)

print("You deserve a break. Count some sheep and come back later!!")

## Source necessary scripts
source("my_functions.R") # HollMod and GenFunMod

################################################################################
################################# PREPARE DATA #################################
################################################################################

## Load data
data <- read.csv("../Data/CRat.csv")

## Remove NAs
data <- data[!is.na(data$N_TraitValue),] # no NAs
data <- data[!is.na(data$ResDensity),] # no NAs

## Remove problematic dataset
data <- subset(data, ID != "39835")

################################################################################
############################ LOOP TO EXTRACT VALUES ############################
################################################################################

## Set up data frame to capture the goodness of fit statistics
goodness_fit_AICc <- data.frame(matrix(vector(), 1, 9,
                                       dimnames = list(c(), 
                                                       c("ID",
                                                         "sample_size",
                                                         "AICc_Line",
                                                         "AICc_Quad",
                                                         "AICc_Cubic",
                                                         "AICc_TypeI",
                                                         "AICc_TypeII",
                                                         "AICc_TypeIII",
                                                         "AICc_General"
                                                       ))),
                                stringsAsFactors=F)

goodness_fit_BIC <- data.frame(matrix(vector(), 1, 9,
                                      dimnames = list(c(), 
                                                      c("ID",
                                                        "sample_size",
                                                        "BIC_Line",
                                                        "BIC_Quad",
                                                        "BIC_Cubic",
                                                        "BIC_TypeI",
                                                        "BIC_TypeII",
                                                        "BIC_TypeIII",
                                                        "BIC_General"
                                                      ))),
                               stringsAsFactors=F)

## Set up data frame to capture non-linear model coefficients for each ID
coef_TypeII <- data.frame(matrix(vector(), 1, 3,
                                  dimnames = list(c(),
                                                  c("ID",
                                                    "a",
                                                    "h"))),
                           stringsAsFactors = F)


coef_TypeIII <- data.frame(matrix(vector(), 1, 3,
                              dimnames = list(c(),
                                              c("ID",
                                                "a",
                                                "h"))),
                              stringsAsFactors = F)

coef_General <- data.frame(matrix(vector(), 1, 4,
                          dimnames = list(c(),
                                          c("ID",
                                            "a",
                                            "h",
                                            "q"))),
                   stringsAsFactors = F)

## Create a list of unique IDs
x <- unique(data$ID)

##################################### LOOP #####################################
for (i in x) {
  
  ## Subset the data
  SubsetData <- subset(data, ID == i)
  
  ## Generate a vector of ResDensity for plotting
  Lengths <- seq(min(SubsetData$ResDensity), max(SubsetData$ResDensity), len = 100)
  
  ####################### Fit the phenomenological models ######################
  
  ## Straight line
  try(LineFit <- lm(N_TraitValue ~ poly(ResDensity, 1), data = SubsetData), TRUE)
  
  ## Quadratic
  try(QuadFit <- lm(N_TraitValue ~ poly(ResDensity, 2), data = SubsetData), TRUE)
  
  ## Cubic
  try(CubicFit <- lm(N_TraitValue ~ poly(ResDensity, 3), data = SubsetData), TRUE)
  
  ######################### Fit the mechanistic models #########################
  
  ## Create a data frame of starting values randomized around biologically meaningful values
  first_ResDensity <- min(SubsetData$ResDensity)
  first_N_Trait <- min(SubsetData$N_TraitValue[SubsetData$ResDensity == first_ResDensity])
  
  repeats <- 30
  
  starting_a <- runif(repeats, 
                      (first_N_Trait/first_ResDensity) - (0.1 * first_N_Trait/first_ResDensity),
                      (first_N_Trait/first_ResDensity) + (0.1 * first_N_Trait/first_ResDensity))
  
  last_ResDensity <- max(SubsetData$ResDensity)
  last_N_Trait <- 1/max(SubsetData$N_TraitValue[SubsetData$ResDensity == last_ResDensity])
  
  starting_h <- runif(repeats,
                      1/last_N_Trait - (0.1 * (1/last_N_Trait)),
                      1/last_N_Trait + (0.1 * (1/last_N_Trait)))
  
  starting_q <- rep(0, repeats)
  for (h in (1:repeats)) {
    starting_q[h] <- sample(c(0,1), 1)
  }
  
  df_starting <- data.frame(starting_a, starting_h, starting_q)
  
  ############################ Holling Type I model ############################
  
  TypeIFit <- lm(N_TraitValue ~ 0 + ResDensity, data = SubsetData)
  
  ########################### Holling Type II model ############################
  
  ## Setting up starting value for Leader - set to be arbitrarily high
  Leader_AICc <- 1000
  Leader_BIC <- 1000
  
  ## Loop through the starting values and save the best (lowest) AICc
  for (j in 1:nrow(df_starting)) {
    
    # Fit the model to the data
    try(TypeIIFit_current <- nlsLM(N_TraitValue ~ HollModII(ResDensity, a, h),
                                   data = SubsetData,
                                   start = list(a = df_starting[j,1],
                                                h = df_starting[j,2]),
                                   lower = c(0, 0),
                                   upper = c(13000, 5000000),
                                   control = list(maxiter = 1000)), TRUE)
    
    ## Calculate AICc, BIC
    try(AICc_current <- AICc(TypeIIFit_current), TRUE)
    try(BIC_current <- BIC(TypeIIFit_current), TRUE)
    
    ## Assign Leader = better fit
    try(if ( (AICc_current < Leader_AICc | BIC_current < Leader_BIC) & AICc_current != Inf & BIC_current != Inf) {
      Leader_AICc <- AICc_current
      Leader_BIC <- BIC_current
      TypeIIFit <- TypeIIFit_current
    }, TRUE)
    
  }
  
  try(new_row <- c(i, coef(TypeIIFit)["a"],
                   coef(TypeIIFit)["h"]),TRUE)
  
  try(coef_TypeII <- rbind(coef_TypeII, new_row), TRUE)
  
  ########################## Holling Type III model ############################
  
  ## Setting up starting value for Leader - set to be arbitrarily high
  Leader_AICc <- 1000
  Leader_BIC <- 1000
  
  ## Loop through the starting values and save the best (lowest) AICc
  for (j in 1:nrow(df_starting)) {
    
    # Fit the model to the data
    try(TypeIIIFit_current <- nlsLM(N_TraitValue ~ HollModIII(ResDensity, a, h),
                                    data = SubsetData,
                                    start = list(a = df_starting[j,1],
                                                 h = df_starting[j,2]),
                                    lower = c(0, 0),
                                    upper = c(13000, 5000000),
                                    control = list(maxiter = 1000)), TRUE)
    
    ## Calculate AICc, BIC
    try(AICc_current <- AICc(TypeIIIFit_current), TRUE)
    try(BIC_current <- BIC(TypeIIIFit_current), TRUE)
    
    ## Assign Leader = better fit
    try(if ( (AICc_current < Leader_AICc | BIC_current < Leader_BIC) & AICc_current != Inf & BIC_current != Inf) {
      Leader_AICc <- AICc_current
      Leader_BIC <- BIC_current
      TypeIIIFit <- TypeIIIFit_current
    }, TRUE)
    
  }
  
  try(new_row <- c(i, coef(TypeIIIFit)["a"],
                   coef(TypeIIIFit)["h"]),TRUE)
  
  try(coef_TypeIII <- rbind(coef_TypeIII, new_row), TRUE)
  
  ######################## Generalized functional model ########################
  
  ## Setting up starting value for Leader - set to be arbitrarily high
  Leader_AICc <- 1000
  Leader_BIC <- 1000
  
  ## Loop through the starting values and save the best (lowest) AICc
  for (j in 1:nrow(df_starting)) {
    
    # Fit the model to the data
    try(GeneralFit_current <- nlsLM(N_TraitValue ~ GenFunMod(ResDensity, a, h, q),
                                    data = SubsetData,
                                    start = list(a = df_starting[j,1],
                                                 h = df_starting[j,2],
                                                 q = df_starting[j,3]),
                                    lower = c(0, 0, 0),
                                    upper = c(1000000, 5000000, 1),
                                    control = list(maxiter = 1000)), TRUE)
    
    ## Calculate AICc, BIC
    try(AICc_current <- AICc(GeneralFit_current), TRUE)
    try(BIC_current <- BIC(GeneralFit_current), TRUE)
    
    ## Assign Leader = better fit
    try(if ( (AICc_current < Leader_AICc | BIC_current < Leader_BIC) & AICc_current != Inf & BIC_current != Inf) {
      Leader_AICc <- AICc_current
      Leader_BIC <- BIC_current
      GeneralFit <- GeneralFit_current
    }, TRUE)
    
  }
  
  try(new_row <- c(i, coef(GeneralFit)["a"],
                   coef(GeneralFit)["h"],
                   coef(GeneralFit)["q"]),TRUE)
  
  try(coef_General <- rbind(coef_General, new_row), TRUE)
  
  ############################### Extract values ###############################
  
  ID <- i # ID
  sample_size<- length(SubsetData$ID)
  #Model <- "Quadratic"
  #F_value <- round(summary(QuadFit)$fstatistic[[1]], 3) # F-value
  #degrees_of_freedom <- QuadFit$df.residual # degrees of freedom
  #p_value <- anova(QuadFit)$'Pr(>F)'[1] # p-value of F
  
  ## AICc
  AICc_Line <- AICc(LineFit)
  AICc_Quad <- AICc(QuadFit)
  try(AICc_Cubic <- AICc(CubicFit), TRUE)
  try(AICc_TypeI <- AICc(TypeIFit), TRUE)
  try(AICc_TypeII <- AICc(TypeIIFit), TRUE)
  try(AICc_TypeIII <- AICc(TypeIIIFit), TRUE)
  try(AICc_General <- AICc(GeneralFit), TRUE)
  
  ## BIC
  BIC_Line <- BIC(LineFit)
  BIC_Quad <- BIC(QuadFit)
  try(BIC_Cubic <- BIC(CubicFit), TRUE)
  try(BIC_TypeI <- BIC(TypeIFit), TRUE)
  try(BIC_TypeII <- BIC(TypeIIFit), TRUE)
  try(BIC_TypeIII <- BIC(TypeIIIFit), TRUE)
  try(BIC_General <- BIC(GeneralFit), TRUE)
  
  try(new_line_AICc <- c(ID, sample_size,
                         AICc_Line, AICc_Quad, AICc_Cubic, AICc_TypeI, AICc_TypeII, AICc_TypeIII, AICc_General), TRUE)
  try(new_line_BIC <- c(ID, sample_size,
                        BIC_Line, BIC_Quad, BIC_Cubic, BIC_TypeI, BIC_TypeII, BIC_TypeIII, BIC_General), TRUE)
  
  try(goodness_fit_AICc <- rbind(goodness_fit_AICc, new_line_AICc), TRUE)
  try(goodness_fit_BIC <- rbind(goodness_fit_BIC, new_line_BIC), TRUE)
  
}

############################## Tidy up df output ###############################

goodness_fit_AICc <- goodness_fit_AICc[-1,]
goodness_fit_BIC <- goodness_fit_BIC[-1,]

write.csv(goodness_fit_AICc, "../Data/goodness_fit_AICc.csv", row.names = FALSE)
write.csv(goodness_fit_BIC, "../Data/goodness_fit_BIC.csv", row.names = FALSE)

## Coefficients
coef_TypeII <- coef_TypeII[-1,]
coef_TypeIII <- coef_TypeIII[-1,]
coef_General <- coef_General[-1,]

write.csv(coef_TypeII, "../Data/TypeII_coefficients.csv", row.names = FALSE)
write.csv(coef_TypeIII, "../Data/TypeIII_coefficients.csv", row.names = FALSE)
write.csv(coef_General, "../Data/General_coefficients.csv", row.names = FALSE)

################################################################################
############################## DEFINING A WINNER ###############################
################################################################################

############################ Adding a winner column ############################

## TypeI vs TypeII
goodness_fit_AICc <- define_winner(goodness_fit_AICc,
                              goodness_fit_AICc$AICc_TypeI, goodness_fit_AICc$AICc_TypeII,
                              "TypeI", "TypeII",
                              "AICc_TypeIvsTypeII_Winner")

goodness_fit_BIC <- define_winner(goodness_fit_BIC,
                              goodness_fit_BIC$BIC_TypeI, goodness_fit_BIC$BIC_TypeII,
                              "TypeI", "TypeII",
                              "BIC_TypeIvsTypeII_Winner")

## TypeI vs TypeIII
goodness_fit_AICc <- define_winner(goodness_fit_AICc,
                              goodness_fit_AICc$AICc_TypeI, goodness_fit_AICc$AICc_TypeIII,
                              "TypeI", "TypeIII",
                              "AICc_TypeIvsTypeIII_Winner")

goodness_fit_BIC <- define_winner(goodness_fit_BIC,
                              goodness_fit_BIC$BIC_TypeI, goodness_fit_BIC$BIC_TypeIII,
                              "TypeI", "TypeIII",
                              "BIC_TypeIvsTypeIII_Winner")

## TypeI vs General
goodness_fit_AICc <- define_winner(goodness_fit_AICc,
                                   goodness_fit_AICc$AICc_TypeI, goodness_fit_AICc$AICc_General,
                                   "TypeI", "General",
                                   "AICc_TypeIvsGeneral_Winner")

goodness_fit_BIC <- define_winner(goodness_fit_BIC,
                                  goodness_fit_BIC$BIC_TypeI, goodness_fit_BIC$BIC_General,
                                  "TypeI", "General",
                                  "BIC_TypeIvsGeneral_Winner")

## TypeII vs TypeIII
goodness_fit_AICc <- define_winner(goodness_fit_AICc,
                              goodness_fit_AICc$AICc_TypeII, goodness_fit_AICc$AICc_TypeIII,
                              "TypeII", "TypeIII",
                              "AICc_TypeIIvsTypeIII_Winner")

goodness_fit_BIC <- define_winner(goodness_fit_BIC,
                              goodness_fit_BIC$BIC_TypeII, goodness_fit_BIC$BIC_TypeIII,
                              "TypeII", "TypeIII",
                              "BIC_TypeIIvsTypeIII_Winner")

## TypeII vs General
goodness_fit_AICc <- define_winner(goodness_fit_AICc,
                                   goodness_fit_AICc$AICc_TypeII, goodness_fit_AICc$AICc_General,
                                   "TypeII", "General",
                                   "AICc_TypeIIvsGeneral_Winner")

goodness_fit_BIC <- define_winner(goodness_fit_BIC,
                                  goodness_fit_BIC$BIC_TypeII, goodness_fit_BIC$BIC_General,
                                  "TypeII", "General",
                                  "BIC_TypeIIvsGeneral_Winner")

## TypeIII vs General
goodness_fit_AICc <- define_winner(goodness_fit_AICc,
                                   goodness_fit_AICc$AICc_TypeIII, goodness_fit_AICc$AICc_General,
                                   "TypeIII", "General",
                                   "AICc_TypeIIIvsGeneral_Winner")

goodness_fit_BIC <- define_winner(goodness_fit_BIC,
                                  goodness_fit_BIC$BIC_TypeIII, goodness_fit_BIC$BIC_General,
                                  "TypeIII", "General",
                                  "BIC_TypeIIIvsGeneral_Winner")

######################### Sum number of wins per model #########################

## AICc
goodness_fit_AICc$count_winnerAICc_TypeI <- rowSums(goodness_fit_AICc[, c("AICc_TypeIvsTypeII_Winner","AICc_TypeIvsTypeIII_Winner","AICc_TypeIvsGeneral_Winner","AICc_TypeIIvsTypeIII_Winner","AICc_TypeIIvsGeneral_Winner","AICc_TypeIIIvsGeneral_Winner")] == "TypeI")
goodness_fit_AICc$count_winnerAICc_TypeII <- rowSums(goodness_fit_AICc[, c("AICc_TypeIvsTypeII_Winner","AICc_TypeIvsTypeIII_Winner","AICc_TypeIvsGeneral_Winner","AICc_TypeIIvsTypeIII_Winner","AICc_TypeIIvsGeneral_Winner","AICc_TypeIIIvsGeneral_Winner")] == "TypeII")
goodness_fit_AICc$count_winnerAICc_TypeIII <- rowSums(goodness_fit_AICc[, c("AICc_TypeIvsTypeII_Winner","AICc_TypeIvsTypeIII_Winner","AICc_TypeIvsGeneral_Winner","AICc_TypeIIvsTypeIII_Winner","AICc_TypeIIvsGeneral_Winner","AICc_TypeIIIvsGeneral_Winner")] == "TypeIII")
goodness_fit_AICc$count_winnerAICc_General <- rowSums(goodness_fit_AICc[, c("AICc_TypeIvsTypeII_Winner","AICc_TypeIvsTypeIII_Winner","AICc_TypeIvsGeneral_Winner","AICc_TypeIIvsTypeIII_Winner","AICc_TypeIIvsGeneral_Winner","AICc_TypeIIIvsGeneral_Winner")] == "General")
# no comparison can exceed a maximum of 2 wins - only 2 comparisons per model

## BIC
goodness_fit_BIC$count_winnerBIC_TypeI <- rowSums(goodness_fit_BIC[, c("BIC_TypeIvsTypeII_Winner","BIC_TypeIvsTypeIII_Winner","BIC_TypeIvsGeneral_Winner","BIC_TypeIIvsTypeIII_Winner","BIC_TypeIIvsGeneral_Winner","BIC_TypeIIIvsGeneral_Winner")] == "TypeI")
goodness_fit_BIC$count_winnerBIC_TypeII <- rowSums(goodness_fit_BIC[, c("BIC_TypeIvsTypeII_Winner","BIC_TypeIvsTypeIII_Winner","BIC_TypeIvsGeneral_Winner","BIC_TypeIIvsTypeIII_Winner","BIC_TypeIIvsGeneral_Winner","BIC_TypeIIIvsGeneral_Winner")] == "TypeII")
goodness_fit_BIC$count_winnerBIC_TypeIII <- rowSums(goodness_fit_BIC[, c("BIC_TypeIvsTypeII_Winner","BIC_TypeIvsTypeIII_Winner","BIC_TypeIvsGeneral_Winner","BIC_TypeIIvsTypeIII_Winner","BIC_TypeIIvsGeneral_Winner","BIC_TypeIIIvsGeneral_Winner")] == "TypeIII")
goodness_fit_BIC$count_winnerBIC_General <- rowSums(goodness_fit_BIC[, c("BIC_TypeIvsTypeII_Winner","BIC_TypeIvsTypeIII_Winner","BIC_TypeIvsGeneral_Winner","BIC_TypeIIvsTypeIII_Winner","BIC_TypeIIvsGeneral_Winner","BIC_TypeIIIvsGeneral_Winner")] == "General")
# no comparison can exceed a maximum of 2 wins - only 2 comparisons per model

########################## Add overall winner column ###########################

## AICc
goodness_fit_AICc$overallAICc<- ifelse(goodness_fit_AICc$count_winnerAICc_TypeI == 3,   "TypeI",
                                ifelse(goodness_fit_AICc$count_winnerAICc_TypeII == 3,  "TypeII",
                                ifelse(goodness_fit_AICc$count_winnerAICc_TypeIII == 3, "TypeIII",
                                ifelse(goodness_fit_AICc$count_winnerAICc_General == 3, "General",
                                                                                        "Draw"))))

## BIC
goodness_fit_BIC$overallBIC<- ifelse(goodness_fit_BIC$count_winnerBIC_TypeI == 3,   "TypeI",
                              ifelse(goodness_fit_BIC$count_winnerBIC_TypeII == 3,  "TypeII",
                              ifelse(goodness_fit_BIC$count_winnerBIC_TypeIII == 3, "TypeIII",
                              ifelse(goodness_fit_BIC$count_winnerBIC_General == 3, "General",
                                                                                "Draw"))))

########################### Calculate percent winner ###########################

## AICc
Percent_AICc_TypeI_Winner <- (sum(goodness_fit_AICc$overallAICc == "TypeI") / length(unique(goodness_fit_AICc$ID)) * 100)
Percent_AICc_TypeII_Winner <- (sum(goodness_fit_AICc$overallAICc == "TypeII") / length(unique(goodness_fit_AICc$ID)) * 100)
Percent_AICc_TypeIII_Winner <- (sum(goodness_fit_AICc$overallAICc == "TypeIII") / length(unique(goodness_fit_AICc$ID)) * 100)
Percent_AICc_General_Winner <- (sum(goodness_fit_AICc$overallAICc == "General") / length(unique(goodness_fit_AICc$ID)) * 100)
Percent_AICc_Draw <- (sum(goodness_fit_AICc$overallAICc == "Draw") / length(unique(goodness_fit_AICc$ID)) * 100)

## Write all percentages into a vector
AICc <- c(Percent_AICc_TypeI_Winner, Percent_AICc_TypeII_Winner, Percent_AICc_TypeIII_Winner, Percent_AICc_General_Winner, Percent_AICc_Draw)

## BIC
Percent_BIC_TypeI_Winner <- (sum(goodness_fit_BIC$overallBIC == "TypeI") / length(unique(goodness_fit_BIC$ID)) * 100)
Percent_BIC_TypeII_Winner <- (sum(goodness_fit_BIC$overallBIC == "TypeII") / length(unique(goodness_fit_BIC$ID)) * 100)
Percent_BIC_TypeIII_Winner <- (sum(goodness_fit_BIC$overallBIC == "TypeIII") / length(unique(goodness_fit_BIC$ID)) * 100)
Percent_BIC_General_Winner <- (sum(goodness_fit_BIC$overallBIC == "General") / length(unique(goodness_fit_BIC$ID)) * 100)
Percent_BIC_Draw <- (sum(goodness_fit_BIC$overallBIC == "Draw") / length(unique(goodness_fit_BIC$ID)) * 100)

# Write all percentages into a vector
BIC <- c(Percent_BIC_TypeI_Winner, Percent_BIC_TypeII_Winner, Percent_BIC_TypeIII_Winner, Percent_BIC_General_Winner, Percent_BIC_Draw)

################################################################################
#################### CREATE TABLE FOR PAIRWISE COMPARISONS #####################
################################################################################

##################################### AICc #####################################
table_df <- data.frame(matrix(vector(), 1, 7,
                              dimnames = list(c(),
                                              c("StraightLine",
                                                "Quadratic",
                                                "Cubic",
                                                "TypeI",
                                                "TypeII",
                                                "TypeIII",
                                                "General"))),
                       stringsAsFactors = F)

for (i in 1:7) {
  table_df <- pairwise_wins(goodness_fit_AICc, i)
  table_df[i+1,i] <- ""
}

## Round values to make standard
#table_df <- round(table_df[, 1:7], 3)

## Remove empty first row
table_df <- table_df[-1,]

## Correct row and column names
row.names(table_df) <- c("Straight Line",
                         "Quadratic",
                         "Cubic",
                         "Holling Type I",
                         "Holling Type II",
                         "Holling Type III",
                         "Generalised")

colnames(table_df) <- c("Straight Line",
                        "Quadratic",
                        "Cubic",
                        "Holling Type I",
                        "Holling Type II",
                        "Holling Type III",
                        "Generalised")

table_AICc <- table_df

##################################### BIC #####################################
table_df <- data.frame(matrix(vector(), 1, 7,
                              dimnames = list(c(),
                                              c("StraightLine",
                                                "Quadratic",
                                                "Cubic",
                                                "Type I",
                                                "Type II",
                                                "Type III",
                                                "General"))),
                       stringsAsFactors = F)

for (i in 1:7) {
  table_df <- pairwise_wins(goodness_fit_BIC, i)
  table_df[i+1,i] <- ""
}

## Round values to make standard
#table_df <- round(table_df[, 1:7], 3)

## Remove empty first row
table_df <- table_df[-1,]

## Correct row and column names
row.names(table_df) <- c("Straight Line",
                         "Quadratic",
                         "Cubic",
                         "Holling Type I",
                         "Holling Type II",
                         "Holling Type III",
                         "Generalised")

colnames(table_df) <- c("Straight Line",
                        "Quadratic",
                        "Cubic",
                        "Holling Type I",
                        "Holling Type II",
                        "Holling Type III",
                        "Generalised")

table_BIC <- table_df

######################### SAVE TABLES AS LaTeX SCRIPT ##########################
bold <- function(x) {paste('{\\textbf{',x,'}}', sep ='')}

print(xtable(table_AICc, digitis = 3), 
      sanitize.rownames.function = bold,
      file = "../Results/Table_AICc", 
      floating = FALSE, 
      latex.environments = NULL, 
      booktabs = TRUE)

print(xtable(table_BIC, digitis = 3), 
      sanitize.rownames.function = bold,
      file = "../Results/Table_BIC", 
      floating = FALSE, 
      latex.environments = NULL, 
      booktabs = TRUE)

################################################################################
####################### CREATE TABLE FOR OVERALL WINNER ########################
################################################################################

## Write percentages into a combined data frame for plotting
models <- c("TypeI","TypeII","TypeIII","General","Draw")
test_AICc <- c("AICc","AICc","AICc","AICc","AICc")
test_BIC <- c("BIC","BIC","BIC","BIC","BIC")

percent_AICc <- data.frame(models, test_AICc, AICc)
percent_BIC <- data.frame(models, test_BIC, BIC)

percent_AICc$models <- factor(percent_AICc$models, levels = c("TypeI","TypeII","TypeIII","General","Draw"))
percent_BIC$models <- factor(percent_BIC$models, levels = c("TypeI","TypeII","TypeIII","General","Draw"))

## Plot
cbPalette <- c("#F23557", "#F0D43A", "#22B2DA", "#3B4A6B", "grey",
               "#F23557", "#F0D43A", "#22B2DA", "#3B4A6B", "grey")

p_AICc <- ggplot(data = percent_AICc, aes(x = models, y = AICc, fill = models)) +
  ylim(0, 40) +
  geom_col() + 
  theme_bw() +
  scale_fill_manual(values = cbPalette) + 
  ylab("Overall winner (% of IDs)") +
  theme(aspect.ratio = 1,
        axis.title.x=element_blank(),
        axis.title.y = element_text(vjust=3),
        plot.margin=unit(c(0.5,0.5,1,0.5),"cm"),
        text = element_text(size=15))

p_BIC <- ggplot(data = percent_BIC, aes(x = models, y = BIC, fill = models)) +
  ylim(0, 40) +
  geom_col() +
  theme_bw() +
  scale_fill_manual(values = cbPalette) + 
  ylab("Overall winner (% of IDs)") +
  theme(aspect.ratio = 1,
        axis.title.x=element_blank(),
        axis.title.y = element_text(vjust=3),
        plot.margin=unit(c(0.5,0.5,1,0.5),"cm"),
        text = element_text(size=15))

final_plot <- plot_grid(p_AICc + theme(legend.position = "none"), 
                        p_BIC + theme(legend.position = "none"), 
                        labels = c("a","b"), 
                        hjust = -2,
                        nrow = 2) +
  draw_label("Models", x = 0.5, y = 0.01, vjust = 0, angle = 0)

pdf("../Results/Overall_winner_mechanistics.pdf", width = 4.5, height = 8)
print(final_plot)
dev.off()



print("Model fitting script done!!")