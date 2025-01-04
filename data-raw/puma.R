# Header ----
# Author: Danny Colombara
# Date: January 3, 2025
# R version: 4.4.1
# Purpose: 2020 vintage Public Use Microdata Area shapefile

# Set up ----
rm(list = ls())
Sys.setenv(TZ='America/Los_Angeles') # set time zone
options(scipen=999) # disable scientific notation
library(sf)
library(dplyr)

# Get shapefile ----
shapePUMA20 <- st_read("//dphcifs/APDE-CDIP/Shapefiles/Census_2020/puma/kc_puma.shp")
shapePUMA20 <- shapePUMA20 |> select(PUMACE20) |> filter(PUMACE20 %in% 23301:23318)

# Export to the data directory
usethis::use_data(shapePUMA20, overwrite = TRUE)

