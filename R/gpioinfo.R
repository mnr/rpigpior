# gpioinfo - list all lines of specified gpiochips, their names, consumers, direction, active state and additional flags
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpioinfo.c

# Usage: %s [OPTIONS] [line]...\n", get_prog_name());

# Print information about GPIO lines.

# Lines are specified by name, or optionally by offset if the chip option
# is provided.

# If no lines are specified then all lines are displayed.

# Options:
#       --by-name    treat lines as names even if they would parse as an offset
#   -c, --chip <chip>\trestrict scope to a particular chip
#   -h, --help    display this help and exit
#   -s, --strict    check all lines - don't assume line names are unique
#       --unquoted\tdon't quote line or consumer names
#   -v, --version    output version information and exit
#' gpioinfo
#'
#' @param gpio_chip
#'
#' @return
#' @export
#'
#' @examples
gpioinfo <- function(gpio_chip) {
  gpio_sysCall <- paste("gpioinfo",gpio_chip)
  system(gpio_sysCall, intern = TRUE)
}
