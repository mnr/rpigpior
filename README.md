
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rpigpior

<!--  <a href="https://mnr.github.io/rpigpior/"><img src="man/figures/logo.png" align="right" height="138"></a> -->
<!-- badges: start -->

[![R-CMD-check](https://github.com/mnr/rpigpior/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/mnr/rpigpior/actions/workflows/R-CMD-check.yaml)

<!-- badges: end -->

`rpigpior` allows the R programming language access to the Raspberry Pi
GPIO using libgpiod. Because libgpiod is already included in Raspbian,
there is nothing else to install.

`rpigpior` provides these tools:

- is.rpi - Returns TRUE if this code is running under Raspbian
- rpi_get - Returns the value of a board level pin (1-40) or an error if
  the pin isn’t a data line (3.3v, 5v, or GROUND)
- rpi_set - Sets a pin to on or off
- rpi_monitor - watches a pin for a number of rising or falling events

## Installation

`rpigpior` is hosted on github. Until it arrives at cran, you can
install the development version of rpigpior from
[GitHub](https://github.com/mnr/rpigpior) with:

``` r
remotes::install_github("mnr/rpigpior")
```

Most documentation will tell you to use devtools, but
`install.packages("devtools")` on a Raspberry Pi is an onerous task.

Once you’ve installed, use `library` just like any other R package:

``` r
library(rpigpior)
```

[Related mailing list:
linux-gpio@vger.kernal.org](https://www.spinics.net/lists/linux-gpio/)

## 
