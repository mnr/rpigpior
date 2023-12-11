# rpi_spi_open

# good example
# https://raspberry-projects.com/pi/programming-in-c/spi/using-the-spi-interface

# spi_mode
# https://www.analog.com/en/analog-dialogue/articles/introduction-to-spi-interface.html

#' Open a connection to a Raspberry Pi SPI device
#'
#' @param spiBus 0 or 1. Used as /dev/spidev[spiBus].[spiChan]
#' @param spiChan 0 or 1. Used as /dev/spidev[spiBus].[spiChan]
#' @param spiMode 0-3. Controls clock polarity & clock phase which defines logic low/high and rising/falling edge data sample
#' @param spiBits Bits Per Word. Typically 8
#' @param spiSpeed Transmission speed. 1000000 = 1MHz
#'
#' @return spiControl - a list of attributes about the SPI device.
#' @export
#'
#' @examples
rpi_spi_open <- function(spiBus,
                         spiChan,
                         spiMode,
                         spiBits = 8,
                         spiSpeed = 1000000) {
  # I really ought to check these incoming values...

  spiDevString <- paste0("/dev/spidev",spiBus,".",spiChan)
  spiDeviceID <- file(description = spiDevString, open = "r+") # a connection object

  spiControl <-  list(
    spiChan = spiChan,
    spiBus = spiBus,
    max_speed_hz = spiSpeed,
    device = spiDeviceID, # a connection object
    tx_buf        = "", # text to send
    rx_buf        = "", # text received from spi device
    len           = 0, # length of tx/rx buffers in bytes
    delay_usecs   = 0,
    bits_per_word = spiBits,
    cs_change     = 0
  )

  # set the write ioctl mode
  ioctl_value <- rpi_ioctl(spiDeviceID, "SPI_IOC_WR_MODE", spiControl)
  if (ioctl_value$status_value == -1) {stop("Unable to set SPI mode: WR")}

  # set the read ioctl mode
  ioctl_value <- rpi_ioctl(spiDeviceID, "SPI_IOC_RD_MODE", spiControl)
  if (ioctl_value$status_value == -1) {stop("Unable to set SPI mode: RD")}

  # set the spi write bitsPerWord
  ioctl_value <- rpi_ioctl(spiDeviceID, "SPI_IOC_WR_BITS_PER_WORD", spiControl)
  if (ioctl_value$status_value == -1) {stop("Unable to set SPI mode: Write Bits Per Word")}

  # set the spi read bitsPerWord
  ioctl_value <- rpi_ioctl(spiDeviceID, "SPI_IOC_RD_BITS_PER_WORD", spiControl)
  if (ioctl_value$status_value == -1) {stop("Unable to set SPI mode: Read Bits Per Word")}

  # set the spi write speed
  ioctl_value <- rpi_ioctl(spiDeviceID, "SPI_IOC_WR_MAX_SPEED_HZ", spiControl)
  if (ioctl_value$status_value == -1) {stop("Unable to set SPI mode: Write speed")}

  # set the spi read speed
  ioctl_value <- rpi_ioctl(spiDeviceID, "SPI_IOC_RD_MAX_SPEED_HZ", spiControl)
  if (ioctl_value$status_value == -1) {stop("Unable to set SPI mode: Read speed")}

  return(spiControl)
}
