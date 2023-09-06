#' is.rpi()
#'
#' @param onlyThis Returns this value if specified.
#'
#' @return If `onlyThis` is specified, returns that value. Otherwise returns TRUE if running on a Raspberry Pi
#' @export
#'
#' @examples
#' is.rpi()
is.rpi <- function(onlyThis = "IsThisRPI") {
  theResult <- tryCatch({
    read.table("/etc/os-release", sep = "=")
  },
  warning = function(w) {
    FALSE
  },
  error = function(e) {
    FALSE
  },
  finally = {
    #cleanup
  })

  if (onlyThis == "IsThisRPI") {
    if (isFALSE(theResult)) {
      # theResult contains FALSE
      theReturnValue <- FALSE
    } else {
      theReturnValue <- TRUE
    }
  } else {
    theReturnValue <- theResult[theResult[1] == onlyThis,2]
  }

  return(theReturnValue)
}
