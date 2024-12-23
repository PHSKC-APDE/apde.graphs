# Header ----
# Author: Danny Colombara
# Date: 2024-12-20
# R version: 4.4.1
# Purpose: Create synthetic data of favorite ice cream flavors by income and year

# Set up ----
options(scipen=999) # disable scientific notation
library(data.table)
set.seed(98104) # necessary to get same 'random' results each time

# Create base data
years <- c(1980, 1990, 2000, 2010, 2020)
flavors <- c("Vanilla", "Chocolate", "Other")

# Function to generate mean incomes with trend
generate_income <- function(years, base, slope) {
  base + (years - 1980) * slope + rnorm(length(years), 0, 500)
}

# Create table of years and flavors
dt <- CJ(year = years, flavor = flavors)
dt[, flavor := factor(flavor, levels = c("Chocolate", "Vanilla", "Other"))] # to ensure graph order

# Generate means and standard errors
dt[flavor == "Vanilla", mean_income := generate_income(year, base = 75000, slope = 50)]
dt[flavor == "Chocolate", mean_income := generate_income(year, base = 70000, slope = 200)]
dt[flavor == "Other", mean_income := generate_income(year, base = 65000, slope = 500)]
dt[, mean_income := round(mean_income, 0)]

# Add standard errors (random sizes)
dt[, se := runif(15, 1500, 5000)]
dt[, se := round(se, 0)]

# Give informative object name ----
icecreamDT <- copy(dt)

# Export to the data directory
usethis::use_data(icecreamDT, overwrite = TRUE)

