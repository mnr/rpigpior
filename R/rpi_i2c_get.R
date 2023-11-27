
#' Return a byte from an i2c device
#'
#' @param chip_address an integer between 0x03 and 0x77. Use i2cdetect -y 1 to identify the address
#' @param data_address an integer between 0x00 and 0xFF. This will come from the chip documentation
#' @param data_size read a byte (b) or a word (w) from data_address
#'
#' @return data from the i2c device located at chip_address and data_address
#' @export
#'
#' @examplesIf is.rpi()
#' rpi_i2c_get(chip_address = 0x77, data_address = 0xfa, data_size = 'b') # get a byte from an i2c device located at 0x77
#'
rpi_i2c_get <- function(chip_address, data_address, data_size = "b") {
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
      chip_address > 0xFF
  ) {
    stop("You must specify a data_address as an integer between 0x00 and 0xFF")
  }

  # data_size must be one of "b" or "w"
  if (!(data_size %in% c("b","w"))
  ) {
    stop('You must specify a data_size of "b" (byte) or "w" (word)')
  }

  gpio_sysCall <- paste("i2cget -y",
                        i2cbus,
                        chip_address,
                        data_address,
                        data_size)

  return(system(gpio_sysCall, intern = TRUE))
}
