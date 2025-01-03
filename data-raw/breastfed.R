# Header ----
# Author: Danny Colombara
# Date: January 2, 2025
# R version: 4.4.1
# Purpose: Create semi-synthetic breastfeeding status for CHI style
#          horizontal graphs

# Set up ----
rm(list = ls())
Sys.setenv(TZ='America/Los_Angeles') # set time zone
options(scipen=999) # disable scientific notation
library(rads)
library(data.table)

# Function to capitalize the first letter ----
capitalize_first <- function(string) {
  paste0(toupper(substr(string, 1, 1)), substr(string, 2, nchar(string)))
}

# Connect to CHI WIP server ----
wip <- odbc::dbConnect(odbc::odbc(),
                       Driver = "SQL Server",
                       Server = "KCITSQLUATHIP40",
                       Database = "PHExtractStore")

# Pull data fromn server ----
breastfedDT = setDT(DBI::dbGetQuery(wip,
                          "SELECT tab, indicator_key, year, cat1, cat1_group, cat1_varname,
                          result, lower_bound, upper_bound, significance, caution, suppression
                          FROM APDE_WIP.birth_results
                          WHERE indicator_key = 'breastfed' AND
                          tab IN ('demgroups', 'trends') AND
                          cat1 NOT LIKE '%detailed race%' AND
                          cat1 != 'Cities/neighborhoods'"))

# Tidy breastfed estimates ----
breastfedDT[, cat1 := gsub("Birthing person's ", "", cat1)]
breastfedDT[, cat1 := sapply(cat1, capitalize_first)]
breastfedDT[, .N, cat1]

breastfedDT <- breastfedDT[cat1_varname != 'race4']

breastfedDT[cat1_group == '45+', `:=` (suppression = '^', result = NA, lower_bound = NA, upper_bound = NA, caution = NA, significance = NA)]
breastfedDT[cat1_group == 'AIAN', caution := '!']

# Export to the data directory
usethis::use_data(breastfedDT, overwrite = TRUE)

