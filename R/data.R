# icecreamDT ----
#' Synthetic Income by Ice Cream Flavor Preferences Dataset
#'
#' A synthetic dataset illustrating the relationship between income levels and
#' ice cream flavor preferences across different years. The data is designed to
#' demonstrate various ggplot2 visualization techniques, including trend analysis
#' and income-based comparisons.
#'
#' @format A data.table with 15 rows and 5 columns:
#' \describe{
#'   \item{year}{Numeric. Representative years from 1980 to 2020}
#'   \item{flavor}{Factor. Ice cream flavors (Chocolate, Vanilla, Other)}
#'   \item{mean_income}{Numeric. Synthetic mean income for each flavor and year}
#'   \item{se}{Numeric. Synthetic standard error for each data point}
#' }
#'
#' @details The dataset is synthetically generated with the following characteristics:
#' * Base incomes start at different levels for each flavor
#' * Incomes trend upward over time with different slopes
#' * Random noise added to simulate real-world variability
#' * Flavor factor levels are ordered: Chocolate, Vanilla, Other
#'
#' Income generation details:
#' * Vanilla: Base at $75,000, slight upward trend
#' * Chocolate: Base at $70,000, moderate upward trend
#' * Other: Base at $65,000, steeper upward trend
#'
#' @source Generated using synthetic data with seed 98104 for reproducibility.
#' Created specifically for demonstrating ggplot2 visualization techniques
#' including line plots, error bars, and trend analysis.
#'
#' @examples
#' # Basic line plot of mean income by flavor
#' library(ggplot2)
#' ggplot(icecreamDT, aes(x = year, y = mean_income, color = flavor)) +
#'   geom_line() +
#'   geom_errorbar(aes(ymin = mean_income - se, ymax = mean_income + se))
#'
#' # Calculate mean income by flavor
#' library(data.table)
#' icecreamDT[, .(avg_income = mean(mean_income)), by = flavor]
#'
#' @name icecreamDT
#' @usage data(icecreamDT)
#' @keywords datasets
"icecreamDT"

# lifespanDT_agg ----
#' Aggregated Lifespan Dataset for Ancient Cities
#'
#' A synthetic aggregated dataset of mean lifespans across various ancient cities.
#' Derived from the raw lifespan data, this dataset provides summary statistics
#' ideal for demonstrating summary visualizations in ggplot2.
#'
#' @format A data.table with 8 rows and 2 columns:
#' \describe{
#'   \item{city}{Factor. Names of ancient cities}
#'   \item{mean_lifespan}{Numeric. Average lifespan for each city}
#' }
#'
#' @details The dataset is generated from individual-level synthetic lifespan data:
#' * Aggregated from 1,000 individual records per city
#' * Mean lifespans reflect synthetic population distributions
#' * Cities include: Athens, Babylon, Carthage, Pataliputra, Persepolis, Rome, Thebes, Xian
#'
#' @source Generated using synthetic data with seed 98104 for reproducibility.
#' Created for demonstrating ggplot2 summary visualization techniques.
#'
#' @examples
#' # Bar plot of mean lifespans
#' library(ggplot2)
#' ggplot(lifespanDT_agg, aes(x = city, y = mean_lifespan)) +
#'   geom_col()
#'
#' @name lifespanDT_agg
#' @usage data(lifespanDT_agg)
#' @keywords datasets
"lifespanDT_agg"

# lifespanDT_raw ----
#' Synthetic Lifespan Dataset for Ancient Cities
#'
#' A synthetic raw dataset representing lifespans in various ancient cities.
#' The data is designed to demonstrate various ggplot2 visualization techniques.
#'
#' @format A data.table with 8,000 rows and 2 columns:
#' \describe{
#'   \item{city}{Factor. Names of ancient cities, ordered as: Athens, Babylon,
#'   Carthage, Pataliputra, Persepolis, Rome, Thebes, Xian}
#'   \item{lifespan}{Numeric. Individual lifespan measurements in years for each city}
#' }
#'
#' @details The dataset features synthetic lifespan data with the following characteristics:
#' * 1,000 individual lifespan records for each city
#' * Lifespans generated using normal distribution
#' * Mean lifespans randomly generated between 38 and 57 years
#' * Standard deviation of 5 years to simulate population variability
#'
#' @source Generated using synthetic data with seed 98104 for reproducibility.
#' Created specifically for demonstrating ggplot2 visualization techniques
#' including distribution plots, box plots, and comparative analyses.
#'
#' @examples
#' # Boxplot of lifespans by city
#' library(ggplot2)
#' ggplot(lifespanDT_raw, aes(x = city, y = lifespan)) +
#'   geom_boxplot() +
#'   theme(axis.text.x = element_text(angle = 45, hjust = 1))
#'
#' # Calculate summary statistics
#' library(data.table)
#' lifespanDT_raw[, .(mean_lifespan = mean(lifespan),
#'                  median_lifespan = median(lifespan)),
#'              by = city]
#'
#' @name lifespanDT_raw
#' @usage data(lifespanDT_raw)
#' @keywords datasets
"lifespanDT_raw"

# wisdomDT ----
#' Synthetic Wisdom Score Dataset
#'
#' A synthetic dataset demonstrating the relationship between age and wisdom scores
#' across two study groups. The data is designed to show different peak wisdom ages
#' for each group, with Group 1 peaking around age 40 and Group 2 around age 50.
#' This dataset is used for demonstrating ggplot2 visualization techniques.
#'
#' @format A data.table with 1,000 rows and 3 columns:
#' \describe{
#'   \item{age}{Numeric. Uniformly distributed ages between 10 and 70 years}
#'   \item{group}{Factor. Study group identifier ("Group 1" or "Group 2")}
#'   \item{wisdom}{Numeric. Synthetic wisdom scores generated using a normal
#'   distribution curve with different parameters for each group. Base score of 20
#'   plus up to 60 points following a normal distribution, with added random noise}
#' }
#'
#' @details The wisdom scores are generated using different normal distribution
#' parameters for each group:
#' * Group 1: Peak wisdom around age 40 with standard deviation of 25
#' * Group 2: Peak wisdom around age 50 with standard deviation of 20
#' Random noise (normal distribution with mean 0 and SD 0.2) is added to create
#' more realistic variation.
#'
#' @source Generated using synthetic data with seed 98104 for reproducibility.
#' Created specifically for demonstrating ggplot2 visualization techniques
#' including scatter plots, smoothed trend lines, and various plot customizations.
#'
#' @examples
#' # Basic scatter plot of wisdom by age
#' library(ggplot2)
#' ggplot(wisdomDT, aes(x = age, y = wisdom, color = group)) +
#'   geom_point(alpha = 0.3)
#'
#' # Calculate mean wisdom by group
#' library(data.table)
#' wisdomDT[, .(mean_wisdom = mean(wisdom)), by = group]
#'
#' @name wisdomDT
#' @usage data(wisdomDT)
#' @keywords datasets
"wisdomDT"

