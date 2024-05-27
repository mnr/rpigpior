
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rpigpior

<!--  <a href="https://mnr.github.io/rpigpior/"><img src="man/figures/logo.png" align="right" height="138"></a> -->
<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

[![R-CMD-check](https://github.com/mnr/rpigpior/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/mnr/rpigpior/actions/workflows/R-CMD-check.yaml)

<!-- badges: end -->

Documentation can be found at <https://mnr.github.io/rpigpior/>

`rpigpior` allows the R programming language access to the Raspberry Pi
GPIO using libgpiod. It relies on the gpiod command line interface,
which may need to be installed on your system.

`rpigpior` provides these tools:

- rpi_whatami - Returns a data.frame with lots of useful information
  about the Raspberry Pi this code is running on. It will complain if
  this isn’t running on a Raspberry Pi.
- `rpi_get` - Returns the value of a board level pin (1-40) or an error
  if the pin isn’t a data line (3.3v, 5v, or GROUND)
- `rpi_set` - Sets a pin to on or off
- `rpi_monitor` - watches a pin for a number of rising or falling events
- `rpi_pwm` - provides diagnostics and support for hardware pulse width
  modulation
- `rpi_i2c_get` - retrieve a value from an i2c connection
- `rpi_i2c_set` - set an i2c register to a value

## Installation

`rpigpior` is hosted on github. Until it arrives at cran, you can
install the development version of rpigpior from
[GitHub](https://github.com/mnr/rpigpior)

If you installed R on your Raspberry Pi using [r4pi](https://r4pi.org/),
you can use devtools just like normal.

``` r
# Start R with "sudo R" to install packages
# install.packages("devtools")

# You might want to switch back to non-admin R
library(devtools)
install_github("mnr/rpigpior")
```

Once you’ve installed, use `library` just like any other R package:

``` r
library(rpigpior)
```

## Is this a Raspberry Pi?

It’s helpful to check if your code is running on a Raspberry Pi.

``` r
if ( rpi_whatami()$is_rpi ) {
   print("Yes, this is a RPi")
  } else {
   print ("No, this is not a RPi")
}
```

## Reading a pin

If you connect a switch to board pin 40, this code will read it:

``` r
library(rpigpior)

rpi_get(40) # reads board pin 40
rpi_get(c(7,40)) # reads board pins 7 and 40

> GPIO004  GPIO21
        0       1
```

That assumes the switch to board pin 40 is “pushed” or closed. By the
way, there is a diagram of this located in the *articles* section of the
website (as identified in the package description)

## Turning pins on and off

If you have a LEDs connected to board pin 19, 21, and 23, this code will
turn them on, then one of them off, then all of them off

    library(rpigpior)

    toggleThese <- c(19,21,23)
    rpi_set(toggleThese,1)
    Sys.sleep(1)
    rpi_set(toggleThese, c(1,0,1))
    Sys.sleep(1)
    rpi_set(toggleThese, 0)

## Citation:

``` r
citation("rpigpior")
#> Warning in citation("rpigpior"): no date field in DESCRIPTION file of package
#> 'rpigpior'
#> 
#> To cite package 'rpigpior' in publications use:
#> 
#>   Niemann-Ross M (2024). _rpigpior: Provides R with Access to the
#>   Raspberry Pi_. https://github.com/mnr/rpigpior,
#>   https://mnr.github.io/rpigpior/.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {rpigpior: Provides R with Access to the Raspberry Pi},
#>     author = {Mark Niemann-Ross},
#>     year = {2024},
#>     note = {https://github.com/mnr/rpigpior, https://mnr.github.io/rpigpior/},
#>   }
```

## Related notes:

[Related mailing list:
linux-gpio@vger.kernal.org](https://www.spinics.net/lists/linux-gpio/)
