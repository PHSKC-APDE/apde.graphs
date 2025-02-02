% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{lifespanDT_agg}
\alias{lifespanDT_agg}
\title{Aggregated Lifespan Dataset for Ancient Cities}
\format{
A data.table with 8 rows and 2 columns:
\describe{
\item{city}{Factor. Names of ancient cities}
\item{mean_lifespan}{Numeric. Average lifespan for each city}
}
}
\source{
Created for demonstrating ggplot2 summary visualization techniques.
}
\usage{
data(lifespanDT_agg)
}
\description{
A synthetic aggregated dataset of mean lifespans across various ancient cities.
Derived from \code{lifespanDT_raw}.
}
\details{
The dataset is generated from individual-level synthetic lifespan data:
\itemize{
\item Mean lifespans reflect synthetic population distributions
\item Cities include: Athens, Babylon, Carthage, Pataliputra, Persepolis, Rome, Thebes, Xian
}
}
\examples{
head(apde.graphs::lifespanDT_agg)

}
\keyword{datasets}
