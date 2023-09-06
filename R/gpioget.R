# gpioget - read values of specified GPIO lines
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpioget.c
# https://kernel.googlesource.com/pub/scm/libs/libgpiod/libgpiod/+/v0.2.x/README.md
#' gpioget
#'
#' @param gpio_line Retrieve state from this pin. Uses BCM numbering. This can be a single number or a vector or line numbers
#' @param gpio_chip Retrieve the pin info from this chip number. Defaults to chip 0. Chips are listed by gpiodetect()
#' @param gpio_active Set the line active state, or what value to return when signal is high. gpio_active = FALSE inverts the active state of the line
#' @param gpio_bias Set the line bias to one of the following: as-is (the default), disable, pull-down, pull-up
#'
#' @return
#' @export
#'
#' @examples
#' read the value of a single gpio line
#' gpioget(gpio_chip = 0, gpio_line = 21)
#' Read two values at the same time.
#' gpioget(gpio_chip = 0, gpio_line = c(21,19))
gpioget <- function(gpio_chip = 0,
                    gpio_active = TRUE,
                    gpio_line,
                    gpio_bias = "as-is") {
  gpio_sysCall <- paste("gpioget",
                        if (!gpio_active) {"--active-low"},
                        "--bias", gpio_bias,
                        gpio_chip,
                        paste(gpio_line, collapse = " "))
  # print(gpio_sysCall)
  return(system(gpio_sysCall, intern = TRUE))
}

# todo
# gpio_chip should understand the output of gpiofind. i.e. "gpiochip0 15"
