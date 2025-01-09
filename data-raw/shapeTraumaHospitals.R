# Header ----
# Author: Danny Colombara
# Date: January 6, 2025
# R version: 4.4.1
# Purpose: Create King County Acute Service (Trauma) Hospitals points

# Set up ----
library(sf)
library(dplyr)

# Get shapefiles ----
# Trauma hospitals
shapeTraumaHospitals <- st_read("//Kcitfsrprpgdw01/kclib/Plibrary2/pubsafe/shapes/point/hospitals.shp")
shapeTraumaHospitals <- shapeTraumaHospitals |>
  select(NAME) |>
  mutate(NAME = gsub(' Hospital| - ', '', NAME)) |>   # simplify  names
  mutate(NAME = gsub('Medical Center', '', NAME)) |>  # simplify  names
  mutate(NAME = gsub('Northwest', 'NW', NAME))        # simplify  names

# Set CRS
shapeTraumaHospitals <- st_transform(shapeTraumaHospitals, 2926) # EPSG code for NAD83(HARN) / Washington North

# Export to the data directory
usethis::use_data(shapeTraumaHospitals, overwrite = TRUE)
