# system("gpiomon --num-events=10 0 21", intern=TRUE) returns...
# event:   RISING EDGE offset: 21 timestamp:  [1051165.516409561]
#
# event type RISING EDGE | FALLING EDGE
# timestamp = seconds.nanoseconds
#
# rpi_monitor <- function(pin_number) {
#
# }
#
# gpio_sysCall <- paste("gpiomon",
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
rpi_monitor <- function(pin_number, numEvents = 0, edge = "", timeout = 0) {

  bcm_line <- rpigpior::rpi_pinToBCM(pin_number)

  gpio_sysCall <- paste("gpiomon",
                        if (numEvents != 0 ) {
                          paste0("--num-events=",numEvents)
                        } else {
                          paste0("--num-events=",10)
                        },
                        "--silent",
                        if(edge == "rising") {
                          "--rising-edge"
                        } else if (edge == "falling") {
                          "--falling-edge"
                        },
                        paste(bcm_line, collapse = " "))

  monitored_events <- system(gpio_sysCall, intern = TRUE)

  myPattern <- "event: +([A-Z ]+) offset: (\\d+) timestamp: \\[ (\\d+)\\.(\\d+)\\]"
  rxmatches <- regexec(pattern=myPattern, text=monitored_events, perl=TRUE)
  rxvalues <- regmatches(x=monitored_events, m = rxmatches)
  return(rxvalues)
  }
