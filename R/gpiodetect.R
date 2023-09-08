# gpiodetect
# list all gpiochips present on the system, their names, labels
# and number of GPIO lines
# https://libgpiod.readthedocs.io/en/latest/index.html
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpiodetect.c

#' Find gpiochips on this system
#'
#' @return a chr vector with name, label, and number of GPIO lines. Typically this will return something like the following:
#'     gpiochip0 [pinctrl-bcm2711] (58 lines)
#'     gpiochip1 [raspberrypi-exp-gpio] (8 lines)
#'
#' @export
#'
#' @examplesIf is.rpi()
#' gpiodetect()
gpiodetect <- function() {
  gpio_sysCall <- "gpiodetect"
  system(gpio_sysCall,
                intern = TRUE,
                ignore.stdout = TRUE,
                ignore.stderr = TRUE)
}
