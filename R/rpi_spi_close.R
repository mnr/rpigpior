# rpi_spi_close

#' Close the connection to an SPI device
#'
#' @param spiDevice an SPI device id as supplied by rpi_spi_open(). spiDevice$con is the connection object to close
#'
#' @return NULL no return value
#' @export
#'
#' @examples
rpi_spi_close <- function(spiDevice) {
  close(description = spiDevice$con)
}
