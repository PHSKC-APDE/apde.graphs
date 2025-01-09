# apde.graphs

## Purpose
The `apde.graphs` package provides both specialized functions and standardized templates to help Public Health Seattle & King County's Assessment, Policy Development, and Evaluation Unit (PHSKC APDE) create consistent ggplot2 visualizations. The package's functions handle common formatting tasks like applying consistent themes and adding standardized captions, while its templates demonstrate best practices for various common visualization types. Together, these tools help staff create high-quality visualizations more efficiently while ensuring visual consistency across our reports and presentations, regardless of who creates them.

## Installation
To install the package, run the following commands:

```r
install.packages("remotes")
remotes::install_github("PHSKC-APDE/apde.graphs", auth_token = NULL)
```

## Functions
The package includes four helper functions to streamline your visualization workflow:

- `apde_theme()`: Applies APDE's standardized ggplot2 theme
- `apde_caption()`: Adds a standardized caption with division name, date, and data source
- `apde_quantile_breaks()`: Generates evenly spaced breaks using data quantiles
- `apde_rotate_xlab()`: Rotates x-axis labels for better readability

## Examples
For detailed examples and usage guides, visit our [Wiki](https://github.com/PHSKC-APDE/apde.graphs/wiki).

### Quick Reference Gallery
Click on any visualization to see its implementation details:

<table>
<tr>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/bar_plot_chi">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/bar_plot_chi_files/figure-commonmark/display_custom_colors-1.png" width="300" alt="CHI Style Bar Graphs"/>
    </a>
</td>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/bar_plot_groups">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/bar_plot_groups_files/figure-commonmark/display_hline-1.png" width="300" alt="Bar Plot by groups"/>
    </a>
</td>
</tr>

<tr>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/bar_plot_single">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/bar_plot_single_files/figure-commonmark/display_horizontal2-1.png" width="300" alt="Bar Plot horizontal"/>
    </a>
</td>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/boxplots_by_group">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/boxplots_by_group_files/figure-commonmark/display_theme_tweak-1.png" width="300" alt="Box Plots"/>
    </a>
</td>
</tr>

<tr>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/faceted_plots">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/faceted_plots_files/figure-commonmark/display_customize_facet_wrap-1.png" width="300" alt="facet_wrap"/>
    </a>
</td>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/faceted_plots">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/faceted_plots_files/figure-commonmark/display_customized_face_grid2-1.png" width="300" alt="facet_grid"/>
    </a>
</td>
</tr>

<tr>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/forest_plot">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/forest_plot_files/figure-commonmark/display_with_reference-1.png" width="300" alt="Forest Plot"/>
    </a>
</td>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/forest_plot">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/forest_plot_files/figure-commonmark/display_modern-1.png" width="300" alt="Forest Plot"/>
    </a>
</td>
</tr>

<tr>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/histogram">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/histogram_files/figure-commonmark/display_with_annotation-1.png" width="300" alt="Histogram"/>
    </a>
</td>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/maps_choropleth">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/maps_choropleth_files/figure-commonmark/display_with_cities-1.png" width="300" alt="Choropleth Map"/>
    </a>
</td>
</tr>

<tr>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/maps_density">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/maps_density_files/figure-commonmark/display_adjusted_theme-1.png" width="300" alt="Density Map"/>
    </a>
</td>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/maps_points">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/maps_points_files/figure-commonmark/display_with_labels-1.png" width="300" alt="Point Map"/>
    </a>
</td>
</tr>

<tr>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/scatter_plot">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/scatter_plot_files/figure-commonmark/display_plot-1.png" width="300" alt="Scatter Plot"/>
    </a>
</td>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/scatter_plot">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/scatter_plot_files/figure-commonmark/display_with_custom_legends-1.png" width="300" alt="Best Fit Curve"/>
    </a>
</td>
</tr>

<tr>
<td width="50%">
    <a href="https://github.com/PHSKC-APDE/apde.graphs/wiki/trend_line_chi">
        <img src="https://github.com/PHSKC-APDE/apde.graphs/wiki/trend_line_chi_files/figure-commonmark/display_tweak_default_theme-1.png" width="300" alt="CHI Style Trend Line"/>
    </a>
<td width="50%">
</td>
</tr>
</table>


## Problems or Suggestions?

If you come across a bug or have specific suggestions for improvement, please click on [Issues](https://github.com/PHSKC-APDE/apde.graphs/issues) at the top of this page and then click [New Issue](https://github.com/PHSKC-APDE/apde.graphs/issues/new) and provide the necessary details.