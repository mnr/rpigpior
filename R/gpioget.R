# gpioget - read values of specified GPIO lines
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpioget.c
# https://kernel.googlesource.com/pub/scm/libs/libgpiod/libgpiod/+/v0.2.x/README.md
#' Retrieves the state of a single pin on the GPIO
#'
#' @param gpio_line Retrieve state from this pin. Uses BCM numbering. This can be a single number or a vector or line numbers
#' @param gpio_chip Retrieve the pin info from this chip number or chip specification. Defaults to chip 0. This can be a number or a name such as gpiochip0. Chips are listed by gpiodetect()
#' @param gpio_active Set the line active state, or what value to return when signal is high. gpio_active = FALSE inverts the active state of the line
#' @param gpio_bias Set the line bias to one of the following: as-is (the default), disable, pull-down, pull-up
#'
#' @return A vector of 1 or 0 the same length of gpio_line indicating the state of each pin
#' @export
#'
#' @examplesIf is.rpi()
#' # read the value of a single gpio line
#' gpioget(gpio_chip = 0, gpio_line = 21)
#'
#' # Read two values at the same time
#' gpioget(gpio_chip = 0, gpio_line = c(21,19))
#'
#' # Specify gpiochip by name
#' gpioget(gpio_chip = "gpiochip0", gpio_line = 21)
gpioget <- function(gpio_chip = 0,
                    gpio_active = TRUE,
                    gpio_line,
                    gpio_bias = "as-is") {
  if (is.na(as.numeric(gpio_line))) {
    # if gpio_line is a string, then use gpiofind() to identify gpio_chip and gpio_line
    # this will override gpio_chip
    gpio_found <- tryCatch({
      gpiofind(gpio_line)
    },
    warning = function(w) {
      message(paste("Unable to find", gpio_line))
      print(w)
      return(NA)
    },
    error = function(e) {
      message(paste("Unable to find", gpio_line))
      print(e)
      return(NA)
    })
    gpio_found_split <- strsplit(gpio_found, split = " ")
    gpio_chip <- gpio_found_split[[1]][1]
    gpio_line <- gpio_found_split[[2]][2]
  }


  gpio_sysCall <- paste("gpioget",
                        if (!gpio_active) {
                          "--active-low"
                        },
                        "--bias",
                        gpio_bias,
                        gpio_chip,
                        paste(gpio_line, collapse = " "))
  return(system(gpio_sysCall, intern = TRUE))
}
