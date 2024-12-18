% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/graphing_helpers.R
\name{theme_apde}
\alias{theme_apde}
\title{APDE's standardized theme for ggplot2 visualizations}
\usage{
theme_apde(base_size = 12, base_family = "Arial")
}
\arguments{
\item{base_size}{Base font size in points. Defaults to \code{base_size = 12}}

\item{base_family}{Base font family. Defaults to \code{base_family = 'Arial'}.
If Arial is not available, it will default to the system sans serif default font.}
}
\value{
A ggplot2 theme object
}
\description{
\code{theme_apde()} implements APDE's standard visualization style, building on
ggplot2's theme_minimal().
}
\examples{
\dontrun{
# Apply APDE theme
ggplot(pressure, aes(temperature, pressure)) +
  geom_point() +
  theme_apde()
}

}
