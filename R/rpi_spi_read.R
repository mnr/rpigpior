# rpi_spi_read

#' Reads an spi device
#'
#' @param spiControl list of spi device attributes as returned by rpi_spi_open()
#'
#' @return an spiControl list. spiControl$rx_buf contains the read value
#' @export
#'
#' @examplesIf is.rpi()
#'
rpi_spi_read <- function(spiControl) {

  rpi_ioctl(spiControl$device, "SPI_IOC_MESSAGE(1)", spiControl)

  return(spiControl)
}
