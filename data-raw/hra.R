# Header ----
# Author: Danny Colombara
# Date: January 3, 2025
# R version: 4.4.1
# Purpose: 2020 vintage Health Reporting Area (HRA) shapefile

# Set up ----
rm(list = ls())
Sys.setenv(TZ='America/Los_Angeles') # set time zone
options(scipen=999) # disable scientific notation
library(sf)
library(dplyr)

# Get shapefile ----
shapeHRA20 <- st_read("//dphcifs/APDE-CDIP/Shapefiles/HRA/hra_2020_nowater.shp")
shapeHRA20 <- shapeHRA20 |> select(HRA20 = name)

# Export to the data directory
usethis::use_data(shapeHRA20, overwrite = TRUE)
