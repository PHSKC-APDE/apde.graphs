# Header ----
# Author: Danny Colombara
# Date: 2024-12-20
# R version: 4.4.1
# Purpose: Create synthetic data of life span in ancient cities for ggplot samples

# Set up ----
options(scipen=999) # disable scientific notation
library(data.table)
set.seed(98104) # necessary to get same 'random' results each time

# Create Raw / line level data ----
# Define cities and their mean lifespans
cities <- c("Athens", "Babylon", "Carthage", "Pataliputra", "Persepolis", "Rome", "Thebes", "Xian")
mean_lifespans <- round(runif(8, 38, 57), 1)

# Number of observations per city
n_per_city <- 1000

# Create base synthetic data table
dt_raw <- data.table(
  city = rep(cities, each = n_per_city),
  sex = factor(rep(c("Female", "Male"), each = n_per_city/2), levels = c("Female", "Male"))
)

# Generate sex-specific lifespans while maintaining city means
dt_raw[, lifespan := {
  city_mean <- mean_lifespans[which(cities == .BY[[1]])]
  sex_diff <- rnorm(1, mean = 8, sd = 4)  # difference between female and male

  ifelse(
    sex == "Female",
    round(rnorm(.N, mean = city_mean + sex_diff/2, sd = 5), 0),
    round(rnorm(.N, mean = city_mean - sex_diff/2, sd = 5), 0)
  )
}, by = city]

dt_raw[, city := factor(city, levels = c("Athens", "Babylon", "Carthage", "Pataliputra", "Persepolis", "Rome", "Thebes", "Xian"))]

dt_raw[city %in% c("Athens", "Rome", "Carthage"), region := "Mediterranean"]
dt_raw[city %in% c("Babylon", "Persepolis"), region := "Middle East"]
dt_raw[city %in% c("Pataliputra", "Xian", "Thebes"), region := "Other"]
dt_raw[, region := factor(region, levels = c('Mediterranean', 'Middle East', 'Other'))]

# Create aggregated data ----
# Aggregate the synthetic raw data to calculate mean lifespans
dt_agg_synthetic <- dt_raw[, .(
  mean_lifespan = mean(lifespan)
), by = city]

# Give informative object name ----
lifespanDT_raw <- copy(dt_raw)
lifespanDT_agg <- copy(dt_agg_synthetic)

# Export to the data directory
usethis::use_data(lifespanDT_raw, overwrite = TRUE)
usethis::use_data(lifespanDT_agg, overwrite = TRUE)
