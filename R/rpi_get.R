#' Retrieve the value of a RPi Pin
#'
#' Returns the value of one or more specified board-level pin number (0-40). Stops if the pin is not a valid data line.
#'
#' @param pin_number a Raspberry Pi GPIO board level pin number between 1 and 40. For example, Pin #1 is located upper left and provides 3.3 volts. Pin #40 is located lower right and is the location of GPIO21.
#'
#' @return named vector with the value of each pin number.
#' @export
#'
#' @examples
#' rpi_get(1) # produces error since pin #1 is not data
#' rpi_get(40) # returns a named vector of the state of GPIO21. i.e. return["GPIO21"] = 1
#' rpi_get(c(7, 40)) # returns a named vector of values from pins 7 and 40
rpi_get <- function(pin_number) {

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

  gpio_sysCall <- paste("gpioget",
                        gpio_chip = 0,
                        paste(bcm_line, collapse = " ")
                        )

  # I wish |> was available on RPi!
  pin_value <- system(gpio_sysCall, intern = TRUE)

  pin_value <- unlist(strsplit(pin_value, split = " "))

  pin_value <- as.numeric(pin_value)

  names(pin_value) <- pin_name

  return(pin_value)
}
