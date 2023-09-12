#' Turn lines on or off
#'
#'
#'
#' @param pin_number one or more pin numbers as found on the Raspberry pi GPIO. Use the actual pin numbers (i.e. 1:40)
#' @param onOff a vector the same length of pin_number with values of 0 or 1 to turn the line off or on
#'
#' @return no value is returned
#' @export
#'
#' @examplesIf is.rpi()
#' # turns pin 19 on, 21 off, and 23 on.
#' # This corresponds to gpio09, gpio10, and gpio11
#' rpi_set(pin_number = c(19, 21, 23), onOff = c(1,0,1))
#'
#' toggleThesePins <- c(19,21,23)
#' rpi_set(toggleThesePins, 1) # turns all three pins on. onOff is recycled
#' Sys.sleep(1)
#' rpi_set(toggleThesePins, c(0,1,0)) # turns off pins 19 and 23
#' Sys.sleep(1)
#' rpi_set(toggleThesePins, 0) # turns off all pins
rpi_set <- function(pin_number, onOff) {

  bcm_line <- rpi_pinToBCM(pin_number)

  pinAndValue <- paste0(bcm_line,"=",onOff)

  gpio_sysCall <- paste("gpioset",
                        gpio_chip = 0,
                        paste(pinAndValue, collapse = " ")
  )

  system(gpio_sysCall, intern = TRUE)
}
