# breastfedDT ----
#' Semi-synthetic Breastfeeding Initiation Dataset
#'
#' A dataset containing breastfeeding initiation rates by demographic groups, formatted
#' for Community Health Indicators (CHI) style visualizations.
#'
#' @format A data.table with demographic categories and associated statistics:
#' \describe{
#'   \item{tab}{Character. Type of data (i.e., 'demgroups' or 'trends')}
#'   \item{indicator_key}{Character. Indicator name ("breastfed")}
#'   \item{year}{Numeric. Year of measurement}
#'   \item{cat1}{Factor. Main demographic category (e.g., "Race", "Age", "Education")}
#'   \item{cat1_group}{Factor. Subcategory within cat1}
#'   \item{cat1_varname}{Character. Variable name for the category}
#'   \item{result}{Numeric. Proportion who initiated breastfeeding}
#'   \item{lower_bound}{Numeric. Lower bound of 95% confidence interval}
#'   \item{upper_bound}{Numeric. Upper bound of 95% confidence interval}
#'   \item{significance}{Character. "*" if significantly different from King County average}
#'   \item{caution}{Character. "!" if estimate is imprecise due to small sample size}
#'   \item{suppression}{Character. "^" if data suppressed for confidentiality}
#' }
#'
#' @details The dataset includes:
#' * Results suppressed for age group 45+
#' * Caution flag for AIAN (American Indian/Alaska Native) estimates
#' * Detailed race categories excluded
#' * Cities/neighborhoods excluded
#'
#' @source Based on PHExtractStore.APDE_WIP.birth_results with minor modifications
#'
#' @examples
#' head(apde.graphs::breastfedDT)
#'
#' @name breastfedDT
#' @usage data(breastfedDT)
#' @keywords datasets
"breastfedDT"

# foreignbornDT ----
#' Foreign Born Population by PUMA
#'
#' A dataset containing the proportion of foreign-born residents by Public Use
#' Microdata Area (PUMA) in King County, based on 2022 American Community Survey
#' PUMS data.
#'
#' @format A data.table with foreign-born population estimates:
#' \describe{
#'   \item{year}{Numeric. Year of the estimate (2022)}
#'   \item{PUMACE20}{Numeric. PUMA identifier code}
#'   \item{variable}{Character. Always "Foreign Born"}
#'   \item{mean}{Numeric. Proportion of foreign-born residents}
#' }
#'
#' @details Dataset created using rads::calc() on ACS PUMS data.
#' Includes all King County PUMAs (codes 23301-23318).
#'
#' @source 2022 American Community Survey Public Use Microdata Sample (PUMS)
#'
#' @examples
#' head(apde.graphs::foreignbornDT)
#'
#' @name foreignbornDT
#' @usage data(foreignbornDT)
#' @keywords datasets
"foreignbornDT"

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
#' @source Generated using synthetic data.
#' Created specifically for demonstrating ggplot2 visualization techniques
#' including line plots, error bars, and trend analysis.
#'
#' @examples
#' head(apde.graphs::icecreamDT)
#'
#' @name icecreamDT
#' @usage data(icecreamDT)
#' @keywords datasets
"icecreamDT"

# lifespanDT_agg ----
#' Aggregated Lifespan Dataset for Ancient Cities
#'
#' A synthetic aggregated dataset of mean lifespans across various ancient cities.
#' Derived from `lifespanDT_raw`.
#'
#' @format A data.table with 8 rows and 2 columns:
#' \describe{
#'   \item{city}{Factor. Names of ancient cities}
#'   \item{mean_lifespan}{Numeric. Average lifespan for each city}
#' }
#'
#' @details The dataset is generated from individual-level synthetic lifespan data:
#' * Mean lifespans reflect synthetic population distributions
#' * Cities include: Athens, Babylon, Carthage, Pataliputra, Persepolis, Rome, Thebes, Xian
#'
#' @source Created for demonstrating ggplot2 summary visualization techniques.
#'
#' @examples
#' head(apde.graphs::lifespanDT_agg)
#'
#' @name lifespanDT_agg
#' @usage data(lifespanDT_agg)
#' @keywords datasets
"lifespanDT_agg"

# lifespanDT_raw ----
#' Synthetic Lifespan Dataset for Ancient Cities
#'
#' A synthetic raw dataset representing lifespans in various ancient cities,
#' including sex-specific variation.
#'
#' @format A data.table with 8,000 rows and 4 columns:
#' \describe{
#'   \item{city}{Factor. Names of ancient cities, ordered as: Athens, Babylon,
#'   Carthage, Pataliputra, Persepolis, Rome, Thebes, Xian}
#'   \item{sex}{Factor. Biological sex, ordered as: Female, Male}
#'   \item{region}{Factor. World Region, ordered as: Mediterranean, Middle East,
#'    & Other}
#'   \item{lifespan}{Numeric. Individual lifespan measurements in years for each city}
#' }
#'
#' @details The dataset features synthetic lifespan data with the following characteristics:
#' * 1,000 individual lifespan records for each city (500 per sex)
#' * Mean lifespans randomly generated between 38 and 57 years
#' * Female lifespans are on average 8 years higher than male lifespans (±4 years SD)
#'
#' @source
#' Created specifically for demonstrating ggplot2 visualization techniques
#' including distribution plots, box plots, and comparative analyses.
#'
#' @examples
#' head(apde.graphs::lifespanDT_raw)
#'
#' @name lifespanDT_raw
#' @usage data(lifespanDT_raw)
#' @keywords datasets
"lifespanDT_raw"

# shapeBigCities ----
#' King County Major Cities Shapefile
#'
#' A spatial dataset containing boundary polygons for major cities in King County.
#' The data is derived from 2020 Census shapefiles.
#'
#' @format An sf (simple features) object containing city boundaries:
#' \describe{
#'   \item{NAME}{Character. Name of the city}
#'   \item{geometry}{sfc_MULTIPOLYGON. Spatial geometry defining city boundaries}
#' }
#'
#' @details The dataset includes boundaries for eight major King County cities:
#' * Auburn
#' * Bellevue
#' * Federal Way
#' * Kent
#' * Kirkland
#' * Redmond
#' * Renton
#' * Seattle
#'
#' @source Census 2020 shapefiles, accessed from APDE-CDIP/Shapefiles
#'
#' @examples
#' \dontrun{
#' # Basic plot of city boundaries
#' library(ggplot2)
#' library(sf)
#' ggplot(shapeBigCities) +
#'   geom_sf()
#' }
#'
#' @name shapeBigCities
#' @usage data(shapeBigCities)
#' @keywords datasets
"shapeBigCities"

# shapeBigCities_centroids ----
#' King County Major Cities Centroids
#'
#' A spatial dataset containing centroid points for major cities in King County.
#' Derived from shapeBigCities.
#'
#' @format An sf (simple features) object containing city centroids:
#' \describe{
#'   \item{NAME}{Character. Name of the city}
#'   \item{geometry}{sfc_POINT. Spatial geometry defining city centroids}
#' }
#'
#' @details Centroids are calculated from shapeBigCities using st_centroid().
#' Includes the same eight major King County cities.
#'
#' @source Derived from shapeBigCities using sf::st_centroid()
#'
#' @examples
#' \dontrun{
#' # Plot city boundaries with centroid points
#' library(ggplot2)
#' library(sf)
#' ggplot() +
#'   geom_sf(data = shapeBigCities) +
#'   geom_sf(data = shapeBigCities_centroids, color = "red")
#' }
#'
#' @name shapeBigCities_centroids
#' @usage data(shapeBigCities_centroids)
#' @keywords datasets
"shapeBigCities_centroids"

# shapeHRA20 ----
#' King County Health Reporting Areas (2020)
#'
#' A spatial dataset containing boundary polygons for Health Reporting Areas (HRAs)
#' in King County, using 2020 vintage boundaries. Large water bodies are excluded.
#'
#' @format An sf (simple features) object containing HRA boundaries:
#' \describe{
#'   \item{HRA20}{Character. HRA name}
#'   \item{geometry}{sfc_MULTIPOLYGON. Spatial geometry defining HRA boundaries}
#' }
#'
#' @details Contains boundaries for all King County Health Reporting Areas,
#' excluding water bodies.
#'
#' @source APDE-CDIP/Shapefiles/HRA/hra_2020_nowater.shp
#'
#' @examples
#' \dontrun{
#' # Basic plot of HRA boundaries
#' library(ggplot2)
#' library(sf)
#' ggplot(shapeHRA20) +
#'   geom_sf()
#' }
#'
#' @name shapeHRA20
#' @usage data(shapeHRA20)
#' @keywords datasets
"shapeHRA20"

# shapeInterstate ----
#' Interstate Highways in King County
#'
#' A spatial dataset containing linestrings for interstate highways crossing
#' through King County.
#'
#' @format An sf (simple features) object containing interstate highways:
#' \describe{
#'   \item{Interstate}{Character. Highway name}
#'   \item{geometry}{sfc_LINESTRING. Spatial geometry defining interstate highways}
#' }
#'
#' @details Contains I-5, I-90, and I-405
#'
#' @source tigris::primary_roads(year = 2022)
#'
#' @examples
#' \dontrun{
#' # Basic plot interstate highways
#' library(ggplot2)
#' library(sf)
#' ggplot(shapeInterstate) +
#'   geom_sf()
#' }
#'
#' @name shapeInterstate
#' @usage data(shapeInterstate)
#' @keywords datasets
"shapeInterstate"

# shapeKC ----
#' King County shapefile
#'
#' A spatial dataset containing boundary polygons for King County. Large water
#' bodies are excluded.
#'
#' @format An sf (simple features) object containing interstate highways:
#' \describe{
#'   \item{County}{Character. 'King'}
#'   \item{geometry}{sfc_MULTIPOLYGON. Spatial geometry defining King County}
#' }
#'
#' @source //dphcifs/APDE-CDIP/Shapefiles/Region/region_hra20_nowater.shp
#'
#' @examples
#' \dontrun{
#' # Basic plot of King County boundaries
#' library(ggplot2)
#' library(sf)
#' ggplot(shapeKC) +
#'   geom_sf()
#' }
#'
#' @name shapeKC
#' @usage data(shapeKC)
#' @keywords datasets
"shapeKC"



# shapeMedicalCenters ----
#' King County Medical Centers
#'
#' A spatial dataset containing point locations for medical centers in King County.
#'
#' @format An sf (simple features) object containing medical center points:
#' \describe{
#'   \item{NAME}{Character. Name of the medical facility}
#'   \item{geometry}{sfc_POINT. Spatial geometry defining medical center locations}
#' }
#'
#' @details Contains locations for medical facilities across King County.
#'
#' @source //Kcitfsrprpgdw01/kclib/Plibrary2/pubsafe/shapes/point/medical_facilities.shp
#'
#' @examples
#' \dontrun{
#' # Basic plot of medical center locations
#' library(ggplot2)
#' library(sf)
#' ggplot() +
#'   geom_sf(data = shapeKC) +
#'   geom_sf(data = shapeMedicalCenters, color = "red")
#' }
#'
#' @name shapeMedicalCenters
#' @usage data(shapeMedicalCenters)
#' @keywords datasets
"shapeMedicalCenters"

# shapeParcels ----
#' Sample of King County Residential Parcel coordinates
#'
#' A spatial dataset containing points for a 1/20th sample of King County
#' residential parcel point coordinates. Sampled on 1/6/2025.
#'
#' @format An sf (simple features) object containing residential parcel points:
#' \describe{
#'   \item{ParcelID}{Numeric. Parece; ID}
#'   \item{geometry}{sfc_POINT. Spatial geometry defining the parcel}
#' }
#'
#' @source kcparcelpop::pcoords
#'
#' @examples
#' \dontrun{
#' # Basic plot of parcel coordinates
#' library(ggplot2)
#' library(sf)
#' ggplot() +
#'   geom_sf(data = shapeKC) +
#'   geom_sf(data = shapeParcels, color = "red")
#' }
#' 
#' @name shapeParcels
#' @usage data(shapeParcels)
#' @keywords datasets
"shapeParcels"

# shapePUMA20 ----
#' King County PUMAs (2020)
#'
#' A spatial dataset containing boundary polygons for Public Use Microdata Areas
#' (PUMAs) in King County, using 2020 Census definitions. Large water bodies are
#' excluded.
#'
#' @format An sf (simple features) object containing PUMA boundaries:
#' \describe{
#'   \item{PUMACE20}{Numeric. PUMA identifier code (23301-23318)}
#'   \item{geometry}{sfc_MULTIPOLYGON. Spatial geometry defining PUMA boundaries}
#' }
#'
#' @details Contains boundaries for all King County PUMAs (codes 23301-23318).
#'
#' @source Census 2020 shapefiles, accessed from APDE-CDIP/Shapefiles
#'
#' @examples
#' \dontrun{
#' # Basic plot of PUMA boundaries
#' library(ggplot2)
#' library(sf)
#' ggplot(shapePUMA20) +
#'   geom_sf()
#' }
#'
#' @name shapePUMA20
#' @usage data(shapePUMA20)
#' @keywords datasets
"shapePUMA20"

# shapeRegions20 ----
#' King County Regions (2020)
#'
#' A spatial dataset containing boundary polygons for Regions in King County,
#' using 2020 vintage boundaries.
#'
#' @format An sf (simple features) object containing region boundaries:
#' \describe{
#'   \item{name}{Character. Region name}
#'   \item{geometry}{sfc_MULTIPOLYGON. Spatial geometry defining region boundaries}
#' }
#'
#' @details Contains boundaries for all King County Regions, excluding water bodies.
#'
#' @source //dphcifs/APDE-CDIP/Shapefiles/Region/region_hra20_nowater.shp
#'
#' @examples
#' \dontrun{
#' # Basic plot of region boundaries
#' library(ggplot2)
#' library(sf)
#' ggplot(shapeRegions20) +
#'   geom_sf()
#' }
#'
#' @name shapeRegions20
#' @usage data(shapeRegions20)
#' @keywords datasets
"shapeRegions20"

# shapeTraumaHospitals ----
#' King County Acute Service (Trauma) Hospitals
#'
#' A spatial dataset containing point locations for trauma hospitals in King County.
#'
#' @format An sf (simple features) object containing hospital points:
#' \describe{
#'   \item{NAME}{Character. Name of the hospital}
#'   \item{geometry}{sfc_POINT. Spatial geometry defining hospital locations}
#' }
#'
#' @details Contains locations for acute service (trauma) hospitals in King County.
#'
#' @source //Kcitfsrprpgdw01/kclib/Plibrary2/pubsafe/shapes/point/hospitals.shp
#'
#' @examples
#' \dontrun{
#' # Basic plot of trauma hospital locations
#' library(ggplot2)
#' library(sf)
#' ggplot() +
#'   geom_sf(data = shapeKC) +
#'   geom_sf(data = shapeTraumaHospitals, color = "red")
#' }
#'
#' @name shapeTraumaHospitals
#' @usage data(shapeTraumaHospitals)
#' @keywords datasets
"shapeTraumaHospitals"

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
#' Random noise is added to create
#' more realistic variation.
#'
#' @source
#' Created specifically for demonstrating ggplot2 visualization techniques
#' including scatter plots, smoothed trend lines, and various plot customizations.
#'
#' @examples
#' head(apde.graphs::wisdomDT)
#'
#' @name wisdomDT
#' @usage data(wisdomDT)
#' @keywords datasets
"wisdomDT"

