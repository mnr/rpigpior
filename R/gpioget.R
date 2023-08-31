# gpioget - read values of specified GPIO lines
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpioget.c
# https://kernel.googlesource.com/pub/scm/libs/libgpiod/libgpiod/+/v0.2.x/README.md

# Usage: %s [OPTIONS] <line>...\n", get_prog_name());

# Read values of GPIO lines.

# Lines are specified by name, or optionally by offset if the chip option
# is provided.

# Options:
#   -a, --as-is    leave the line direction unchanged, not forced to input
# print_bias_help();
#       --by-name    treat lines as names even if they would parse as an offset
#   -c, --chip <chip> restrict scope to a particular chip
#   -C, --consumer <name>. consumer name applied to requested lines (default is 'gpioget')
#   -h, --help    display this help and exit
#   -l, --active-low. treat the line as active low
#   -p, --hold-period <period>
#       wait between requesting the lines and reading the values
#       --numeric    display line values as '0' (inactive) or '1' (active)
#   -s, --strict    abort if requested line names are not unique
#       --unquoted. don't quote line names
#   -v, --version    output version information and exit
#' gpioget
#'
#' @param gpio_line
#' @param gpio_chip
#' @param gpio_active
#'
#' @return
#' @export
#'
#' @examples
#' read the value of a single gpio line
#' gpioget gpiochip1 23
#' Read two values at the same time. Set the active state of the lines to low.
#' gpioget --active-low gpiochip1 23 24
gpioget <- function(gpio_chip,
                    gpio_active = FALSE,
                    gpio_line) {
  gpio_sysCall <- paste("gpiodetect",gpio_chip, gpio_line,
                        ifelse(gpio_active, "", "--active-low"))
  system(gpio_sysCall, intern = TRUE)
}
