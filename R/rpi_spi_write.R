# rpi_spi_write


rpi_spi_read <- function(spiControl) {

  rpi_ioctl(spiControl$device, "SPI_IOC_MESSAGE(1)", spiControl)

  return(spiControl)
}

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
