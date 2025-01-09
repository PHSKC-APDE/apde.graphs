# Header ----
# Author: Danny Colombara
# Date: January 6, 2025
# R version: 4.4.1
# Purpose: Create King County polygon - water removed

# Set up ----
library(sf)
library(dplyr)

# Get shapefile ----
shapeKC <- st_read("//dphcifs/APDE-CDIP/Shapefiles/Region/region_hra20_nowater.shp")
shapeKC <- shapeKC |>
  st_transform(2926) |> # EPSG code for NAD83(HARN) / Washington North
  st_union() |>
  st_sf() |>
  mutate(COUNTY = 'King')

# Export to the data directory
usethis::use_data(shapeKC, overwrite = TRUE)
