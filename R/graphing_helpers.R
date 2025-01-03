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
#' \dontrun{
#' # Add basic caption
#' ggplot(pressure, aes(temperature, pressure)) +
#'   geom_point() +
#'   apde_caption("Physical measurement data")
#'
#' # Add multi-line additional text
#' ggplot(pressure, aes(temperature, pressure)) +
#'   geom_point() +
#'   apde_caption("Physical measurement data",
#'                additional_text = c("Note 1: Data excludes outliers\n",
#'                                  "Note 2: Sample sizes vary\n"))
#' }
#'
#' @import ggplot2
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
#' \dontrun{
#' # Default 45-degree rotation
#' ggplot(pressure, aes(factor(temperature), pressure)) +
#'   geom_col() +
#'   apde_rotate_xlab()
#'
#' # Custom angle and justification
#' ggplot(pressure, aes(factor(temperature), pressure)) +
#'   geom_col() +
#'   apde_rotate_xlab(angle = 90, hjust = 0.5)
#' }
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
#' \dontrun{
#' # Basic usage
#' ggplot(pressure, aes(temperature, pressure)) +
#'   geom_point() +
#'   apde_theme()
#'
#' # Custom base size
#' ggplot(pressure, aes(temperature, pressure)) +
#'   geom_point() +
#'   apde_theme(base_size = 14)
#' }
#'
#' @import ggplot2
#' @importFrom grDevices windowsFonts
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
      message(paste0("'", base_family, "' mapped to the '", matches, "' font family"))
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
      plot.margin = margin(1, 1, 1, 1, "cm"),
      panel.spacing = unit(0, "lines"),
      strip.placement = "outside",
      strip.background = element_blank(),
      strip.text = element_text(face = "bold", size = rel(1))
    )
}
