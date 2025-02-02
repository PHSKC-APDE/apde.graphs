% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{shapeRegions20}
\alias{shapeRegions20}
\title{King County Regions (2020)}
\format{
An sf (simple features) object containing region boundaries:
\describe{
\item{name}{Character. Region name}
\item{geometry}{sfc_MULTIPOLYGON. Spatial geometry defining region boundaries}
}
}
\source{
//dphcifs/APDE-CDIP/Shapefiles/Region/region_hra20_nowater.shp
}
\usage{
data(shapeRegions20)
}
\description{
A spatial dataset containing boundary polygons for Regions in King County,
using 2020 vintage boundaries.
}
\details{
Contains boundaries for all King County Regions, excluding water bodies.
}
\examples{
\dontrun{
# Basic plot of region boundaries
library(ggplot2)
library(sf)
ggplot(shapeRegions20) +
  geom_sf()
}

}
\keyword{datasets}
