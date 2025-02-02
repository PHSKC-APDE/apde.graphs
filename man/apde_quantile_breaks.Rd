% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/graphing_helpers.R
\name{apde_quantile_breaks}
\alias{apde_quantile_breaks}
\title{Generate Data-Driven Breaks Using Quantiles}
\usage{
apde_quantile_breaks(data, n = 5)
}
\arguments{
\item{data}{Numeric vector of values from which to calculate breaks}

\item{n}{Integer specifying the desired number of breaks (default = 5)}
}
\value{
A numeric vector of integer break points based on data quantiles
}
\description{
\code{apde_quantile_breaks()} creates a sequence of integer breaks based on the quantiles
of the input data. The function is useful for both axis breaks and
legend breaks in ggplot2 visualizations.
}
\details{
The function calculates breaks based on the actual distribution of your data
using quantiles, rather than creating evenly spaced breaks like
\code{apde_linear_breaks()}. This approach ensures the breaks reflect where your
data actually clusters, making visualizations more informative when data is
not uniformly distributed. For example, if most of your data points fall
within a narrow range with some outliers, \code{apde_quantile_breaks()} will place
more breaks in the dense regions where they are most needed, while
\code{apde_linear_breaks()} would space them evenly across the full range.
}
\examples{
# Example 1: Comparing quantile-based breaks vs. evenly spaced breaks
# Create a right-skewed distribution
set.seed(123)
skewed_data <- c(rnorm(80, mean = 10, sd = 2),  # Most data clusters here
                 rnorm(20, mean = 50, sd = 5))   # Some outliers here
                 
# Compare the different approaches
quantile_breaks <- apde_quantile_breaks(skewed_data, n = 5)
linear_breaks <- apde_linear_breaks(skewed_data, n = 5)

print(paste("Quantile breaks follow the data distribution:", 
           paste(round(quantile_breaks), collapse = ', ')))
print(paste("Linear breaks are evenly spaced:", 
           paste(round(linear_breaks), collapse = ', ')))

# Example 2: Basic usage with ggplot2
library(ggplot2)

ggplot(lifespanDT_raw, aes(x = city, y = lifespan)) +
  geom_point(aes(color = lifespan), alpha = 0.5) +
  scale_color_continuous(
    breaks = apde_quantile_breaks(lifespanDT_raw$lifespan)
  ) +
  labs(title = "Distribution of Lifespans by City",
       color = "Age (years)")

}
\seealso{
\code{\link{apde_theme}} for the default APDE \code{ggplot2} theme
\code{\link{apde_linear_breaks}} for evenly distributed breaks
}
