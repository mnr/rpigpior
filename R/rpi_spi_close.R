# rpi_spi_close

#' Close the connection to an SPI device
#'
#' @param spiDevice an SPI device id as supplied by rpi_spi_open(). spiDevice$con is the connection object to close
#'
#' @return NULL or an integer status. See base::close for details
#' @export
#'
#' @examples
rpi_spi_close <- function(spiDevice) {
  return(close(description = spiDevice$con))
}
