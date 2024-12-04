# apde_caption ----
#' Add a standard APDE caption to ggplot2 objects
#'
#' @param data_source Description of data source
#' @param division Division name
#'
#' @examples
#' \dontrun{
#' # Add caption to plot
#' ggplot(pressure, aes(temperature, pressure)) +
#'   geom_point() +
#'   apde_caption("Physical measurement data")
#' }
#'
#' @import ggplot2
#'
#' @return A ggplot2 labs object
#' @export
apde_caption <- function(data_source = "XYZ dataset",
                         division = "Health Sciences, APDE") {
  # Check if inputs are character strings
  if (!is.character(data_source) || length(data_source) != 1) {
    stop("`data_source` must be a single character string")
  }
  if (!is.character(division) || length(division) != 1) {
    stop("`division` must be a single character string")
  }

  # Create and return caption
  labs(caption = paste0(
    division, ": ",
    format(Sys.Date(), "%B %d, %Y"),
    "\nData source: ", data_source
  ))
}

# rotate_x_labels ----
#' Rotate x-axis labels for better readability
#'
#' @param angle Rotation angle in degrees (0-360)
#' @param hjust Horizontal justification (0-1)
#'
#' @examples
#' \dontrun{
#' # Rotate x-axis labels
#' ggplot(pressure, aes(factor(temperature), pressure)) +
#'   geom_col() +
#'   rotate_x_labels()
#' }
#'
#' @import ggplot2
#'
#' @return A ggplot2 theme object
#' @export
rotate_x_labels <- function(angle = 45, hjust = 1) {
  # Check if angle is numeric and between 0 and 360
  if (!is.numeric(angle) || angle < 0 || angle > 360) {
    stop("`angle` must be a number between 0 and 360 degrees")
  }

  # Check if hjust is numeric and between 0 and 1
  if (!is.numeric(hjust) || hjust < 0 || hjust > 1) {
    stop("`hjust` must be a number between 0 and 1")
  }

  # Return theme element
  theme(axis.text.x = element_text(angle = angle, hjust = hjust))
}


# theme_apde ----
#' APDE's standardized theme for ggplot2 visualizations
#'
#' @description
#' `theme_apde()` implements APDE's standard visualization style, building on
#' ggplot2's theme_minimal().
#'
#' @param base_size Base font size in points. Defaults to \code{base_size = 12}
#' @param base_family Base font family. Defaults to \code{base_family = 'Arial'}.
#' If Arial is not available, it will default to the system sans serif default font.
#'
#' @examples
#' \dontrun{
#' # Apply APDE theme
#' ggplot(pressure, aes(temperature, pressure)) +
#'   geom_point() +
#'   theme_apde()
#' }
#'
#' @import ggplot2
#' @importFrom grDevices windowsFonts
#'
#' @return A ggplot2 theme object
#' @export
theme_apde <- function(base_size = 12,
                       base_family = 'Arial') {

  # Ensure base_size is numeric and positive
  if (!is.numeric(base_size) || base_size <= 0) {
    stop("\U1F6D1\n`base_size` must be a positive number")
  }

  # Ensure base_family is character
  if (!is.character(base_family)) {
    stop("\U1F6D1\n`base_family` must be a character string")
  }

  # Check if selected font exists, if not use the system sans font
    # Look for the requested font in the values of windowsFonts
    matches <- grep(base_family, grDevices::windowsFonts(), value = TRUE, ignore.case = TRUE)[1]

    # Find corresponding font family (sans/serif/mono, etc) ... if any
    matching_family <- setdiff(names(matches), NA)

    if (length(matching_family) == 1) {
      if(base_family != matching_family){
        message(paste0("'", base_family, "' mapped to the '", matches, "' font family"))
      }
      base_family <- matching_family # change to the name used by R
    } else {
      # No matches found - fall back to sans
      base_family <- "sans"
      warning(paste0("\n\U00026A0\nRequested font not found. Using system sans font (", grDevices::windowsFonts()$sans, ")"))
    }

  # Start with theme_minimal as our foundation because simplicity is bliss
  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      # == TITLE ELEMENTS ==
      # Main title: Large, bold, and centered for visual hierarchy
      plot.title = element_text(
        size = rel(1.3),        # 30% larger than base size for emphasis
        face = "bold",          # Bold weight for primary importance, can be 'plain', 'bold', 'italic', 'bold.italic'
        hjust = 0.5,            # Centered alignment (can be 0 = left, 0.5 = center, 1 = right)
        color = "black",        # Font color can be name ('black') or hex ('#000000')
        margin = margin(b = 10) # Add space below title
      ),

      # Subtitle: Regular weight, centered, smaller than title
      plot.subtitle = element_text(
        size = rel(1),          # Same as base size
        face = "plain",         # Regular weight to differentiate from title
        hjust = 0.5,            # Centered alignment matching title
        margin = margin(b = 10)
      ),

      # == AXIS ELEMENTS ==
      # Axis titles: Bold but not as large as main title
      axis.title = element_text(
        size = rel(1),          # Same as base size
        face = "bold",          # Bold for secondary hierarchy
        margin = margin(t = 10, b = 10) # Spacing for readability
      ),

      # Axis text: Slightly smaller than base size
      axis.text = element_text(
        size = rel(0.8)         # 80% of base size
      ),

      # == GRID ELEMENTS ==
      # Remove unnecessary grid elements to reduce visual noise
      panel.grid.major.x = element_blank(),    # No vertical grid
      panel.grid.minor = element_blank(),      # No minor grid lines

      # == LEGEND ELEMENTS ==
      # Legend title: Bold for hierarchy
      legend.title = element_text(
        size = rel(1),          # Same as base size
        face = "bold",          # Bold for emphasis
        color = "black"         # Consistent font color
      ),

      # Legend text: Slightly smaller
      legend.text = element_text(
        size = rel(0.8)         # 80% of base size
      ),
      legend.position = "right", # can be 'top', 'bottom', 'left', or 'right'

      # == CAPTION ELEMENTS ==
      # Caption: Notably smaller than other text
      plot.caption = element_text(
        size = rel(0.6),         # 60% of base size
        hjust = 0,               # Left-aligned
        margin = margin(t = 10)  # Space above caption
      ),

      # == MARGINS ==
      # Consistent margins around entire plot
      plot.margin = margin(1, 1, 1, 1, "cm")
    )
}



