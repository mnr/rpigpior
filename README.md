
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rpigpior

<!-- badges: start -->
<!-- badges: end -->

`rpigpior` allows the R programming language access to the Raspberry Pi
GPIO using libgpiod. Because libgpiod is already included in Raspbian,
there is nothing else to install.

rpigpior implements the six tools provided by
[libgpiod](https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/about/)
for GPIO access:

- **gpiodetect** - list all gpiochips present on the system, their
  names, labels and number of GPIO lines

- **gpioinfo** - list lines, their gpiochip, offset, name, and
  direction, and if in use then the consumer name and any other
  configured attributes, such as active state, bias, drive, edge
  detection and debounce period

- **gpioget** - read values of specified GPIO lines

- **gpioset** - set values of specified GPIO lines, holding the lines
  until the process is killed or otherwise exits

- **gpiomon** - wait for edge events on GPIO lines, specify which edges
  to watch for, how many events to process before exiting, or if the
  events should be reported to the console

- **gpionotify** - wait for changed to the info for GPIO lines, specify
  which changes to watch for, how many events to process before exiting,
  or if the events should be reported to the console

- **gpiofind** - Find a GPIO line by name. The output of this command
  can be used as input for gpioget & gpioset

`rpigpior` also provides a few utilities for use with the R programming
language on Raspberry Pi:

- **is.rpi** - Returns TRUE if this code is running under Raspbian

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

## Examples

### gpiodetect

### gpioget

### is.rpi
