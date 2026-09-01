#' DEPRECATED. Use rpi_whatami()$is_rpi instead.
#'
#' Confirm this code is running on a Raspberry Pi
#'
#' Returns TRUE if this code is running on a Raspberry Pi
#'
#' @param whatami defaults to the data.frame returned by rpi_whatami()
#'
#' @return TRUE if running on a Raspberry Pi.
#'
#' @export
#'
#' @examplesIf is.rpi()
#' is.rpi()
is.rpi <- function(whatami = rpi_whatami()) {

  return(whatami$is_rpi)
}
