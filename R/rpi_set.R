#' Turn lines on or off
#'
#'
#'
#' @param pin_number one or more pin numbers as found on the Raspberry pi GPIO. Use the actual pin numbers (i.e. 1:40)
#' @param onOff a vector the same length of pin_number with values of 0 or 1 to turn the line off or on
#' @param whatami a data.frame of configuration data as supplied by rpi_whatami().
#'    The default value is a call to rpi_whatami(). If you make frequent calls to
#'    to this function, consider saving the result of rpi_whatami() and pass that saved
#'    data.frame instead.
#'
#' @return no value is returned
#' @export
#'
#' @examplesIf rpigpior::rpi_whatami()$is_rpi
#' # turns pin 19 on, 21 off, and 23 on.
#' # This corresponds to gpio09, gpio10, and gpio11
#' rpi_set(pin_number = c(19, 21, 23), onOff = c(1, 0, 1))
#'
#' toggleThesePins <- c(19, 21, 23)
#' rpi_set(toggleThesePins, 1) # turns all three pins on. onOff is recycled
#' Sys.sleep(1)
#' rpi_set(toggleThesePins, c(0, 1, 0)) # turns off pins 19 and 23
#' Sys.sleep(1)
#' rpi_set(toggleThesePins, 0) # turns off all pins
#'
#' # consider this for multiple calls to rpi_set()
#' mywhatami <- rpi_whatami()
#' rpi_set(19, whatami = mywhatami)

rpi_set <- function(pin_number, onOff, whatami = rpi_whatami()) {
  if (is.logical(onOff)) {
    onOff <- ifelse(onOff, 1, 0)
  }

  bcm_line <- rpigpior::rpi_pinToBCM(pin_number)

  pinAndValue <- paste0(bcm_line, "=", onOff)

  gpio_sysCall <- paste(
    "gpioset", whatami$gpiochip,
    paste(pinAndValue, collapse = " ")
  )

  system(gpio_sysCall, intern = TRUE)
}
