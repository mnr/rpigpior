#' Converts a RPi pin number to BCM line
#'
#' Look up a board pin number and return BCM_line and line_name
#'     Pin number is the physical board of the Raspberry pi.
#'
#'     This checks for a valid range of pins (1:40) and for valid input/output lines. This prevents trying to read a 3.3v or ground line.
#'
#' @param pin_number The pin as found on the Raspberry Pi board. Numbered from 1 to 40.
#'
#' @return a named vector.
#'      bcm_line = broadcom line connected to this pin
#'      pin_name = broadcom name such as RXD1 or GPIO21
#' @export
#'
#' @examplesIf is.rpi()
#' rpi_pinToBCM(1) # produces error since pin #1 is not data
#' rpi_pinToBCM(40) # returns a named vector where bcm_line = 21 and pin_name = GPIO21

rpi_pinToBCM <- function(pin_number) {
  # check pin number. Are all values valid data lines?

  bcm_line <- c() # ensure that bcm_line is empty
  pin_name <- c() # ensure that pin_name is empty
  for (eachPin in pin_number) {
    # is eachpin in range of 1:40?
    if(eachPin < 1 || eachPin > 40) {
      stop(paste("Pin",eachPin,"is an invalid number (1:40)"))
    }
    # does eachpin start with "GPIO"?
    pinDesc <- rpi_pin_desc[eachPin,"Description"]
    if (startsWith(pinDesc, prefix = "GPIO")) {
      # if this is a GPIO line, add it to bcm_line and pin_name
      bcm_line <- c(bcm_line, substr(pinDesc,start = 5, stop = 6))
      pin_name <- c(pin_name, pinDesc)
    } else {
      stop(paste("Pin",eachPin,"provides",pinDesc,"and is not a data line."))
    }
  }

  bcm_line <- as.numeric(bcm_line)
  names(bcm_line) <- pin_name
  return(bcm_line)
}
