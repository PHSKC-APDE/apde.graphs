# Header ----
# Author: Danny Colombara
# Date: January 6, 2025
# R version: 4.4.1
# Purpose: Create sample of King County residential parcel coordinates

# Set up ----
library(sf)
library(dplyr)

# Get shapefiles & sample 1/20 of rows ----
set.seed(98104)
shapeParcels <- kcparcelpop::pcoords |>
  sample_frac(.05) |> # sampled 5% in consideration of file size
  mutate(ParcelID = row_number()) |>
  select(ParcelID) |>
  st_transform(2926) # EPSG code for NAD83(HARN) / Washington North
row.names(shapeParcels) <- NULL # drop original row names

# Export to the data directory
usethis::use_data(shapeParcels, overwrite = TRUE)

