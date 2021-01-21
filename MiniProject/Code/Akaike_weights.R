#!/usr/bin/env Rscript --vanilla

# Title: Akaike_weights.R
# Author details: Author: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Calculate and plot Akaike Weights.
# Copyright statement: none

################################################################################
###################### CALCULATING AKAIKE WEIGHTS PER ID #######################
################################################################################

## Housekeeping
rm(list = ls())
graphics.off()
set.seed(1)

## Load packages
require(cowplot)
require(ggplot2)

## Load data
goodness_fit_AICc <- read.csv("../Data/goodness_fit_AICc.csv")

################################################################################
########################### ONLY MECHANISTIC MODELS ############################
################################################################################


## Set up data frame to store Akaike Weights per ID
Weights <- data.frame(matrix(vector(), 1, 5,
                             dimnames = list(c(),
                                             c("ID",
                                               "TypeI",
                                               "TypeII",
                                               "TypeIII",
                                               "General"))),
                      stringsAsFactors = F)

## Loop through IDs
for (i in 1:nrow(goodness_fit_AICc)) {
  
  ID <- goodness_fit_AICc[i,1]
  
  diff <- goodness_fit_AICc[i, 6:9] - min(goodness_fit_AICc[i, 6:9])
  exp <- exp(-0.5*diff)
  
  df <- data.frame(ID, exp)
  
  colnames(df) <- c("ID",
                    "TypeI",
                    "TypeII",
                    "TypeIII",
                    "General")
  
  Weights <- rbind(Weights, df)
  
}

## Tidy up df output
Weights <- Weights[-1,]
Weights <- Weights[!is.infinite(rowSums(Weights)),]
Weights <- Weights[!is.nan(rowSums(Weights)),]

## Change to proportion
Weights_Prop <- Weights[,2:5]/rowSums(Weights[,2:5])
Weights_Prop$Total <- rowSums(Weights_Prop)

## Mean Akaike Weights for each model for each ID
models <- c("TypeI","TypeII","TypeIII","General")
means <- colMeans(Weights_Prop[1:4])

summary <- as.data.frame(models)
summary <- cbind(summary, means)

## Plotting
summary$models <- factor(summary$models, levels = c("TypeI","TypeII","TypeIII","General"))
cbPalette <- c("#F23557", "#F0D43A", "#22B2DA", "#3B4A6B")

barplot <- ggplot(summary, aes(models, means, fill = models)) + 
  geom_col() +
  theme_bw() +
  scale_fill_manual(values = cbPalette) +
  labs(x = "Models",
       y = "Mean Akaike Weights") +
  theme(aspect.ratio = 1,
        legend.position = "none",
        text = element_text(size=15),
        axis.title.y = element_text(vjust=3),
        axis.title.x = element_text(vjust=-0.5),
        plot.margin=unit(c(0.5,0.5,0.5,1),"cm"))

pdf("../Results/Akaike_weights.pdf", height = 6, width = 6)
print(barplot)
dev.off()

################################################################################
############## Supplementary figure - histogram of Akaike Weights ##############
################################################################################

p <- ggplot(data = Weights_Prop, aes(x = TypeI)) +
  geom_histogram() +
  theme_bw() +
  ylab("Frequency") +
  xlab("Akaike Weight") +
  ylim(c(0, 250)) +
  theme(aspect.ratio = 1,
        axis.title.y = element_text(vjust=2),
        axis.title.x = element_text(vjust=-1),
        plot.margin=unit(c(0.5,0.5,0.5,0.5),"cm"),
        text = element_text(size=15))

q <- ggplot(data = Weights_Prop, aes(x = TypeII)) +
  geom_histogram() +
  theme_bw() +
  ylab("Frequency") +
  xlab("Akaike Weight") +
  ylim(c(0, 250)) +
  theme(aspect.ratio = 1,
        axis.title.y = element_text(vjust=2),
        axis.title.x = element_text(vjust=-1),
        plot.margin=unit(c(0.5,0.5,0.5,0.5),"cm"),
        text = element_text(size=15))

r <- ggplot(data = Weights_Prop, aes(x = TypeIII)) +
  geom_histogram() +
  theme_bw() +
  ylab("Frequency") +
  xlab("Akaike Weight") +
  ylim(c(0, 250)) +
  theme(aspect.ratio = 1,
        axis.title.y = element_text(vjust=2),
        axis.title.x = element_text(vjust=-1),
        plot.margin=unit(c(0.5,0.5,0.5,0.5),"cm"),
        text = element_text(size=15))

s <- ggplot(data = Weights_Prop, aes(x = General)) +
  geom_histogram() +
  theme_bw() +
  ylab("Frequency") +
  xlab("Akaike Weight") +
  ylim(c(0, 250)) +
  theme(aspect.ratio = 1,
        axis.title.y = element_text(vjust=2),
        axis.title.x = element_text(vjust=-1),
        plot.margin=unit(c(0.5,0.5,0.5,0.5),"cm"),
        text = element_text(size=15))

final_plot <- plot_grid(p + theme(legend.position = "none"), 
                        q + theme(legend.position = "none"),
                        r + theme(legend.position = "none"),
                        s + theme(legend.position = "none"),
                        labels = c("a","b","c","d"), 
                        hjust = -2,
                        nrow = 2)

pdf("../Results/AW_frequency.pdf", width = 9, height = 9)
print(final_plot)
dev.off()



print("Akaike Weights script done!")