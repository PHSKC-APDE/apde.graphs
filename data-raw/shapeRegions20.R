# Header ----
# Author: Danny Colombara
# Date: January 6, 2025
# R version: 4.4.1
# Purpose: Create 2020 vintage King County Regions polygons

# Set up ----
library(sf)
library(dplyr)

# Get shapefiles ----
# Regions
shapeRegions20 <- st_read("//dphcifs/APDE-CDIP/Shapefiles/Region/region_hra20_nowater.shp")
shapeRegions20 <- shapeRegions20 |>
  select(Region20 = name) |>
  st_transform(2926) # EPSG code for NAD83(HARN) / Washington North

# Export to the data directory
usethis::use_data(shapeRegions20, overwrite = TRUE)
