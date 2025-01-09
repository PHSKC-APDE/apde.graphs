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

# Make cat1 factors for proper sorting ----
breastfedDT[, cat1 := factor(cat1,
                    levels = c("King County", "Age", "Race", "Ethnicity", "Race/ethnicity",
                               "Neighborhood poverty", "Education", "Regions",
                               "Big cities"))]

# Make cat1_group factors for proper sorting ----
custom_order <- c(
  # King County
  "King County",
  # Age
  "10-17", "18-24", "25-34", "35-44", "45+",
  # Race/Ethnicity
  "AIAN", "Asian", "Black", "Multiple", "NHPI", "White",
  # Ethnicity
  "Hispanic",
  # Neighborhood poverty
  "Low poverty areas", "Medium poverty areas", "High poverty areas", "Very high poverty areas",
  # Education
  "<= 8th grade", "9th-12th grade, no diploma", "High school graduate or GED",
  "Some college, no degree", "Associate degree", "Bachelor's degree",
  "Master's degree", "Doctorate or Professional degree",
  # Regions
  "North", "South", "East", "Seattle",
  # Big cities
  "Auburn city", "Bellevue city", "Federal Way city", "Kent city",
  "Kirkland city", "Redmond city", "Renton city", "Seattle city"
)

# need to reverse factor order so will display properly in ggplot after coord_flip
breastfedDT[, cat1_group := factor(cat1_group, levels = rev(custom_order))]

# Quick check if ordering is correct
setorder(breastfedDT[, .N, .(cat1, cat1_group)], cat1, cat1_group)[]

# Export to the data directory
usethis::use_data(breastfedDT, overwrite = TRUE)

