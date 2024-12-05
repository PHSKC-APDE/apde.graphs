# Bar Plots with Multiple Groups and Error Bars


This example demonstrates `ggplot2` code by building a bar plot
step-by-step. While you would typically write all components in a single
code block using `+` to connect elements, breaking it down helps
illustrate how each piece contributes to the final visualization.

## Load libraries

``` r
library(ggplot2)
library(apde.graphs)
library(data.table)
library(RColorBrewer)  # For colorblind-safe colors
library(scales) # to label axes with $, %, etc. 
```

## View available colorblind-safe palettes

``` r
display.brewer.all(colorblindFriendly = TRUE) 
```

![](bar_plot_groups_files/figure-commonmark/view_palettes-1.png)

## Generate synthetic data

Don’t worry about understanding this section of code. This is just to
create a dataset in order to demonstrate the graphing code.

``` r
set.seed(98104)

# Create base data
years <- c(1980, 1990, 2000, 2010, 2020)
flavors <- c("Vanilla", "Chocolate", "Other")

# Function to generate mean incomes with trend
generate_income <- function(years, base, slope) {
  base + (years - 1980) * slope + rnorm(length(years), 0, 500)
}

# Create table of years and flavors
dt <- CJ(year = years, flavor = flavors)
dt[, flavor := factor(flavor, levels = c("Chocolate", "Vanilla", "Other"))] # to ensure graph order

# Generate means and standard errors
dt[flavor == "Vanilla", mean_income := generate_income(year, base = 75000, slope = 50)]
dt[flavor == "Chocolate", mean_income := generate_income(year, base = 70000, slope = 200)]
dt[flavor == "Other", mean_income := generate_income(year, base = 65000, slope = 500)]

# Add standard errors (random sizes)
dt[, se := runif(15, 1500, 5000)]
```

Here is a peek at the data. Note that, in general, `ggplot2` works best
with data in long format.

``` r
head(dt)
```

| year | flavor    | mean_income |       se |
|-----:|:----------|------------:|---------:|
| 1980 | Chocolate |    69930.63 | 2341.681 |
| 1980 | Other     |    65656.23 | 2908.696 |
| 1980 | Vanilla   |    74969.05 | 2359.591 |
| 1990 | Chocolate |    71790.57 | 1953.702 |
| 1990 | Other     |    70696.61 | 1707.939 |
| 1990 | Vanilla   |    75431.89 | 2148.133 |

## Create the base `ggplot2` bar plot

``` r
ice_cream_plot <- ggplot(dt, aes(x = factor(year), 
                                 y = mean_income,
                                 fill = flavor)) +  # different color for each flavor
  # Basic bar plot
  geom_col(position = position_dodge(width = 0.8),  # adjust horizontally to show groups
           width = 0.7) +                           # adjust bar width
  
  # Add error bars with confidence intervals
  geom_errorbar(aes(ymin = mean_income - 1.96*se,   # lower bound CI
                    ymax = mean_income + 1.96*se),  # upper bound CI
                position = position_dodge(width = 0.8),
                linewidth = 1, # width of the error bar
                width = 0)     # width of the horizontal lines at the ends of the bar
```

## Add colors and scales

``` r
ice_cream_plot <- ice_cream_plot +
  # Custom colors using colorbrewer
  scale_fill_brewer(palette = "Dark2") +  # One of many colorblind-friendly palettes

  # Customize y-axis with dollar signs
  scale_y_continuous(
    limits = c(0, 100000),           # fix y-axis range
    breaks = seq(0, 100000, 10000),  # show tick marks every $10,000
    labels = scales::label_currency(prefix = '$')
  )
```

## Add labels

``` r
ice_cream_plot <- ice_cream_plot +
  labs(
    title = 'Mean Income by Ice Cream Preference',
    subtitle = 'Non-representative Sample of Megalopolis Residents',
    x = 'Year',
    y = 'Mean Income (2020 dollars)',
    caption = paste0('Health Sciences, APDE: ', format(Sys.Date(), '%B %d, %Y'),
                    '\nData source: Synthetic dataset')
  )
```

## Add APDE customizations

The `apde_caption()` and `theme_apde()` elements are from the
`apde.graphs` package, not `ggplot2`.

``` r
ice_cream_plot <- ice_cream_plot +
  
  apde_caption(data_source = 'Synthetic dataset') +
  
  theme_apde()
```

## Add horizontal reference line

``` r
ice_cream_plot <- ice_cream_plot +
  # Add reference line at overall mean
  geom_hline(yintercept = mean(dt$mean_income),
             linetype = 'dashed', # also 'solid', 'dashed', 'dotdash', 'longdash', and 'twodash'
             linewidth = 1,
             color = 'red') 
```

## Add annotations

``` r
ice_cream_plot <- ice_cream_plot +
  # Add explanatory text
  annotate(
    geom = 'text',
    x = 5,
    y = 95000,
    label = "Steepest increase\nfor 'Other' flavor",
    hjust = 1
  ) + 
  
  # Add arrow pointing to steepest increase
  annotate(
    geom = "segment",
    x = 4.9, xend = 5.1,
    y = 90000, yend = 85000,
    arrow = arrow(length = unit(0.2, "cm"))
  ) +
  
  # Add a box around the text
  annotate(
    geom = 'rect',        # highlight an area of your graph
    xmin = 4, xmax = 5.2, 
    ymin = 91000, ymax = 99000,
    alpha = 0.2,          # transparency (0 == most, 1 == least)
    fill = 'green',       # color of box 
    col = NA)             # color of box outline
```

## Display the plot

``` r
ice_cream_plot
```

![](bar_plot_groups_files/figure-commonmark/display_plot-1.png)

## Save the plot

`ggsave` automatically detects file type from filename extension (.jpg,
.png, .pdf, etc.)

``` r
ggsave(filename = 'income_by_ice_cream_preference.jpg', # filename with extension
       plot = ice_cream_plot,                           # plot to save
       width = 10,                                      # width in inches
       height = 6,                                      # height in inches
       dpi = 600)                                       # resolution in dots per inch
```

– *Updated by dcolombara, 2024-12-04*
