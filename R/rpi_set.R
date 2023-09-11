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
#' @examples
#' rpi_set(pin_number = c(9,10,11), onOff = c(1,0,1))
rpi_set <- function(pin_number, onOff) {

  bcmInfo <- rpi_pinToBCM(pin_number)
  bcm_line <- bcmInfo["bcm_line"]

  pinAndValue <- paste0(bcm_line,"=",onOff)

  gpio_sysCall <- paste("gpioset",
                        gpio_chip = 0,
                        paste(pinAndValue, collapse = " ")
  )

  system(gpio_sysCall, intern = TRUE)
}
