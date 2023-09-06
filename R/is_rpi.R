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
  theResult = tryCatch({read.table("/etc/os-release3", sep="=")},
                        warning = function(w) {print("warning")},
                        error = function(e) {print("error")},
                        finally = {print("cleanup")})

  return(theResult)
  #return(tmpVal[tmpVal[1]==onlyThis,])

}
