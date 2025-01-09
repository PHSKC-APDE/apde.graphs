# Header ----
# Author: Danny Colombara
# Date: 2024-12-20
# R version: 4.4.1
# Purpose: Create synthetic data of wisdom scores by age and group for sample
#          ggplots

# Set up ----
options(scipen=999) # disable scientific notation
library(data.table)
set.seed(98104) # necessary to get same 'random' results each time

# Basic table ----
n_points <- 1000

dt <- data.table(
  age = round(runif(n_points, 10, 70), 0), # random ages between 10 and 70
  group = sample(c('Group 1', 'Group 2'), n_points, replace = TRUE)
)

# Add 'wisdom' scores with different peaks for each group ----
dt[group == 'Group 1',
   wisdom_score := 20 + 60 * dnorm(age, 40, 25) + # a normal curve
     rnorm(.N, 0, 0.2)] # add random noise

dt[group == 'Group 2',
   wisdom_score := 20 + 60 * dnorm(age, 50, 20) +
     rnorm(.N, 0, 0.2)]

dt[, wisdom_score := wisdom_score]

# Give informative object name ----
wisdomDT <- copy(dt)

# Export to the data directory
usethis::use_data(wisdomDT, overwrite = TRUE)

