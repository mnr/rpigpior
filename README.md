
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

- `is.rpi` - Returns TRUE if this code is running under Raspbian
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
[GitHub](https://github.com/mnr/rpigpior) with:

``` r
library(devtools)
devtools::install_github("mnr/rpigpior")
```

I highly recommend you use the R install from [r4pi](https://r4pi.org/). They have already set up devtools.

Once you’ve installed, use `library` just like any other R package:

``` r
library(rpigpior)
```

## Is this a Raspberry Pi?

It’s helpful to check if your code is running on a Raspberry Pi. Do this with `is.rpi()`

``` r
if ( is.rpi() ) {
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

This assumes the switch to board pin 40 is “pushed” or closed. By the
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

## Related notes:

[Related mailing list:
linux-gpio@vger.kernal.org](https://www.spinics.net/lists/linux-gpio/)
