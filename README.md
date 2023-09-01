
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rpigpior

<!-- badges: start -->
<!-- badges: end -->

`rpigpior` allows the R programming language access to the Raspberry Pi
GPIO using libgpiod. Because libgpiod is already included in Raspbian,
there is nothing else to install.

[libgpiod](https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/about/)
provides six tools for GPIO access:

- gpiodetect - list all gpiochips present on the system, their names,
  labels and number of GPIO lines

- gpioinfo - list lines, their gpiochip, offset, name, and direction,
  and if in use then the consumer name and any other configured
  attributes, such as active state, bias, drive, edge detection and
  debounce period

- gpioget - read values of specified GPIO lines

- gpioset - set values of specified GPIO lines, holding the lines until
  the process is killed or otherwise exits

- gpiomon - wait for edge events on GPIO lines, specify which edges to
  watch for, how many events to process before exiting, or if the events
  should be reported to the console

- gpionotify - wait for changed to the info for GPIO lines, specify
  which changes to watch for, how many events to process before exiting,
  or if the events should be reported to the console

## Installation

`rpigpior` is hosted on github. Until it arrives at cran, you can
install the development version of rpigpior from
[GitHub](https://github.com/mnr/rpigpior) with:

``` r
remotes::install_github("mnr/rpigpior")
```

Most documentation will tell you to use devtools, but
`install.packages("devtools")` is an onerous task.

## Example
