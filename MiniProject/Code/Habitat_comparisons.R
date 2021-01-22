#!/usr/bin/env Rscript --vanilla

# Title: Habitat_comparisons.R
# Author details: Author: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Compare AICc and BIC values for each mechanistic models per habitat.
# Copyright statement: none

################################################################################
#################### COMPARE AICc AND BIC BETWEEN HABITATS #####################
################################################################################

## Housekeeping
rm(list = ls())
graphics.off()
set.seed(1)

## Load packages
require(broom)
require(cowplot)
require(dplyr)
require(ggplot2)
require(xtable)

## Load functions
source("my_functions.R")

################################################################################
###################################### PREPARE DATA ############################
################################################################################

## Load data
data <- read.csv("../Data/CRat.csv")

goodness_fit_AICc <- read.csv("../Data/goodness_fit_AICc.csv")
goodness_fit_BIC <- read.csv("../Data/goodness_fit_BIC.csv")

## Extract relevant columns
AICc_TypeI <- goodness_fit_AICc[,c("ID","AICc_TypeI")]
AICc_TypeII <- goodness_fit_AICc[,c("ID","AICc_TypeII")]
AICc_TypeIII <- goodness_fit_AICc[,c("ID","AICc_TypeIII")]
AICc_General <- goodness_fit_AICc[,c("ID","AICc_General")]

BIC_TypeI <- goodness_fit_BIC[,c("ID","BIC_TypeI")]
BIC_TypeII <- goodness_fit_BIC[,c("ID","BIC_TypeII")]
BIC_TypeIII <- goodness_fit_BIC[,c("ID","BIC_TypeIII")]
BIC_General <- goodness_fit_BIC[,c("ID","BIC_General")]

## Create new data frames

## AICc
Model <- rep("TypeI", length(AICc_TypeI$ID))
AICc_TypeI <- cbind(AICc_TypeI, Model)
names(AICc_TypeI) <- c("ID","AICc","Model")

Model <- rep("TypeII", length(AICc_TypeII$ID))
AICc_TypeII <- cbind(AICc_TypeII, Model)
names(AICc_TypeII) <- c("ID","AICc","Model")

Model <- rep("TypeIII", length(AICc_TypeIII$ID))
AICc_TypeIII <- cbind(AICc_TypeIII, Model)
names(AICc_TypeIII) <- c("ID","AICc","Model")

Model <- rep("Generalised", length(AICc_General$ID))
AICc_General <- cbind(AICc_General, Model)
names(AICc_General) <- c("ID","AICc","Model")

AICc_final <- rbind(AICc_TypeI, AICc_TypeII)
AICc_final <- rbind(AICc_final, AICc_TypeIII)
AICc_final <- rbind(AICc_final, AICc_General)

## BIC
Model <- rep("TypeI", length(BIC_TypeI$ID))
BIC_TypeI <- cbind(BIC_TypeI, Model)
names(BIC_TypeI) <- c("ID","BIC","Model")

Model <- rep("TypeII", length(BIC_TypeII$ID))
BIC_TypeII <- cbind(BIC_TypeII, Model)
names(BIC_TypeII) <- c("ID","BIC","Model")

Model <- rep("TypeIII", length(BIC_TypeIII$ID))
BIC_TypeIII <- cbind(BIC_TypeIII, Model)
names(BIC_TypeIII) <- c("ID","BIC","Model")

Model <- rep("Generalised", length(BIC_General$ID))
BIC_General <- cbind(BIC_General, Model)
names(BIC_General) <- c("ID","BIC","Model")

BIC_final <- rbind(BIC_TypeI, BIC_TypeII)
BIC_final <- rbind(BIC_final, BIC_TypeIII)
BIC_final <- rbind(BIC_final, BIC_General)

################################################################################
############################# ANALYSIS OF VARIANCE #############################
################################################################################

############################## AICc AGAINST MODEL ##############################

## ANOVA
anova_A <- aov(AICc_final$AICc ~ AICc_final$Model)
#summary(anova_A)

anova_B <- aov(BIC_final$BIC ~ BIC_final$Model)
#summary(anova_B)

## TukeyHSD
#TukeyHSD(anova_A)
#TukeyHSD(anova_B)

######################## AICc AGAINST MODEL AND HABITAT ########################

## Merge with data to get habitat column
data <- data[,c("ID","Habitat")]

AICc_final <- left_join(AICc_final, data, by = "ID")
AICc_final <- unique(AICc_final)

BIC_final <- left_join(BIC_final, data, by = "ID")
BIC_final <- unique(BIC_final)

## ANOVA
anova_A <- aov(AICc_final$AICc ~ AICc_final$Model * AICc_final$Habitat)
#summary(anova_A)

anova_B <- aov(BIC_final$BIC ~ BIC_final$Model * BIC_final$Habitat)
#summary(anova_B)

## TukeyHSD
Tukey_A <- TukeyHSD(anova_A)
Tukey_B <- TukeyHSD(anova_B)

bold <- function(x) {paste('{\\textbf{',x,'}}', sep ='')}

print(xtable(tidy(Tukey_A), digitis = 3), 
      sanitize.colnames.function = bold,
      file = "../Results/Habitat_AICc", 
      floating = FALSE, 
      latex.environments = NULL, 
      booktabs = TRUE)

print(xtable(tidy(Tukey_B), digitis = 3), 
      sanitize.colnames.function = bold,
      file = "../Results/Habitat_BIC", 
      floating = FALSE, 
      latex.environments = NULL, 
      booktabs = TRUE)

##################################### PLOT #####################################

p <- ggplot(data = AICc_final, aes(x = Habitat, y = AICc)) +
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", size=2, shape = 18, color="red") +
  theme_bw() +
  ylab("AICc") +
  facet_wrap(~ Model, nrow = 1) +
  theme(aspect.ratio = 1,
        axis.title.x=element_blank(),
        axis.title.y = element_text(vjust=1),
        plot.margin=unit(c(0.5,0.5,0.5,0.5),"cm"),
        text = element_text(size=15))

q <- ggplot(data = BIC_final, aes(x = Habitat, y = BIC)) +
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", size=2, shape = 18, color="red") +
  theme_bw() +
  ylab("BIC") +
  facet_wrap(~ Model, nrow = 1) +
  theme(aspect.ratio = 1,
        axis.title.x=element_blank(),
        axis.title.y = element_text(vjust=1),
        plot.margin=unit(c(0.5,0.5,1,0.5),"cm"),
        text = element_text(size=15))

final_plot <- plot_grid(p + theme(legend.position = "none"), 
                        q + theme(legend.position = "none"), 
                        labels = c("a","b"), 
                        hjust = -2,
                        nrow = 2) +
  draw_label("Models", x = 0.55, y = 0.01, vjust = 0, angle = 0)

pdf("../Results/Model_fits_per_habitat.pdf", width = 12.5, height = 7.7)
print(final_plot)
dev.off()


print("Habitat comparisons script done!")
