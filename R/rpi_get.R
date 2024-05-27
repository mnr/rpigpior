#' Retrieve the value of an RPi Pin
#'
#' Returns the value of one or more specified board-level pin number (0-40). Stops if the pin is not a valid data line.
#'
#' @param pin_number a Raspberry Pi GPIO board level pin number between 1 and 40. For example, Pin #1 is located upper left and provides 3.3 volts. Pin #40 is located lower right and is the location of GPIO21.
#' @param whatami a data.frame of configuration data as supplied by rpi_whatami().
#'    The default value is a call to rpi_whatami(). If you make frequent calls to
#'    to this function, consider saving the result of rpi_whatami() and pass that saved
#'    data.frame instead.
#'
#' @return named vector with the value of each pin number.
#' @export
#'
#' @examplesIf rpigpior::rpi_whatami()$is_rpi
#' \dontrun{
#' rpi_get(1) # produces error since pin #1 is not data
#' }
#' rpi_get(40) # returns a named vector of the state of GPIO21. i.e. return["GPIO21"] = 1
#' rpi_get(c(7, 40)) # returns a named vector of values from pins 7 and 40
#'
#' # consider this for multiple calls to rpi_get()
#' mywhatami <- rpi_whatami()
#' rpi_get(40, whatami = mywhatami)
rpi_get <- function(pin_number, whatami = rpi_whatami()) {

  bcm_line <- rpigpior::rpi_pinToBCM(pin_number)
  pin_name <- names(bcm_line)

  gpio_sysCall <- paste(
    "gpioget", whatami$gpiochip,
    paste(bcm_line, collapse = " ")
  )

  pin_value <- system(gpio_sysCall, intern = TRUE) |>
    strsplit(split = " ") |>
    unlist() |>
    as.numeric()

  names(pin_value) <- pin_name

  return(pin_value)
}
