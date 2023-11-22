spiIncludes <- c("<sys/ioctl.h>",
                 "<linux/types.h>",
                 "<linux/spi/spidev.h>"
                )

spi <- new_class("spi",
  properties = list(
	  spiChan = class_integer,
	  spiBus = class_integer,
	  max_speed_hz = new_property(class_integer, default = "???defaultvalue???"),
	  spiDeviceID = new_property(class_integer, default = "#rpi_spi_open")
	  )
,
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


# close  ------------------------------------------------------------------
method(rpi_spi_close, spi) <- function(x) {
  cppFunction('int rpi_spi_close(int x) {
                  return close(x@spiDeviceID);
              }',
              includes = spiIncludes
              )}
