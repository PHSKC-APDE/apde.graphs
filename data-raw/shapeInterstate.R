# Header ----
# Author: Danny Colombara
# Date: January 6, 2025
# R version: 4.4.1
# Purpose: Create 2022 King County Interstate Highway linestring

# Set up ----
library(sf)
library(tigris)
library(dplyr)

# Get shapefiles ----
kc <- st_read('//Kcitfsrprpgdw01/kclib/Plibrary2/politicl/shapes/polygon/kingco.shp')

shapeInterstate <- tigris::primary_roads(year = 2022)

# Prep shapefiles ----
kc <- st_transform(kc, 2926) # EPSG code for NAD83(HARN) / Washington North

shapeInterstate <- shapeInterstate |>
  st_as_sf() |>
  st_transform(2926) |> # EPSG code for NAD83(HARN) / Washington North
  st_intersection(kc) |>
  select(Interstate = FULLNAME) |>
  filter(grepl('^I-', Interstate)) |>
  mutate(Interstate = if_else(Interstate == 'I- 5 Expy', 'I- 5', Interstate))

# Export to the data directory
usethis::use_data(shapeInterstate, overwrite = TRUE)

