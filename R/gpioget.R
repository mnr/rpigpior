# gpioget - read values of specified GPIO lines
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpioget.c
# https://kernel.googlesource.com/pub/scm/libs/libgpiod/libgpiod/+/v0.2.x/README.md
#' gpioget
#'
#' @param gpio_line
#' @param gpio_chip
#' @param gpio_active
#'
#' @return
#' @export
#'
#' @examples
#' read the value of a single gpio line
#' gpioget gpiochip1 23
#' Read two values at the same time. Set the active state of the lines to low.
#' gpioget --active-low gpiochip1 23 24
gpioget <- function(gpio_chip,
                    gpio_active = FALSE,
                    gpio_line) {
  gpio_sysCall <- paste("gpiodetect",gpio_chip, gpio_line,
                        ifelse(gpio_active, "", "--active-low"))
  system(gpio_sysCall, intern = TRUE)
}
