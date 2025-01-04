# Header ----
# Author: Danny Colombara
# Date: January 3, 2025
# R version: 4.4.1
# Purpose: BigCities shapefiles and centroids

# Set up ----
rm(list = ls())
Sys.setenv(TZ='America/Los_Angeles') # set time zone
options(scipen=999) # disable scientific notation
library(sf)
library(dplyr)

# Get shapefile ----
shapeBigCities <- st_read("//dphcifs/APDE-CDIP/Shapefiles/Census_2020/places/kc_places.shp")

shapeBigCities <-  shapeBigCities |>
  select(NAME) |>
  filter(NAME %in% c('Seattle', 'Kirkland', 'Federal Way', 'Kent', 'Redmond', 'Renton', 'Bellevue', 'Auburn'))

# Generate centroids ----
centroidsBigCities <- st_centroid(shapeBigCities)

# Export to the data directory
usethis::use_data(shapeBigCities, overwrite = TRUE)
usethis::use_data(centroidsBigCities, overwrite = TRUE)

