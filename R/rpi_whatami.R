# rpi_whatami returns a data.frame with information about the Raspberry Pi this program is running on

#' rpi_whatami
#'
#' Identify the model of Raspberry Pi this code is running on
#'    including useful environmental information
#'
#' @return
#' A data.frame with information about this RPi
#'
#' If this isn't a Raspberry Pi, ...$is_rpi will be FALSE. In addition, ...$fault will contain the error message
#'
#' If this is a Raspberry Pi, the data frame will contain the following:
#' * ...$is_rpi TRUE if this is a Raspberry Pi
#' * ...$rpi_version "Zero", 1, 2, 3, 4, or 5
#' * ...$gpiochip normally gpiochip0. For RPi 5, returns gpiochip4
#' * ...$i2c_enabled TRUE if i2c is enabled on this RPi
#' * ...$spi_enabled TRUE if spi is enabled on this RPi
#' * ...$gpiod_enabled TRUE if gpiod is installed on this RPi
#'
#' @export
#'
#' @examplesIf rpigpior::rpi_whatami()$is_rpi
#' rpigpior::rpi_whatami()
#'
#'
rpi_whatami <- function() {
  thisIsMe <- data.frame()

  theResult <- tryCatch(
    {
      readLines("/proc/device-tree/model", warn = FALSE)
      resultPieces <- unlist(strsplit(theResult," "))
      thisIsMe$is_rpi <- ifelse(resultPieces[1] == "Raspberry",TRUE,FALSE)
      thisIsMe$rpi_Version <- resultPieces[3] # model

      # define which gpiochip to use
      # all versions of Raspberry Pi use gpiochip0
      # EXCEPT rpi 5, which uses gpiochip4
      if (thisIsMe$rpi_Version == "5") {
        thisIsMe$gpiochip <- "gpiochip4"
      } else {
        thisIsMe$gpiochip <- "gpiochip0"
      }

      thisIsMe$i2c_enabled <- file.exists("/dev/i2c-1")
      thisIsMe$spi_enabled <- file.exists("/dev/spidev0.0")

      thisIsMe$gpiod_enabled <- system("gpiodetect", intern = TRUE) |>
        (\(x) grepl("pinctrl", x))() |>
        any()

      thisIsMe$fault <- ""

    },
    warning = function(w) {
      thisIsMe$is_rpi <- FALSE
      thisIsMe$fault <- w
    },
    error = function(e) {
      thisIsMe$is_rpi <- FALSE
      thisIsMe$fault <- e
    },
    finally = {
      # cleanup
    }
  )

  return(thisIsMe)
}
