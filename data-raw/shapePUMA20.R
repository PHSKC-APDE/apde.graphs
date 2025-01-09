# Header ----
# Author: Danny Colombara
# Date: January 3, 2025
# R version: 4.4.1
# Purpose: 2020 vintage Public Use Microdata Area shapefile - water removed

# Set up ----
library(sf)
library(dplyr)

# Get shapefile ----
shapePUMA20 <- st_read("//dphcifs/APDE-CDIP/Shapefiles/Census_2020/puma/kc_puma.shp")
shapePUMA20 <- shapePUMA20 |>
  select(PUMACE20) |>
  filter(PUMACE20 %in% 23301:23318) |> # These are King County PUMA20 codes
  st_transform(2926) # EPSG code for NAD83(HARN) / Washington North

shapeHRA20 <- st_read("//dphcifs/APDE-CDIP/Shapefiles/HRA/hra_2020_nowater.shp")
shapeHRA20 <- shapeHRA20 |> 
  select(HRA20 = name) |> 
  st_transform(2926) # EPSG code for NAD83(HARN) / Washington North

# Remove water from PUMAs using information from HRAs
shapePUMA20 = st_intersection(shapePUMA20, st_union(shapeHRA20))

# Export to the data directory
usethis::use_data(shapePUMA20, overwrite = TRUE)

