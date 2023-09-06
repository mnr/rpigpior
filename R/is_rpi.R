#' is.rpi()
#'
#' @return TRUE if running on a Raspberry Pi
#' @export
#'
#' @examples
#' is.rpi()
is.rpi <- function(onlyThis = "NAME") {
  tmpVal <- system("cat /etc/os-release", intern = TRUE)
  tmpVal <- grep(paste0("^",onlyThis,"="), x = tmpVal)
  tmpVal <- strsplit(tmpVal, split = "=")
  tmpVal <- unlist(tmpVal)
  return(tmpVal)
}
