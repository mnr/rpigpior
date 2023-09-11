#' Raspberry Pi Pins
#'
#' A board-level description of the 40 GPIO pins found on a Raspberry Pi.
#'     This is different than wiring pi or BCM numbering schemes. Instead, this reflects the function of pins by their physical location on the board.
#'
#' @format ## `rpi_pin_desc`
#' A data frame with 40 rows and two columns:
#' \describe{
#' \item {description}{secondary}
#' \item {Primary function of the pin}{Secondary function of the pin}
#' }
#'
#' @source https://www.raspberrypi.com/documentation/computers/os.html#gpio-and-the-40-pin-header
"rpi_pin_desc"
