# Header ----
# Author: Danny Colombara
# Date: January 3, 2025
# R version: 4.4.1
# Purpose: Create 2020 vintage Health Reporting Area (HRA) polygons - water removed

# Set up ----
library(sf)
library(dplyr)

# Get shapefile ----
shapeHRA20 <- st_read("//dphcifs/APDE-CDIP/Shapefiles/HRA/hra_2020_nowater.shp")
shapeHRA20 <- shapeHRA20 |> 
  select(HRA20 = name) |>
  st_transform(2926) # EPSG code for NAD83(HARN) / Washington North

# Export to the data directory
usethis::use_data(shapeHRA20, overwrite = TRUE)
