# Bar Plots with Highlighted Bars


This example demonstrates `ggplot2` code by building bar plots
step-by-step, ***showing two different approaches***: using
***pre-aggregated data*** and using ***raw data*** that needs to be
summarized. While you would typically write all components in a single
code block using `+` to connect elements, breaking it down helps
illustrate how each piece contributes to the final visualization.

## Load libraries

``` r
library(ggplot2)
library(data.table)
library(apde.graphs)
```

## Generate synthetic data

Don’t worry about understanding this section of code. This is just to
create a dataset in order to demonstrate the graphing code.

### Method 1: Pre-aggregated data

First, we’ll create a dataset where means are already calculated:

``` r
set.seed(98104)
dt_agg <- data.table(
  city = c("Athens", "Babylon", "Carthage", "Pataliputra", 
           "Persepolis", "Rome", "Thebes", "Xian"),
  mean_lifespan = round(runif(8, 38, 57), 1)
)

# Find highest value for highlighting
max_city <- dt_agg[which.max(mean_lifespan), city]
```

Here is a peek at the pre-aggregated data. Note that, in general,
`ggplot2` works best with data in long format.

``` r
head(dt_agg)
```

| city        | mean_lifespan |
|:------------|--------------:|
| Athens      |          47.0 |
| Babylon     |          56.8 |
| Carthage    |          46.5 |
| Pataliputra |          47.4 |
| Persepolis  |          40.0 |
| Rome        |          41.5 |

### Method 2: Raw data

Next, we’ll create a dataset with individual observations that need to
be averaged:

``` r
set.seed(98104)  
n_per_city <- 100  # number of observations per city

dt_raw <- data.table(
  city = rep(dt_agg$city, each = n_per_city)
)

# Add individual lifespans that will average to the same means as dt_agg
for(city_i in dt_agg$city) {
  city_mean <- dt_agg[city == city_i, mean_lifespan]
  dt_raw[city == city_i, 
         lifespan := rnorm(.N, mean = city_mean, sd = 5)]
}
```

Here is a peek at the raw data.

``` r
head(dt_raw)
```

| city   | lifespan |
|:-------|---------:|
| Athens | 46.69055 |
| Athens | 46.31890 |
| Athens | 40.76277 |
| Athens | 46.34195 |
| Athens | 50.97916 |
| Athens | 46.30633 |

## Create the base `ggplot2` bar plots

### Method 1: Using pre-aggregated data

``` r
plot_agg <- ggplot(dt_agg, aes(x = city, 
                               y = mean_lifespan,
                               fill = city == max_city)) +  # Use logical test to determine fill color
  
  # Basic bar plot for pre-calculated means
  geom_bar(stat = "identity") # geom_col() would be equivalent
```

### Method 2: Using raw data

``` r
plot_raw <- ggplot(dt_raw, aes(x = city, 
                               y = lifespan,
                               fill = city == max_city)) +  # Use logical test to determine fill color
  
  # Basic bar plot that calculates means from raw data
  geom_bar(stat = "summary",  # stat = "summary" performs calculation from raw observations
           fun = "mean")      # fun = "mean" specifies we want the mean of all observations per city
```

*Note! when you have `geom_bar(stat = 'summary', fun = ...)`, `fun =`
can take the following built-in options: “mean”, “median”, “sum”, “min”,
“max”, “length”, “sd”, “var”, and “IQR”. Custom functions can also be
used.*

At this point the two plots are (more or less) the same, so the rest of
the code applies equally regardless of whether you started with
pre-aggregated or raw data. For convenience and simplicity we have
arbitrarily chosen to continue with the `plot_raw` object.

## Define scales (colors)

``` r
plot_raw <- plot_raw + 
    # Custom colors: can use names ('black') or hex ('#000000')
    scale_fill_manual(values = c('TRUE' = '#7570B3',     # hex color for highest value
                                'FALSE' = '#1B9E77')) +  # hex color for other values
    
    # Customize y-axis
    scale_y_continuous(
      breaks = seq(0, 60, by = 5),    # show tick marks every 5 units
      labels = function(x) ifelse(x %% 10 == 0, x, "")  # only show axis labels for multiples of 10
    )
```

## Add labels

``` r
plot_raw <- plot_raw +
    labs(
      title = 'Mean Lifespan in Ancient Cities',
      subtitle = 'Illustration of a Simple Bar Graph',
      x = 'City',
      y = 'Mean Lifespan (years)'
    )
```

## Add APDE customizations

The `apde_caption()`, `theme_apde()`, and `rotate_x_labels()` elements
are from the `apde.graphs` package, not `ggplot2`.

``` r
plot_raw <- plot_raw +
    apde_caption(data_source = 'Synthetic dataset') +
    theme_apde() +
    rotate_x_labels() # pivots x-axis labels by 45 degrees to reduce crowding
```

## Drop legend since it is not useful in this graph

``` r
plot_raw <- plot_raw + 
  theme(legend.position = 'none')
```

## Add horizontal reference line

``` r
plot_raw <- plot_raw +
    geom_hline(yintercept = mean(dt_raw$lifespan), 
               linetype = 'dashed',  # also 'solid', 'dashed', 'dotdash', 'longdash', and 'twodash'
               linewidth = 1,
               color = 'red')
```

## Add annotations

``` r
plot_annotated <- plot_raw +
  
    # Add text annotation
    annotate(
      geom = 'text',
      size = 4,
      x = 4,  # when categorical, each category = 1 increment 
      y = 50,
      label = 'Overall mean lifespan',
      hjust = 0,
      vjust = 0
    ) +
    
    # Add arrow
    annotate(
      geom = "segment",
      x = 5, xend = 5,
      y = 49.5, yend = 47,
      arrow = arrow(length = unit(0.2, "cm"))
    ) +
    
    # Add highlighted rectangle
    annotate(
      geom = 'rect',
      xmin = 3.9, xmax = 6,
      ymin = 49.7, ymax = 52,
      alpha = 0.2,    # transparency (0 == most, 1 == least)
      fill = 'green', # color of rectangle
      col = NA        # color of outline, NA == no outline
    )
```

## Display the annotated plot

``` r
plot_annotated
```

![](bar_plot_highlighted_files/figure-commonmark/display_annotated-1.png)

## Create horizontal (rotated) version

``` r
plot_horizontal <- plot_raw + 
  coord_flip() + # rotates the entire plot
  rotate_x_labels(angle = 0, hjust = 0.5) # rotated x axis labels not needed for horizontal version
```

## Display the horizontal version

``` r
plot_horizontal
```

![](bar_plot_highlighted_files/figure-commonmark/display_horizontal-1.png)

## Save the plots

`ggsave` automatically detects file type from filename extension (.jpg,
.png, .pdf, etc.)

``` r
# Save the annotated vertical version
ggsave('ancient_cities_annotated.jpg',    
       plot_annotated,                   
       width = 10,                           
       height = 6,                           
       dpi = 600)                            

# Save the horizontal versions
ggsave('ancient_cities_horizontal.jpg', 
       plot_horizontal, 
       width = 10, 
       height = 6, 
       dpi = 600)
```

– *Updated by dcolombara, 2024-12-04*
