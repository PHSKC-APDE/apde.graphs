# Scatter Plots


This example demonstrates `ggplot2` code by building a scatter plot
step-by-step. While you would typically write all components in a single
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

``` r
set.seed(98104) # necessary to get same 'random' results each time

n_points <- 1000

dt <- data.table(
  age = runif(n_points, 10, 70), # random ages between 10 and 70
  group = sample(c('Group 1', 'Group 2'), n_points, replace = TRUE)
)

# Add 'wisdom' scores with different peaks for each group
dt[group == 'Group 1',
   wisdom := 20 + 60 * dnorm(age, 40, 25) + # a normal curve
     rnorm(.N, 0, 0.2)] # add random noise

dt[group == 'Group 2',
   wisdom := 20 + 60 * dnorm(age, 50, 20) +
     rnorm(.N, 0, 0.2)]
```

Here is a peek at the data. Note that, in general, `ggplot2` works best
with data in long format.

``` r
head(dt)
```

|      age | group   |   wisdom |
|---------:|:--------|---------:|
| 38.51950 | Group 2 | 20.71231 |
| 69.30170 | Group 2 | 20.67414 |
| 36.74943 | Group 2 | 20.55398 |
| 39.77599 | Group 1 | 20.63184 |
| 16.36703 | Group 2 | 20.32795 |
| 21.18335 | Group 1 | 20.61924 |

## Create the base `ggplot2` scatter plot

``` r
myplot <- ggplot(dt, aes(x = age,
                         y = wisdom,
                         color = group,    # different color for each group
                         shape = group)) + # different shape for each group
  # Basic scatter plot
  geom_point(alpha = 0.3,  # Transparency of dots (0 == most, 1 == least)
             size = 3) +   # dot size
  # Add smoothed fit lines with confidence intervals
  geom_smooth(method = 'loess',    # LOESS for non-linear trends, can also use 'lm' or 'glm'
              se = TRUE,           # Show CI
              alpha = 0.2,         # Transparency of CI (0 == most, 1 == least)
              linewidth = 1.2)     # Line thickness
```

## Define scales (colors and shapes)

``` r
myplot <- myplot +
  # Custom colors: can use names ('black') or hex ('#000000')
  scale_color_manual(values = c('Group 1' = '#7570B3',  
                                'Group 2' = '#1B9E77')) +
  
  # Custom dot shapes: options are 1:25
  scale_shape_manual(values = c('Group 1' = 1,  # 1 is hollow circle
                                'Group 2' = 2)) # 2 is hollow triangle
```

## Add labels

``` r
myplot <- myplot +
  labs(
    title = 'Wisdom over the Lifespan',
    subtitle = 'Relationship between age and wisdom by group',
    x = 'Age (years)',
    y = 'Wisdom Score',
    color = 'Study Group', # title for the color legend
    shape = 'Study Group'  # title for the shape legend
  )
```

## Add legend customizations

``` r
myplot <- myplot +
  guides(shape = guide_legend(
    override.aes = list(alpha = 0) # legend background transparency (0 == most, 1 == least)
    )) 
```

## Add APDE customizations

The `apde_caption()` and `theme_apde()` elements are from the
`apde.graphs` package, not `ggplot2`.

``` r
myplot <- myplot +
  
  apde_caption(data_source = 'Synthetic dataset') +
  
  theme_apde()
```

## Add vertical reference line

``` r
myplot <- myplot +
  # use geom_hline for horizontal lines
  geom_vline(xintercept = 50,
             linetype = 'dotted', # also 'solid', 'dashed', 'dotdash', 'longdash', and 'twodash'
             linewidth = 1,
             color = '#1B9E77')
```

## Add annotations

``` r
myplot <- myplot +

  # annotate a specific point with text
  annotate(
    geom = 'text', 
    size = 4,
    x = 34, y = 19.9, # set coordinates based on the scale in your graphic
    label = '50 = peak wisdom for group 2',
    hjust = 0,
    vjust = 0) +
  
  # point to something with an arrow
  annotate(
    geom = "segment", 
    x = 46, xend = 49.5,
    y = 20, yend = 20.5,
    arrow = arrow(length = unit(0.2, "cm"))) +
  
  # highlight a rectangle
  annotate(
    geom = 'rect', # highlight an area of your graph
    xmin = 33, xmax = 55,
    ymin = 19.85, ymax = 20,
    alpha = 0.2,    # transparency of rectangle (0 == most, 1 == least)
    fill = 'green', # color of rectangle
    col = NA)       # color of outline, NA == no outline
```

## Display the plot

``` r
# Note: The message 'geom_smooth() using formula = y ~ x' is normal - 
# it just confirms the default smoothing formula being used
myplot
```

    `geom_smooth()` using formula = 'y ~ x'

![](scatter_plot_files/figure-commonmark/display_plot-1.png)

## Save the plot

`ggsave` automatically detects file type from filename extension (.jpg,
.png, .pdf, etc.)

``` r
ggsave(filename = 'wisdom_age_plot.jpg', 
       plot = myplot, 
       width = 10, 
       height = 6, 
       dpi = 600, 
       units = 'in') # also 'cm', 'mm', 'px'
```

– *Updated by dcolombara, 2024-12-04*
