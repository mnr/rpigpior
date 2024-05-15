#' Confirm this code is running on a Raspberry Pi
#'
#' Returns TRUE if this code is running on a Raspberry Pi
#'
#' @param tellme if TRUE the is.rpi will return the device-tree/model.
#'     This typically looks like "Raspberry Pi 5 Model B Rev 1.0"
#'
#' @return TRUE if running on a Raspberry Pi.
#'          if tellme = TRUE, return the model string
#' @export
#'
#' @examplesIf is.rpi()
#' is.rpi()
is.rpi <- function(tellme = FALSE) {
  # First, test for presence of /proc/device-tree/model
  theResult <- tryCatch(
    {
      readLines("/proc/device-tree/model", warn = FALSE)
    },
    warning = function(w) {
      FALSE
    },
    error = function(e) {
      FALSE
    },
    finally = {
      # cleanup
    }
  )

  if (tellme == FALSE) {
    if (isFALSE(theResult)) {
      # /proc/device-tree/model wasn't found so this isn't Raspbian
      theReturnValue <- FALSE
    } else {
      # /proc/device-tree/model ?= Raspberry
      if (grepl("Raspberry", theResult)) {
        theReturnValue <- TRUE
      } else {
        # /proc/device-tree/model is present, but this isn't Raspberry Pi
        # It might be a different version of debian
        theReturnValue <- FALSE
      }
    }
  } else {
    # someone wants to know specifics about this RPi
    theReturnValue <- theResult
  }

  return(theReturnValue)
}
