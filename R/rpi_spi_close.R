# rpi_spi_close

#' Close the connection to an SPI device
#'
#' @param spiDeviceID an SPI device id as supplied by rpi_spi_open()
#'
#' @return
#' @export
#'
#' @examples
rpi_spi_close <- function(spiDeviceID) {
  close(description = spiDeviceID)
}
