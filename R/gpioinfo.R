# gpioinfo - list all lines of specified gpiochips, their names, consumers, direction, active state and additional flags
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpioinfo.c

#' List all lines of a gpio chip
#'
#' List all lines of specified gpio chips, their names, consumers, direction, active state and additional flags. Be aware not all of these lines are available to the Raspberry Pi pins.
#'
#' @param gpio_chip The GPIO chip to search. Probably 0, 1, or something like gpiochip0
#'
#' @return a vector. The first element identifies the chip and number of lines.
#'     The following elements contain information about each gpio line
#'
#' \itemize{
#'   \item Line Number - The BCM number. This may be different than pinout number. For example, Raspberry Pi Pin 1 is 3.3 volts, not ID_SCL
#'   \item Line Name - The descriptive name of this line. For example, BCM Line 0 is identified as ID_SDA and shows up as Raspberry Pi pin 3
#'   \item Used/unused status - Is something talking to this line?
#'   \item Input/Output mode - Some Raspberry Pi pins can be set to input or output
#'   \item Active-High, Active-Low - When this line is closed, does it indicate ON or OFF?
#' }
#'
#' @export
#'
#' @examplesIf is.rpi()
#' gpioinfo(0)
gpioinfo <- function(gpio_chip) {
  # read gpio info
  gpio_sysCall <- paste("gpioinfo",gpio_chip)
  allLines <- system(gpio_sysCall, intern = TRUE)
  return(allLines)
}
