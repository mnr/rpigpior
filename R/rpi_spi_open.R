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
#' @return spiDeviceID which identifies the SPI device
#' @export
#'
#' @examples
rpi_spi_open <- function(spiBus,
                         spiChan,
                         spiMode,
                         spiBits = 8,
                         spiSpeed = 1000000) {
  # we really ought to check these incoming values...

  spiDevString <- paste0("/dev/spidev",spiBus,".",spiChan)
  spiDeviceID <- file(description = spiDevString, open = "r+")

  spiControl <-  list(
    spiChan = spiChan,
    spiBus = spiBus,
    max_speed_hz = spiSpeed,
    spiDeviceID = spiDeviceID,
    tx_buf        = something,
    rx_buf        = something,
    len           = count, # length of tx/rx buffers in bytes
    delay_usecs   = 0,
    bits_per_word = spiBits,
    cs_change     = 0
  )

  # set the write ioctl mode
  rpi_ioctl(spiDeviceID, SPI_IOC_WR_MODE, spiControl)
  #stringToEval <- paste0('ioctl(',spiDeviceID,', SPI_IOC_WR_MODE,', spiMode)
  #evalCpp(stringToEval,depends = spiIncludes)

  # # set the read ioctl mode
  # stringToEval <- paste0('ioctl(',spiDeviceID,', SPI_IOC_RD_MODE,', spiMode)
  # evalCpp(stringToEval,
  #         depends = spiIncludes)
  #
  # # set the spi write bitsPerWord
  # stringToEval <- paste0('ioctl(',spiDeviceID,', SPI_IOC_WR_BITS_PER_WORD,', spiBits)
  # evalCpp(stringToEval,
  #         depends = spiIncludes)
  #
  # # set the spi read bitsPerWord
  # stringToEval <- paste0('ioctl(',spiDeviceID,', SPI_IOC_RD_BITS_PER_WORD,', spiBits)
  # evalCpp(stringToEval,
  #         depends = spiIncludes)
  #
  # # set the spi write speed
  # stringToEval <- paste0('ioctl(',spiDeviceID,', SPI_IOC_WR_MAX_SPEED_HZ,', spiSpeed)
  # evalCpp(stringToEval,
  #         depends = spiIncludes)
  #
  # # set the spi read speed
  # stringToEval <- paste0('ioctl(',spiDeviceID,', SPI_IOC_RD_MAX_SPEED_HZ,', spiSpeed)
  # evalCpp(stringToEval,
  #         depends = spiIncludes)

  return(spiDeviceID)
}
