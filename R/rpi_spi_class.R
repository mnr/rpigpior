# https://www.rcpp.org
# https://rdrr.io/cran/Rcpp/man/cppFunction.html
# https://www.kernel.org/doc/html/latest/driver-api/ioctl.html

# good example
# https://raspberry-projects.com/pi/programming-in-c/spi/using-the-spi-interface

spiIncludes <- c("<fcntl.h>",
                 "<unistd.h>",
                 "<sys/ioctl.h>",
                 "<linux/types.h>",
                 "<linux/spi/spidev.h>"
                )

spi <- new_class("spi",
  properties = list(
	  spiChan = class_integer,
	  spiBus = class_integer,
	  max_speed_hz = new_property(class_integer, default = "1000000"),
	  spiDeviceID = new_property(class_integer, default = "#rpi_spi_open"),
	  tx_buf        = something,
	  rx_buf        = something,
	  len           = count, # length of tx/rx buffers in bytes
	  delay_usecs   = 0,
	  bits_per_word = 8,
	  cs_change     = 0
	  	  ),
	validator = function(self) {
		if (self@spiChan != 0 || self@spiChan != 1) {
			"@spiChan must be zero or one"
		} else if (TRUE) {
			"@spiBus must be something"
		  }
  }

	)

# write.spi ---------------------------------------------------------------
write.spi <- new_generic("rpi_spi_write", x)

method(rpi_spi_write, spi) <- function(x, stringToWrite) {}


# read.spi ----------------------------------------------------------------
read.spi <- new_generic("rpi_spi_read", x)

method(rpi_spi_read, spi) <- function(x) {}
#    err = ioctl(spiDeviceID, SPI_IOC_MESSAGE(1), &spi);



# close  ------------------------------------------------------------------
method(rpi_spi_close, spi) <- cppFunction('int rpi_spi_close(int x) {
                  return close(x@spiDeviceID);
              }',
              includes = spiIncludes
              )
