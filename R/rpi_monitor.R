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
#' Monitor an RPi pin
#'
#' Watch a Raspberry pi GPIO pin (or pins) for changes.
#'
#' @param pin_number one or more pin numbers as found on the Raspberry pi GPIO. Use the actual pin numbers (i.e. 1:40)
#' @param numEvents a number of events to collect. Defaults to 10
#' @param edge rising|falling|both
#'
#' @return a list of events
#'   \itemize{
#'      \item raw text of each event
#'      \item event: RISING EDGE|FALLING EDGE
#'      \item line: the bcm line (not board pin) exhibiting change
#'      \item timestamp: seconds component
#'      \item timestamp: nanoseconds component
#'   }
#' @export
#'
#' @examplesIf is.rpi()
#' \donttest{
#' rpi_monitor(21)
#' rpi_monitor(21, numEvents = 20)
#' }
rpi_monitor <-
  function(pin_number,
           numEvents = 0,
           edge = "both") {
    bcm_line <- rpigpior::rpi_pinToBCM(pin_number)

    gpio_sysCall <- paste(
      "gpiomon",
      if (numEvents != 0) {
        paste0("--num-events=", numEvents)
      } else {
        paste0("--num-events=", 10)
      },
      if (edge == "rising") {
        "--rising-edge"
      } else if (edge == "falling") {
        "--falling-edge"
      } else if (edge == "both") {
      },
      "gpiochip0",
      paste(bcm_line, collapse = " ")
    )

    monitored_events <- system(gpio_sysCall, intern = TRUE)

    myPattern <-
      "event: +([A-Z ]+) offset: (\\d+) timestamp: \\[ (\\d+)\\.(\\d+)\\]"
    rxmatches <- regexec(
      pattern = myPattern,
      text = monitored_events,
      perl = TRUE
    )
    rxvalues <- regmatches(x = monitored_events, m = rxmatches)
    return(rxvalues)
  }
