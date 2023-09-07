# gpioinfo - list all lines of specified gpiochips, their names, consumers, direction, active state and additional flags
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpioinfo.c

#' List all lines of specified gpiochips, their names, consumers, direction, active state and additional flags
#'
#' @param gpio_chip The GPIO chip to search. Probably 0, 1, or something like gpiochip0
#'
#' @return
#' @export
#'
#' @examples
gpioinfo <- function(gpio_chip) {
  gpio_sysCall <- paste("gpioinfo",gpio_chip)
  system(gpio_sysCall, intern = TRUE)
}
