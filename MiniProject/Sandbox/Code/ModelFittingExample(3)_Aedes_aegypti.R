### Aedes aegypti fecundity ###

library(minpack.lm)

# Load and visualize the data

aedes <- read.csv("../Data/aedes_fecund.csv")
  
plot(aedes$T, aedes$EFD, xlab = "Temperature (c)", ylab = "Eggs / day")

## The TPC models

quad1 <- function(T, T0, Tm, c) {
  c * (T - T0) * (T - Tm) * as.numeric(T < Tm) * as.numeric(T > T0)
}

briere <- function(T, T0, Tm, c) {
  c * T * (T - T0) * (abs(Tm - T) ^ (1 / 2)) * as.numeric(T < Tm) * as.numeric(T > T0)
}

## Scale data

scale <- 20

aed.lin <- lm(EFD / scale ~ T, data = aedes)

aed.quad <- nlsLM(EFD / scale ~ quad1(T, T0, Tm, c),
                  start = list(T0 = 10, Tm = 40, c = 0.01),
                  data = aedes)

aed.br <- nlsLM(EFD / scale ~ briere(T, T0, Tm, c),
                start = list(T0 = 10, Tm = 40, c = 0.1),
                data = aedes)

## Complete as per example 2