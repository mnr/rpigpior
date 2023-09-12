#' Retrieve the value of a RPi Pin
#'
#' Returns the value of one or more specified board-level pin number (0-40). Stops if the pin is not a valid data line.
#'
#' @param pin_number a Raspberry Pi GPIO board level pin number between 1 and 40. For example, Pin #1 is located upper left and provides 3.3 volts. Pin #40 is located lower right and is the location of GPIO21.
#'
#' @return named vector with the value of each pin number.
#' @export
#'
#' @examplesIf is.rpi()
#' rpi_get(1) # produces error since pin #1 is not data
#' rpi_get(40) # returns a named vector of the state of GPIO21. i.e. return["GPIO21"] = 1
#' rpi_get(c(7, 40)) # returns a named vector of values from pins 7 and 40
rpi_get <- function(pin_number) {

  bcm_line <- rpi_pinToBCM(pin_number)
  pin_name <- names(bcm_line)

  gpio_sysCall <- paste("gpioget gpiochip0",
                        paste(bcm_line, collapse = " ")
                        )

  # I wish |> was available on RPi!
  pin_value <- system(gpio_sysCall, intern = TRUE)

  pin_value <- unlist(strsplit(pin_value, split = " "))

  pin_value <- as.numeric(pin_value)

  names(pin_value) <- pin_name

  return(pin_value)
}
