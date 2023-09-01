# gpiodetect
# list all gpiochips present on the system, their names, labels
# and number of GPIO lines
# https://libgpiod.readthedocs.io/en/latest/index.html
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpiodetect.c

#' Find gpiochips on this system
#'
#' @return a (list? data.frame? vector?) with name, label, and number of GPIO lines
#' @export
#'
#' @examples
#' gpiodetect()
gpiodetect <- function() {
  return(system("gpiodetect", intern = TRUE))
}
