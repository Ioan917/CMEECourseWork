#!/usr/bin/env Rscript --vanilla

# Title: Extras.R
# Author details: Author: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Extra ideas explored but not included in the mini-project
# Copyright statement: none

################################################################################
########## PLOTTING THE PROPORTION OF WINNER AGAINST THE SAMPLE SIZE ###########
################################################################################

## AICc
prop_winner <- goodness_fit %>%
  group_by(sample_size, overallAICc) %>%
  tally()

Quad <- subset(prop_winner, overallAICc == "Quadratic")
Cubic <- subset(prop_winner, overallAICc == "Cubic")
Holling <- subset(prop_winner, overallAICc == "Holling")
Draw <- subset(prop_winner, overallAICc == "Draw")

## Plot
prop_AICc <- ggplot(data = prop_winner, aes(x = log(sample_size), y = log(n))) +
  geom_point(data = Quad, aes(x = log(sample_size), y = log(n)), col = "blue") + 
  geom_point(data = Cubic, aes(x = log(sample_size), y = log(n)), col = "red") + 
  geom_point(data = Holling, aes(x = log(sample_size), y = log(n)), col = "orange") + 
  geom_point(data = Draw, aes(x = log(sample_size), y = log(n)), col = "grey") + 
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        plot.margin=unit(c(1,1,1.5,1.2),"cm"))

## BIC
prop_winner <- goodness_fit %>%
  group_by(sample_size, overallBIC) %>%
  tally()

Quad <- subset(prop_winner, overallBIC == "Quadratic")
Cubic <- subset(prop_winner, overallBIC == "Cubic")
Holling <- subset(prop_winner, overallBIC == "Holling")
Draw <- subset(prop_winner, overallBIC == "Draw")

## Plot
prop_BIC <- ggplot(data = prop_winner, aes(x = log(sample_size), y = log(n))) +
  geom_point(data = Quad, aes(x = log(sample_size), y = log(n)), col = "blue") + 
  geom_point(data = Cubic, aes(x = log(sample_size), y = log(n)), col = "red") + 
  geom_point(data = Holling, aes(x = log(sample_size), y = log(n)), col = "orange") + 
  geom_point(data = Draw, aes(x = log(sample_size), y = log(n)), col = "grey") + 
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        plot.margin=unit(c(1,1,1.5,1.2),"cm"))

final_plot <- plot_grid(prop_AICc + theme(legend.position = "none"), 
                        prop_BIC + theme(legend.position = "none"), 
                        labels = c("a","b"), 
                        hjust = -2,
                        nrow = 1) +
  draw_label("log(Sample size)", x = 0.5, y = 0.05, vjust = 0, angle = 0) +
  draw_label("log(Number of wins)", x = 0, y = 0.5, vjust = 1.5, angle = 90)

# From this plot:
# Evident that there are more repeats of smaller sample sizes
# glm shows no significant relationship between model and proportion best fit

################################################################################
##################################### RSS ######################################
################################################################################

## Set up data frame to capture residuals for each ID
TypeI_residuals_df <- data.frame(matrix(vector(), 1, 3,
                                        dimnames = list(c(),
                                                        c("resid_ID",
                                                          "model",
                                                          "TypeI_resid"))),
                                 stringsAsFactors = F)
TypeII_residuals_df <- data.frame(matrix(vector(), 1, 3,
                                         dimnames = list(c(),
                                                         c("resid_ID",
                                                           "model",
                                                           "TypeII_resid"))),
                                  stringsAsFactors = F)
TypeIII_residuals_df <- data.frame(matrix(vector(), 1, 3,
                                          dimnames = list(c(),
                                                          c("resid_ID",
                                                            "model",
                                                            "TypeIII_resid"))),
                                   stringsAsFactors = F)
General_residuals_df <- data.frame(matrix(vector(), 1, 3,
                                          dimnames = list(c(),
                                                          c("resid_ID",
                                                            "model",
                                                            "General_resid"))),
                                   stringsAsFactors = F)

## Inside loop
## Residual sum of squares
TypeI_residuals_df <- rbind(TypeI_residuals_df, list(ID, "TypeI", sum(residuals(TypeIFit)^2)))
try(TypeII_residuals_df <- rbind(TypeII_residuals_df, list(ID, "TypeII", TypeIIFit$m$deviance())), TRUE)
try(TypeIII_residuals_df <- rbind(TypeIII_residuals_df, list(ID, "TypeIII", TypeIIIFit$m$deviance())), TRUE)
try(General_residuals_df <- rbind(General_residuals_df, list(ID, "General", GeneralFit$m$deviance())), TRUE)

## Outside loop
## RSS
colnames(TypeI_residuals_df) <- c("ID", "model", "RSS")
colnames(TypeII_residuals_df) <- c("ID", "model", "RSS")
colnames(TypeIII_residuals_df) <- c("ID", "model", "RSS")
colnames(General_residuals_df) <- c("ID", "model", "RSS")

TypeI_residuals_df <- TypeI_residuals_df[-1,]
TypeII_residuals_df <- TypeII_residuals_df[-1,]
TypeIII_residuals_df <- TypeIII_residuals_df[-1,]
General_residuals_df <- General_residuals_df[-1,]

overall_RSS <- rbind(TypeI_residuals_df, TypeII_residuals_df)
overall_RSS <- rbind(overall_RSS, TypeIII_residuals_df)
overall_RSS <- rbind(overall_RSS, General_residuals_df)

boxplot(log(overall_RSS$RSS) ~ as.factor(overall_RSS$model)) # aov() suggests no sig diff

################################################################################
################ Standardised RSS at each datapoint per Subset #################
################################################################################

## Set up data frames to capture standardised RSS
TypeI_standardised_RSS <- data.frame(matrix(vector(), 1, 3,
                                            dimnames = list(c(),
                                                            c("ID",
                                                              "ResDensity",
                                                              "st_RSS"))),
                                     stringsAsFactors = F)
TypeII_standardised_RSS <- data.frame(matrix(vector(), 1, 3,
                                             dimnames = list(c(),
                                                             c("ID",
                                                               "ResDensity",
                                                               "st_RSS"))),
                                      stringsAsFactors = F)
TypeIII_standardised_RSS <- data.frame(matrix(vector(), 1, 3,
                                              dimnames = list(c(),
                                                              c("ID",
                                                                "ResDensity",
                                                                "st_RSS"))),
                                       stringsAsFactors = F)
General_standardised_RSS <- data.frame(matrix(vector(), 1, 3,
                                              dimnames = list(c(),
                                                              c("ID",
                                                                "ResDensity",
                                                                "st_RSS"))),
                                       stringsAsFactors = F)

## Inside loop
for (i in 1:length(SubsetData$ID)) {
  try(TypeII_st_RSS <- (SubsetData$N_TraitValue[i] - HollModII(SubsetData$ResDensity[i], coef(TypeIIFit)['a'], coef(TypeIIFit)['h'])^2) / SubsetData$N_TraitValue[i], TRUE)
  try(TypeIII_st_RSS <- (SubsetData$N_TraitValue[i] - HollModIII(SubsetData$ResDensity[i], coef(TypeIIIFit)['a'], coef(TypeIIIFit)['h'])^2) / SubsetData$N_TraitValue[i], TRUE)
  try(General_st_RSS <- (SubsetData$N_TraitValue[i] - GenFunMod(SubsetData$ResDensity[i], coef(GeneralFit)['a'], coef(GeneralFit)['h'], coef(GeneralFit)['q'])^2) / SubsetData$N_TraitValue[i], TRUE)
  
  try(TypeII_standardised_RSS <- rbind(TypeII_standardised_RSS, list(SubsetData$ID[i], SubsetData$ResDensity[i]/max(SubsetData$ResDensity), TypeII_st_RSS[[1]])), TRUE)
  try(TypeIII_standardised_RSS <- rbind(TypeIII_standardised_RSS, list(SubsetData$ID[i], SubsetData$ResDensity[i]/max(SubsetData$ResDensity), TypeIII_st_RSS[[1]])), TRUE)
  try(General_standardised_RSS <- rbind(General_standardised_RSS, list(SubsetData$ID[i], SubsetData$ResDensity[i]/max(SubsetData$ResDensity), General_st_RSS[[1]])), TRUE)
}

## Outside loop
## Standardised RSS
TypeII_standardised_RSS <- TypeII_standardised_RSS[-1,]
TypeIII_standardised_RSS <- TypeIII_standardised_RSS[-1,]
General_standardised_RSS <- General_standardised_RSS[-1,]

################################################################################
#################### USING FORMATTABLE TO MAKE PRETTY PLOT #####################
################################################################################

## Need to work on resolution
library("htmltools")
library("webshot")
require(png)

formattable(table_AICc)
formattable(table_BIC)

customGreen <- "#71CA97"
customGreen0 <- "#DeF7E9"

table_AICc <- formattable(table_AICc, 
                          align = c("c","c","c","c","c","c","c"),
                          lapply(1:nrow(table_df), function(row) {
                            area(row, col = 1:7) ~ color_tile(customGreen0, customGreen);
                          }))
#table_AICc <- formattable(table_AICc,
#                          list(` ` = formatter("span", style = ~ style(color = "black", font.weight = "bold"))))

table_BIC <- formattable(table_BIC, 
                         align = c("c","c","c","c","c","c","c"),
                         lapply(1:nrow(table_df), function(row) {
                           area(row, col = 1:7) ~ color_tile(customGreen0, customGreen)
                         }))

export_formattable(table_AICc,"../Plots/AICc_table.png")
export_formattable(table_BIC,"../Plots/BIC_table.png")
# doesn't save properly when saving as pdf

########################## MAKE INTO MULTI-PANEL PLOT ##########################

require(magick)

AICc_png <- magick::image_read("../Plots/AICc_table.png")
BIC_png <- magick::image_read("../Plots/BIC_table.png")

AICc <- ggplot2::ggplot() + ggplot2::annotation_custom(grid::rasterGrob(AICc_png,
                                                                        width=ggplot2::unit(1,"npc"),
                                                                        height=ggplot2::unit(1,"npc")),
                                                       -Inf, Inf, -Inf, Inf)
#+ theme(plot.margin = unit(c(5,2,5,2), "lines"))
BIC <- ggplot2::ggplot() + ggplot2::annotation_custom(grid::rasterGrob(BIC_png,
                                                                       width=ggplot2::unit(1,"npc"),
                                                                       height=ggplot2::unit(1,"npc")),
                                                      -Inf, Inf, -Inf, Inf)
#+ theme(plot.margin = unit(c(5,2,5,2), "lines"))

final_plot <- plot_grid(AICc, 
                        BIC, 
                        labels = c("a","b"), 
                        nrow = 2,
                        rel_widths = c(0.5, 0.5))

pdf("../Results/Pairwise_percentages.pdf")
print(final_plot)
dev.off()