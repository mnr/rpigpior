#' Retrieve the value of a RPi Pin
#'
#' Returns the value of a board-level pin number (0-40). Stops if the pin is not a valid data line.
#'
#' @param pin_number a Raspberry Pi GPIO board level pin number between 1 and 40. For example, Pin #1 is located upper left and provides 3.3 volts. Pin #40 is located lower right and is the location of GPIO21.
#' @param describe Logical. TRUE will return the pin description along with the value.
#'
#' @return vector with the value of a pin number. Includes the description if `describe = TRUE`
#' @export
#'
#' @examples
#' rpi_get(1) # produces error since pin #1 is not data
#' rpi_get(40) # returns the state of GPIO21 (0 or 1)
#' rpi_get(40, describe = TRUE) # returns a vector of two values: state of GPIO21 and description. i.e. c("0", "GPIO21")
rpi_get <- function(pin_number,
                    describe = FALSE) {

  # check this pin number. Is it a valid data line?
  if(pin_number < 1 || pin_number > 40) {
    print("invalid number")
    #stop("This is not a valid pin number (1:40)")
  }

  pin_description <- rpi_pin_desc[pin_number,"Description"]

  if(startsWith( pin_description, prefix = "GPIO")) {
    bcm_line <- substr(pin_description,start = 5, stop = 6)
    bcm_line <- as.numeric(bcm_value)
  } else {
    stop("Pin ", pin_number, " is ", pin_description, " and is not a valid data line.")
  }

  gpio_sysCall <- paste("gpioget",
                        gpio_chip = 0,
                        bcm_line)

  pin_value <- system(gpio_sysCall, intern = TRUE)

  if(describe == TRUE) {
    return(c(pin_value, pin_description))
  } else {
    return(pin_value)
  }
}
