# gpioget - read values of specified GPIO lines
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpioget.c
# https://kernel.googlesource.com/pub/scm/libs/libgpiod/libgpiod/+/v0.2.x/README.md
#' gpioget
#'
#' @param gpio_line Retrieve state from this pin
#' @param gpio_chip Which chip to retrive the pin info from
#' @param gpio_active Set the line active state. Default to low
#'
#' @return
#' @export
#'
#' @examples
#' read the value of a single gpio line
#' gpioget gpiochip1 23
#' Read two values at the same time. Set the active state of the lines to low.
#' gpioget --active-low gpiochip1 23 24
gpioget <- function(gpio_chip = 0,
                    gpio_active = FALSE,
                    gpio_line,
                    gpio_bias = "as-is") {
  gpio_sysCall <- paste("gpioget",
                        ifelse(gpio_active, "", "--active-low"),
                        gpio_chip,
                        gpio_line)

  print(gpio_sysCall)
  return(system(gpio_sysCall, intern = TRUE))
}

# todo
# gpio_line is a vector. Address multiple values/lines/pins
# gpio_bias: as-is, disable, pull-up, pull-down
