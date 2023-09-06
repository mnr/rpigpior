#' is.rpi()
#'
#' @return TRUE if running on a Raspberry Pi
#' @export
#'
#' @examples
#' is.rpi()
is.rpi <- function(onlyThis = "NAME") {
  system("cat /etc/os-release", intern = TRUE) |>
    grep(paste0("^",onlyThis,"=")) |>
    strsplit(split = "=") |>
    unlist()
}
