# apde_caption() ----
#' Add a standard APDE caption to ggplot2 objects
#'
#' @param data_source Description of data source
#' @param division Division name
#' @param additional_text Optional text to appear before standard caption. Can be a single string or vector of strings
#'
#' @details
#' Creates a standardized caption including division name, current date, and data source.
#' Multiple lines of additional text will be combined with no line breaks.
#'
#' @examples
#' library(ggplot2)
#' # Add basic caption
#' ggplot(wisdomDT, aes(age, wisdom_score)) +
#'   geom_point() +
#'   apde_caption("Synthetic Wisdom Data")
#'
#' # Add multi-line additional text
#' ggplot(wisdomDT, aes(age, wisdom_score)) +
#'   geom_point() +
#'   apde_caption("Synthetic Wisdom Data",
#'                additional_text = c("Blah blah blah\n",
#'                                    "etc. etc. etc.\n"))
#'
#' @import ggplot2
#' @importFrom grDevices windowsFonts
#' 
#' @return A ggplot2 labs object containing a caption with division name, date, and data source
#' @export
apde_caption <- function(data_source = "XYZ dataset",
                         division = "Health Sciences, APDE",
                         additional_text = NULL) {
  if (!is.character(data_source) || length(data_source) != 1) {
    stop("`data_source` must be a single character string")
  }
  if (!is.character(division) || length(division) != 1) {
    stop("`division` must be a single character string")
  }
  if (!is.null(additional_text) && !is.character(additional_text)) {
    stop("`additional_text` must be NULL or a character vector")
  }

  caption <- paste0(
    if (!is.null(additional_text)) paste(additional_text, collapse = "") else "",
    division, ": ",
    format(Sys.Date(), "%B %d, %Y"),
    "\nData source: ", data_source
  )

  labs(caption = caption)
}

# apde_linear_breaks() ----
#' Generate Evenly Spaced Integer Breaks
#'
#' @description
#' `apde_linear_breaks()` creates a sequence of integer breaks evenly spaced between
#' the minimum and maximum values of the input data. The function is useful for both
#' axis breaks and legend breaks in ggplot2 visualizations.
#'
#' @param data Numeric vector of values from which to calculate breaks
#' @param n Integer specifying the desired number of breaks (default = 5)
#'
#' @details
#' The function creates breaks by dividing the range between the minimum and maximum
#' values into equal intervals. This approach differs from `apde_quantile_breaks()`,
#' which creates breaks based on the data distribution. Use this function when you
#' want breaks to be evenly spaced regardless of how the data is distributed.
#'
#' @source Ron Buie's legend_breaker() function
#'
#' @return
#' A numeric vector of integer break points evenly spaced between the data's minimum
#' and maximum values
#'
#' @examples
#' # Example 1: Compare linear breaks vs. quantile breaks
#' # Create a right-skewed distribution
#' set.seed(123)
#' skewed_data <- c(rnorm(80, mean = 10, sd = 2),  # Most data clusters here
#'                  rnorm(20, mean = 50, sd = 5))   # Some outliers here
#'                  
#' # Compare the different approaches
#' linear_breaks <- apde_linear_breaks(skewed_data, n = 5)
#' quantile_breaks <- apde_quantile_breaks(skewed_data, n = 5)
#' 
#' print(paste("Linear breaks are evenly spaced:", 
#'            paste(round(linear_breaks), collapse = ', ')))
#' print(paste("Quantile breaks follow the data distribution:", 
#'            paste(round(quantile_breaks), collapse = ', ')))
#'
#' # Example 2: Basic usage with ggplot2
#' library(ggplot2)
#' 
#' ggplot(lifespanDT_raw, aes(x = city, y = lifespan)) +
#'   geom_point(aes(color = lifespan), alpha = 0.5) +
#'   scale_color_continuous(
#'     breaks = apde_linear_breaks(lifespanDT_raw$lifespan)
#'   ) +
#'   labs(title = "Distribution of Lifespans by City",
#'        color = "Age (years)")
#'        
#' @seealso 
#' \code{\link{apde_quantile_breaks}} for breaks based on data distribution
#' 
#' @export
apde_linear_breaks <- function(data, n = 5) {
  # Input validation
  if (!is.numeric(data)) {
    stop("`data` must be a numeric vector")
  }
  if (!is.numeric(n) || n < 2) {
    stop("`n` must be a numeric value >= 2")
  }
  
  # Calculate range
  bottom <- ceiling(min(data))
  top <- floor(max(data))
  
  # Generate evenly spaced breaks
  breaks <- quantile(bottom:top, probs = seq(0, 1, length.out = n))
  
  return(as.integer(breaks))
}

# apde_quantile_breaks() ----
#' Generate Data-Driven Breaks Using Quantiles
#'
#' @description
#' `apde_quantile_breaks()` creates a sequence of integer breaks based on the quantiles
#' of the input data. The function is useful for both axis breaks and
#' legend breaks in ggplot2 visualizations.
#'
#' @param data Numeric vector of values from which to calculate breaks
#' @param n Integer specifying the desired number of breaks (default = 5)
#'
#' @details
#' The function calculates breaks based on the actual distribution of your data
#' using quantiles, rather than creating evenly spaced breaks like 
#' `apde_linear_breaks()`. This approach ensures the breaks reflect where your 
#' data actually clusters, making visualizations more informative when data is 
#' not uniformly distributed. For example, if most of your data points fall 
#' within a narrow range with some outliers, `apde_quantile_breaks()` will place 
#' more breaks in the dense regions where they are most needed, while 
#' `apde_linear_breaks()` would space them evenly across the full range.
#'
#' @return
#' A numeric vector of integer break points based on data quantiles
#'
#' @examples
#' # Example 1: Comparing quantile-based breaks vs. evenly spaced breaks
#' # Create a right-skewed distribution
#' set.seed(123)
#' skewed_data <- c(rnorm(80, mean = 10, sd = 2),  # Most data clusters here
#'                  rnorm(20, mean = 50, sd = 5))   # Some outliers here
#'                  
#' # Compare the different approaches
#' quantile_breaks <- apde_quantile_breaks(skewed_data, n = 5)
#' linear_breaks <- apde_linear_breaks(skewed_data, n = 5)
#' 
#' print(paste("Quantile breaks follow the data distribution:", 
#'            paste(round(quantile_breaks), collapse = ', ')))
#' print(paste("Linear breaks are evenly spaced:", 
#'            paste(round(linear_breaks), collapse = ', ')))
#'
#' # Example 2: Basic usage with ggplot2
#' library(ggplot2)
#' 
#' ggplot(lifespanDT_raw, aes(x = city, y = lifespan)) +
#'   geom_point(aes(color = lifespan), alpha = 0.5) +
#'   scale_color_continuous(
#'     breaks = apde_quantile_breaks(lifespanDT_raw$lifespan)
#'   ) +
#'   labs(title = "Distribution of Lifespans by City",
#'        color = "Age (years)")
#'
#' @seealso 
#' \code{\link{apde_theme}} for the default APDE `ggplot2` theme
#' \code{\link{apde_linear_breaks}} for evenly distributed breaks
#' 
#' @importFrom stats quantile
#' @export
apde_quantile_breaks <- function(data, n = 5) {
  # Input validation
  if (!is.numeric(data)) {
    stop("`data` must be a numeric vector")
  }
  if (!is.numeric(n) || n < 2) {
    stop("`n` must be a numeric value >= 2")
  }
  
  # Calculate n evenly spaced probabilities from 0 to 1
  probs <- seq(0, 1, length.out = n)
  
  # Calculate quantiles and convert to integers
  # We use type = 7 for consistency with R's default quantile type
  breaks <- quantile(data, probs = probs, type = 7)
  return(as.integer(breaks))
}

# apde_rotate_xlab() ----
#' Rotate x-axis labels for better readability
#'
#' @description
#' Modifies the theme to rotate x-axis labels by a specified angle, improving readability
#' for long labels or crowded axes.
#'
#' @param angle Rotation angle in degrees (0-360)
#' @param hjust Horizontal justification (0-1)
#'
#' @examples
#' library(ggplot2)
#' 
#' # Default 45-degree rotation
#' ggplot(lifespanDT_agg, aes(city, mean_lifespan)) +
#'   geom_col() +
#'   apde_rotate_xlab()
#'
#' # Custom angle and justification
#' ggplot(lifespanDT_agg, aes(city, mean_lifespan)) +
#'   geom_col() +
#'   apde_rotate_xlab(angle = 90, hjust = 0.5)
#'
#' @import ggplot2
#'
#' @return A ggplot2 theme object modifying only the x-axis text angle and justification
#' @seealso \code{\link{apde_theme}} for the complete APDE theme
#' @export
apde_rotate_xlab <- function(angle = 45, hjust = 1) {
  if (!is.numeric(angle) || angle < 0 || angle > 360) {
    stop("`angle` must be a number between 0 and 360 degrees")
  }
  if (!is.numeric(hjust) || hjust < 0 || hjust > 1) {
    stop("`hjust` must be a number between 0 and 1")
  }

  theme(axis.text.x = element_text(angle = angle, hjust = hjust))
}

# apde_theme() ----
#' APDE's standardized theme for ggplot2 visualizations
#'
#' @description
#' `apde_theme()` implements APDE's standard visualization style, building on
#' ggplot2's theme_minimal().
#'
#' @param base_size Base font size in points
#' @param base_family Base font family. If specified font is unavailable, defaults to system sans serif font
#'
#' @details
#' Key theme modifications include:
#' * Centered, bold titles with increased size
#' * No vertical grid lines and no minor grid lines
#' * Bold axis titles with consistent margins
#' * Reduced text size for axis labels and captions
#' * Right-aligned legend with bold title
#' * Minimal panel spacing for faceted plots
#'
#' @examples
#' library(ggplot2)
#' 
#' # Basic usage
#' ggplot(wisdomDT, aes(age, wisdom_score)) +
#'   geom_point() +
#'   apde_theme()
#'
#' # Custom base size
#' ggplot(wisdomDT, aes(age, wisdom_score)) +
#'   geom_point() +
#'   apde_theme(base_size = 14)
#'
#' @import ggplot2
#'
#' @return A complete ggplot2 theme based on theme_minimal with APDE-specific modifications
#' @seealso \code{\link{apde_caption}}, \code{\link{apde_rotate_xlab}}
#' @export
apde_theme <- function(base_size = 12,
                       base_family = 'Arial') {
  if (!is.numeric(base_size) || base_size <= 0) {
    stop("\U1F6D1\n`base_size` must be a positive number")
  }
  if (!is.character(base_family)) {
    stop("\U1F6D1\n`base_family` must be a character string")
  }

  matches <- grep(base_family, grDevices::windowsFonts(), value = TRUE, ignore.case = TRUE)[1]
  matching_family <- setdiff(names(matches), NA)

  if (length(matching_family) == 1) {
    if(base_family != matching_family){
    }
    base_family <- matching_family
  } else {
    base_family <- "sans"
    warning(paste0("\n\U00026A0\nRequested font not found. Using system sans font (", grDevices::windowsFonts()$sans, ")"))
  }

  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      plot.title = element_text(
        size = rel(1.3),
        face = "bold",
        hjust = 0.5,
        color = "black",
        margin = margin(b = 10)
      ),
      plot.subtitle = element_text(
        size = rel(1),
        face = "plain",
        hjust = 0.5,
        margin = margin(b = 10)
      ),
      axis.title = element_text(
        size = rel(1),
        face = "bold",
        margin = margin(t = 10, b = 10)
      ),
      axis.text = element_text(
        size = rel(0.8)
      ),
      panel.grid.major.x = element_blank(),
      panel.grid.minor = element_blank(),
      legend.title = element_text(
        size = rel(1),
        face = "bold",
        color = "black"
      ),
      legend.text = element_text(
        size = rel(0.8)
      ),
      legend.position = "right",
      plot.caption = element_text(
        size = rel(0.6),
        hjust = 0,
        margin = margin(t = 10)
      ),
      plot.margin = margin(t = 1, r = 1, b = 1, l = 1, "cm"),
      panel.spacing = unit(0, "lines"),
      strip.placement = "outside",
      strip.background = element_blank(),
      strip.text = element_text(face = "bold", size = rel(1))
    )
}
