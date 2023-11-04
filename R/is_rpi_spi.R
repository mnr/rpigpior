#' is SPI enabled on this Raspberry Pi?
#'
#'
#' @return TRUE if running on Raspberry Pi and SPI is enabled
#' @export
#'
#' @examplesIf is.rpi()
#' is.rpi.spi()
is.rpi.spi <- function() {
  theReturnValue <- FALSE

  if(is.rpi() 
     && any(file.exists(Sys.glob("/dev/spi*")))) {
      theReturnValue <- TRUE
    }

  return(theReturnValue)
}
