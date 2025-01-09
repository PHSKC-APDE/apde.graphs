# Header ----
# Author: Danny Colombara
# Date: January 6, 2025
# R version: 4.4.1
# Purpose: Create King County Medical Center point shapefile

# Set up ----
library(sf)
library(dplyr)

# Get shapefiles ----
# Medical centers
shapeMedicalCenters <- st_read("//Kcitfsrprpgdw01/kclib/Plibrary2/pubsafe/shapes/point/medical_facilities.shp")
shapeMedicalCenters <- shapeMedicalCenters |> select(NAME)

# Set CRS
shapeMedicalCenters <- st_transform(shapeMedicalCenters, 2926) # EPSG code for NAD83(HARN) / Washington North

# Export to the data directory
usethis::use_data(shapeMedicalCenters, overwrite = TRUE)
