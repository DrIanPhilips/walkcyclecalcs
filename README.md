
<!-- README.md is generated from README.Rmd. Please edit that file -->

# walkcyclecalcs

<!-- badges: start -->

<!-- badges: end -->

The goal of walkcyclecalcs is to provide functions which can be used to
estimate the physical capability of populations of individuals to make
journeys by walking or cycling. This is useful of you want to know
things like who could get to work if there was a shock reduction in fuel
availability for motor vehicles. It is also useful if you want to
understand whether it’s reasonable to assume everyone in a community has
the physical capability to make use of new cycle infrastructure or could
walk to the nearest bus-stop.

The following paper provides an explanation and rationale for the
functions.  
Philips, I., Watling, D., Timms, P., 2018. Estimating Individual
Physical Capability (IPC) to make journeys by bicycle. International
Journal of Sustainable Transportation 12.
<http://dx.doi.org/10.1080/15568318.2017.1368748>

This paper explains how one might generate a synthetic population of
individuals so that you can estimate the variety physical fitness
attributes that people within a community posess.  
Philips, I., Clarke, G.P., Watling, D., 2017. A Fine Grained Hybrid
Spatial Microsimulation Technique for Generating Detailed Synthetic
Individuals from Multiple Data Sources: An Application To Walking And
Cycling . International Journal of Microsimulation 10, 167–200.
<https://microsimulation.org/IJM/V10_1/IJM_2017_10_1_6.pdf>

The work in the papers began as a PhD Thesis:  
Philips, I., 2014. The potential role of walking and cycling to increase
resilience of transport systems to future external shocks. (Creating an
indicator of who could get to work by walking and cycling if there was
no fuel for motorised transport) (phd). University of Leeds.
<http://etheses.whiterose.ac.uk/7349/>

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("DrIanPhilips/walkcyclecalcs")
```

## Example (Under construction)

This will have a basic example which shows you how to solve a common
problem:

``` r
library(walkcyclecalcs)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub\!
