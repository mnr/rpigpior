spi <- new_class("spi", properties = list(
	spiChan = class_integer,
	spiBus = class_integer,
	max_speed_hz = class_integer
),
	validator = function(self) {
		if (self@spiChan != 0 || self@spiChan != 1) {
			"@spiChan must be zero or one"}
		} else if (TRUE) {
			"@spiBus must be something"}
	)

method(open, spi) <- function(x) {}

method(write, spi) <- function(x) {}

method(read, spi) <- function(x) {}

method(close, spi) <- function(x) {}
