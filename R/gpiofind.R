# gpiofind - find the gpiochip line by name.
#

#' Find the chip and line for a named function
#'
#' Identifies the gpiochip and gpioline. For example, `gpiofind("SCL0")` will return "gpiochip0 45". Note that gpioset and gpioget both accept line names in place of line numbers and will identify the proper gpiochip using gpiofind behind the scenes.
#'
#' @param gpio_name
#'
#' @return The chip name and line number.
#' @export
#'
#' @examplesIf is.rpi()
#'
#' gpiofind("SCL0") # returns "gpiochip0 45"
#'
#' gpioget(gpiofind("SCL0")) # returns status of "gpiochip0 45"
gpiofind <- function(gpio_name) {
  gpio_sysCall <- paste("gpiofind", gpio_name)
  system(gpio_sysCall, intern = TRUE)
}
