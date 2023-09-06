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

  if (theResult) {
    # theResult contains os-release
    if (onlyThis == "IsThisRPI") {
      theReturnValue <- c(TRUE, theResult)
    } else {
      theReturnValue <- c(TRUE, theResult[theResult[1] == onlyThis,])
    }
  }
  else {
    # theResult contains FALSE
    theReturnValue <- c(FALSE, "")
  }

  return(theReturnValue)

}
