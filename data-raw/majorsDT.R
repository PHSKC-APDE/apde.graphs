# Header ----
# Author: Danny Colombara
# Date: 2024-12-20
# R version: 4.4.1
# Purpose: Create synthetic data of life span in ancient cities for ggplot samples

# Set up ----
  options(scipen=999) # disable scientific notation
  library(data.table)
  library(stats)
  set.seed(98104) # necessary to get same 'random' results each time
  years <- 2016:2025

# Create base data ----
  majors <- c('Premed', 'Management', 'Communications', 'Comp Sci', 'Economics',
              'Education', 'Engineering', 'English', 'Ecology', 'Finance',
              'Kinesiology', 'Math', 'Nursing', 'Psychology')
  
  schools <- c(
    'Health Sciences', 'Business', 'Liberal Arts', 'Engineering', 'Business',
    'Liberal Arts', 'Engineering', 'Liberal Arts', 'Liberal Arts', 'Business',
    'Health Sciences', 'Liberal Arts', 'Health Sciences', 'Liberal Arts'
  )
  
  major_school <- data.table(major = majors, school = schools)


# Initialize base counts for top majors ----
  base_counts <- data.table(
    major = c('Engineering', 'Comp Sci', 'Psychology', 'Management', 'Nursing'),
    base_count = c(750, 700, 650, 500, 450)
  )

# Generate data for all years ----
  majorsDT <- rbindlist(lapply(years, function(year) {
    # Adjust top major counts with small random variations
    top_majors <- copy(base_counts)
    top_majors[, count := pmin(800, pmax(300, 
                                         base_count + round(rnorm(.N, mean = 0, sd = 20))))]
    
    # Generate Kinesiology with increasing trend
    kinesiology_count <- min(750, 
                             150 + round((year - 2015) * 75 + rnorm(1, mean = 0, sd = 15)))
    
    # Generate other major counts
    other_majors <- majors[!majors %in% top_majors$major & majors != "Kinesiology"]
    other_counts <- data.table(
      major = other_majors,
      count = round(runif(length(other_majors), 100, 300))
    )
    
    # Combine all majors
    year_data <- rbind(
      top_majors[, .(major, count)],
      data.table(major = "Kinesiology", count = kinesiology_count),
      other_counts
    )
    
    # Sort by count and take top 10
    year_data <- year_data[order(-count)][1:10]
    year_data[, ranking := 1:.N]
    
    # Add year
    year_data[, year := year]
    
    # Calculate rates and CIs
    year_data[, c("rate", "rate_lower", "rate_upper") := {
      bt <- binom.test(count, 10000)
      .(count/10000, bt$conf.int[1], bt$conf.int[2])
    }, by = .(major, year)]
    
    return(year_data)
  }))

# Merge on school ----
majorsDT <- merge(majorsDT, major_school, by = "major")

# Tidy data ----
setorder(majorsDT, year, ranking)
setcolorder(majorsDT, c('year', 'school', 'major', 'ranking'))
majorsDT[, c('rate', 'rate_lower', 'rate_upper') := lapply(.SD, round2, 3), .SDcols = c('rate', 'rate_lower', 'rate_upper')]

# Export to the data directory ----
usethis::use_data(majorsDT, overwrite = TRUE)

