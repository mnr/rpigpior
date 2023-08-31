# gpiodetect
# list all gpiochips present on the system, their names, labels
# and number of GPIO lines
# https://libgpiod.readthedocs.io/en/latest/index.html
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpiodetect.c

# Usage: %s [OPTIONS] [chip]...\n", get_prog_name());
# List GPIO chips, print their labels and number of GPIO lines.

# Chips may be identified by number, name, or path.
# e.g. '0', 'gpiochip0', and '/dev/gpiochip0' all refer to the same chip.

# If no chips are specified then all chips are listed.

#' Find gpiochips on this system
#'
#' @param aChip Chips may be identified by number, name, or path. e.g. '0', 'gpiochip0', and '/dev/gpiochip0' all refer to the same chip.
#'
#' @return a (list? data.frame? vector?) with name, label, and number of GPIO lines
#' @export
#'
#' @examples
#' gpiodetect()
#' gpiodetect(0)
gpiodetect <- function(aChip = "") {
  gpio_sysCall <- paste("gpiodetect",aChip)
  system(gpio_sysCall, intern = TRUE)
}
