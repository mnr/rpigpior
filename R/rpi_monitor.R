# rpi_monitor <- function(pin_number) {
#
# }
#
# gpio_sysCall <- paste("gpioget",
#                       if (!gpio_active) {
#                         "--active-low"
#                       },
#                       "--bias",
#                       gpio_bias,
#                       gpio_chip,
#                       paste(gpio_line, collapse = " "))
# return(system(gpio_sysCall, intern = TRUE))
#
# # gpiomon - wait for events on a GPIO line, specify which events to watch, how many events to process before exiting or if the events should be reported to the console
# # https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpiomon.c
#
# gpiomon <- function(active = FALSE,
#                     num_events = 1,
#                     silent = FALSE,
#                     rising_edge = FALSE,
#                     falling_edge = FALSE,
#                     format) {
#
# }
