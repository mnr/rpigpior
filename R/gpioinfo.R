# gpioinfo - list all lines of specified gpiochips, their names, consumers, direction, active state and additional flags
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpioinfo.c

#' List all lines of a gpio chip
#'
#' List all lines of specified gpio chips, their names, consumers, direction, active state and additional flags
#'
#' @param gpio_chip The GPIO chip to search. Probably 0, 1, or something like gpiochip0
#'
#' @return a character vector. The first element identifies the chip and number of lines. The following elements consist of columns for line number, line name, used/unused status, input/output, active-high/active-low
#' @export
#'
#' @examplesIf is.rpi()
#' gpioinfo(0)
gpioinfo <- function(gpio_chip) {
  gpio_sysCall <- paste("gpioinfo",gpio_chip)
  system(gpio_sysCall, intern = TRUE)
}
