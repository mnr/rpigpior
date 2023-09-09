# gpiofind - find the gpiochip line by name.
# the output of this command can be used as input for gpioget & gpioset

#' Find the chip and line for a named function
#'
#' @param gpio_name
#'
#' @return The chip name and line number. This can be used as input for 'gpioget()'
#' @export
#'
#' @examplesIf is.rpi()
#'
#' gpiofind(SCL0) # returns "gpiochip0 45"
#'
#' gpioget(gpiofind(SCL0)) # returns status of "gpiochip0 45"
gpiofind <- function(gpio_name) {
  gpio_sysCall <- paste("gpiofind", gpio_name)
  system(gpio_sysCall, intern = TRUE)
}
