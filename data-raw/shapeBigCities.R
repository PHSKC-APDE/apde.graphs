# Header ----
# Author: Danny Colombara
# Date: January 3, 2025
# R version: 4.4.1
# Purpose: Create King County `Big Cities` polygons and centroids

# Set up ----
library(sf)
library(dplyr)

# Get shapefile ----
shapeBigCities <- st_read("//dphcifs/APDE-CDIP/Shapefiles/Census_2020/places/kc_places.shp")

shapeBigCities <-  shapeBigCities |>
  select(NAME) |>
  filter(NAME %in% c('Seattle', 'Kirkland', 'Federal Way', 'Kent', 'Redmond', 'Renton', 'Bellevue', 'Auburn'))

# Set CRS ----
shapeBigCities <- st_transform(shapeBigCities, 2926) # EPSG code for NAD83(HARN) / Washington North


# Generate centroids ----
shapeBigCities_centroids <- st_centroid(shapeBigCities)

# Export to the data directory
usethis::use_data(shapeBigCities, overwrite = TRUE)
usethis::use_data(shapeBigCities_centroids, overwrite = TRUE)

