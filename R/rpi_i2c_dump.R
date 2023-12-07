#' Read the entire data block from an I2C device
#'
#' This is a wrapper to i2cdump.
#'
#' @param chip_address an integer between 0x03 and 0x77
#'
#' @return the entire memory block from the I2C device
#' @export
#'
#' @examplesIf is.rpi()
#' rpi_i2c_dump(0x77)
#'
rpi_i2c_dump <- function(chip_address) {
  # Assumes Serial Data Line (SDA, board pin 3)
  # ...and Serial Clock Line (SCL, board pin 5)
  # ...therefore i2cbus = 1
  i2cbus <- 1

  # chip-address must be an integer between 0x03 and 0x77
  if (missing(chip_address) ||
      chip_address < 0x03 ||
      chip_address > 0x77
  ) {
    stop("You must specify a chip_address as an integer between 0x08 and 0x77")
  }

  gpio_sysCall <- paste("i2cdump -y",
                        i2cbus,
                        chip_address)

  return(as.integer(system(gpio_sysCall, intern = TRUE)))
}
