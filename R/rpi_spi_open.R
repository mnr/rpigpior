# rpi_spi_open

# review this...
# https://opencoursehub.cs.sfu.ca/bfraser/grav-cms/cmpt433/links/files/2022-student-howtos-ensc351/SPI-On-BBG.pdf
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
                         spiMode = -1,
                         spiBits = -1,
                         spiSpeed = -1) {
  # I really ought to check these incoming values...

  spiDevString <- paste0("/dev/spidev",spiBus,".",spiChan)
  spiDeviceID <- file(description = spiDevString, open = "r+") # a connection object

  # question. Should this be "open()" instead of "file()"
  # fd = open("/dev/spidev0.0", O_RDWR);
  # if (fd < 0)
  # {
  #   // error
  # }

  spiControl <-  list(
    spiChan = spiChan,
    spiBus = spiBus,
    spiMode = spiMode,
    max_speed_hz = spiSpeed,
    device = spiDeviceID, # a connection object
    tx_buf        = "", # text to send
    rx_buf        = "", # text received from spi device
    len           = 0, # length of tx/rx buffers in bytes
    delay_usecs   = 0,
    bits_per_word = spiBits,
    cs_change     = 0,
    status_value = 0,
    status_msg = ""
  )

  if (spiMode == -1) {
  # read ioctl/spi mode
    returnSpiControl <- rpi_ioctl(spiDeviceID, "SPI_IOC_RD_MODE", spiControl)
    if (returnSpiControl$status_value == -1) {stop(returnSpiControl$status_msg)}
    spiControl$spiMode = returnSpiControl$spiMode;
  }

  if (spiBits == -1) {
    # read the spi bitsPerWord
    returnSpiControl <- rpi_ioctl(spiDeviceID, "SPI_IOC_RD_BITS_PER_WORD", spiControl)
    if (returnSpiControl$status_value == -1) {stop(returnSpiControl$status_msg)}
    spiControl$bits_per_word = returnSpiControl$bits_per_word;
    }

  if (spiSpeed == -1) {
    # read the spi speed
    returnSpiControl <- rpi_ioctl(spiDeviceID, "SPI_IOC_RD_MAX_SPEED_HZ", spiControl)
  if (returnSpiControl$status_value == -1) {stop("returnSpiControl$status_msg")}
    spiControl$max_speed_hz = returnSpiControl$max_speed_hz;
  }

  return(spiControl)
}
