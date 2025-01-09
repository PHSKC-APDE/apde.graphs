# Header ----
# Author: Danny Colombara
# Date: January 3, 2025
# R version: 4.4.1
# Purpose: 2022 ACS PUMS foreign born status by PUMAs for mapping guide

# Set up ----
rm(list = ls())
Sys.setenv(TZ='America/Los_Angeles') # set time zone
options(scipen=999) # disable scientific notation
library(rads)
library(data.table)

# Get data and estimates ----
pums <- rads::get_data_pums(year = 2022, kingco = T, records = 'person') # a survey object ready for rads::calc()

foreignbornDT <- calc(ph.data = pums,
                      what = 'forborn2', # binary indicator for foreign born status
                      metrics = 'mean',
                      by = 'puma')

foreignbornDT <- foreignbornDT[, .(year = 2022, PUMACE20 = puma, variable = 'Foreign Born', mean)]

# Export to the data directory
usethis::use_data(foreignbornDT, overwrite = TRUE)
