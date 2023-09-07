#' Returns TRUE if this code is running on a Raspberry Pi
#'
#' Confirm this code is running on a Raspberry Pi or return information about the operating system.
#'
#' @param onlyThis If no value is passed, is.rpi() will return a logical
#'
#'     If specified, `is.rpi()` will return the value for that field in /etc/os-release.
#'
#'     PRETTY_NAME is a concatenation of NAME, VERSION_ID, VERSION
#'
#'     NAME is the name of the OS, typically "Raspbian GNU/LINUX"
#'
#'     VERSION_ID is the version. Currently = 11
#'
#'     VERSION is a concatenation of VERSION_ID and (VERSION_CODENAME)
#'
#'     VERSION_CODENAME is the OS Name. Currently = "bullseye"
#'
#'     ID is the OS. Currently = "raspbian"
#'
#'     ID_LIKE is the OS base. Currently = "debian"
#'
#'     HOME_URL Currently = "http://www.raspbian.org"
#'
#'     SUPPORT_URL Currently = "http://www.raspbian.org/RaspbianForums"
#'
#'     BUG_REPORT Currently = "http://www.raspbian.org/RaspbianBugs"
#
#'
#' @return If `onlyThis` is specified, returns that value. Otherwise returns TRUE if running on a Raspberry Pi
#' @export
#'
#' @examplesIf is.rpi()
#' is.rpi()
#' is.rpi("NAME")
is.rpi <- function(onlyThis = "IsThisRPI") {
  theResult <- tryCatch({
    utils::read.table("/etc/os-release", sep = "=")
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
