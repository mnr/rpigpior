#' Returns TRUE if this code is running on a Raspberry Pi
#'
#' Confirm this code is running on a Raspberry Pi or return information about the operating system.
#'
#' @param onlyThis If no value is passed to onlyThis, is.rpi() will return a logical
#'
#'     If 'onlyThis' is specified, 'is.rpi()' will return the value for that field in /etc/os-release.
#'
#'     - PRETTY_NAME is a concatenation of NAME, VERSION_ID, VERSION
#'
#'     - NAME is the name of the OS, typically "Raspbian GNU/LINUX"
#'
#'     - VERSION_ID is the version. Currently = 11
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
  # First, test for presence of /etc/os-release
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
      # /etc/os-release wasn't found so this isn't Raspbian
      theReturnValue <- FALSE
    } else {
      # /etc/os-release was found, so this is at least debian
      osname <- theResult[theResult[1] == "ID",2]
      if (osname == "raspbian") {
        # /etc/os-release is present and this is raspbian
        theReturnValue <- TRUE
      } else {
        # /etc/os-release is present, but this isn't raspbian
        # It might be a different version of debian
        theReturnValue <- FALSE
      }
    }
  } else {
    # someone wants to know specifics about this RPi
    theReturnValue <- theResult[theResult[1] == onlyThis,2]
  }

  return(theReturnValue)
}
