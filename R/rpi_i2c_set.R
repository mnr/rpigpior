# Uses Serial Data Line (SDA, board pin 3)
# and Serial Clock Line (SCL, board pin 5)

#' Write data to an i2c device
#'
#' Writes a byte, a word, or other data block to an i2c device.
#'
#' @param chip_address an integer between 0x03 and 0x77. Use i2cdetect -y 1 to identify the address
#' @param data_address an integer between 0x00 and 0xFF. This will come from the chip documentation
#' @param value a byte (0xff), a word (0xffff), a SMBus (32 bytes) or I2C Block
#' @param data_size
#'
#' @return void
#' @export
#'
#' @examplesIf is.rpi()
#'
rpi_i2c_set <- function(chip_address, data_address, value, data_size = "b") {
  # Assumes Serial Data Line (SDA, board pin 3)
  # ...and Serial Clock Line (SCL, board pin 5)
  # ...therefore i2cbus = 1
  i2cbus <- 1

  # chip-address must be an integer between 0x08 and 0x77
  if (missing(chip_address) ||
      chip_address < 0x08 ||
      chip_address > 0x77
  ) {
    stop("You must specify a chip_address as an integer between 0x08 and 0x77")
  }

  # data_address must be an integer between 0x00 and 0xFF
  if (missing(data_address) ||
      chip_address < 0x00 ||
      chip_address > 0x77
  ) {
    stop("You must specify a data_address as an integer between 0x00 and 0xFF")
  }

  # data_size must be one of "b", "w", "s", or i
  if (!(data_size %in% c("b","w","s","i"))
  ) {
    stop('You must specify a data_size of "b" (byte), "w" (word), "s" (smBus block), or "i" (i2c block)')
  }

  gpio_sysCall <- paste("i2cset -y",
                        i2cbus,
                        chip_address,
                        data_address,
                        value,
                        data_size)

  return(system(gpio_sysCall, intern = TRUE))

}
