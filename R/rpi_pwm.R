#' Provide R with access to PWM
#'
#' Provides the R programming language with access to Raspberry Pi hardware Pulse Width Modulation (PWM)
#'
#'     Only two PWM lines are available on the Raspberry Pi - pwm0 and pwm1. Although it is possible to create software PWM, this isn't advised due to latency of linux and R.
#'     It might be helpful to read the article on `rpi_pwm()` located at the [rpigpior website](https://mnr.github.io/rpigpior/articles/rpi_pwm.html).
#'
#' @param pin_number. Select one or two of four hardware PWM lines (12, 32, 33, or 35). Generates an error message if a pwm channel is selected twice.
#'     Since PWM0 appears on both pins 12 and 32, and PWM1 appears on pins 33 and 35, a valid selection of two pins is one from PWM0 and one from PWM1.
#'     In other words, only these combinations are valid:
#'     \itemize{
#'        \item pin_number = c(12,33)
#'        \item pin_number = c(32,33)
#'        \item pin_number = c(12,35)
#'        \item pin_number = c(32,35)
#'     }
#'
#' @param mode. An activity related to PWM
#'
#'     \itemize{
#'      \item help. Prints an informative message
#'      \item enable. Prints instructions for enabling the selected PWM pin. This requires root access which R doesn't have
#'    }
#'
#' @return void
#' @export
#'
#' @examplesIf is.rpi()
#'
#'
rpi_pwm <- function(pin_number = 12, mode = "help") {
  # check that pin_number == 12, 32, 33, or 35
  for (aPin in pin_number) {
    if(!rpigpior::rpi_pin_desc[aPin,"valid_PWM_pair_1"]) {
      stop(paste(pin_number, "is not a valid PWM channel. Use 12, 32, 33, or 35"))
    }
  }

  # Check that combinations of pins are one of (12,33), (32,33), (12,35), or (32,35)
  if(length(pin_number) == 2) {
    if(! (rpigpior::rpi_pin_desc[pin_number[1,"valid_PWM_pair_1"]] == pin_number[2]
          || rpigpior::rpi_pin_desc[pin_number[1,"valid_PWM_pair_2"]] == pin_number[2]
         )
      ) {
           # the pin set isn't a valid combination
           stop(paste(pin_number, "is not a valid PWM combination."))
        }

    }

  if (length(pin_number > 2)) {
    stop("You have specified more than two pins for PWM.")
  }
} # end of rpi_pwm

#
#   # mode == "enable" --------------------------------------------------------
#   # Print a message that describes how to enable a pin
#   # first, check /boot/config.txt for "dtoverlay=pwm"
#   # if "dtoverlay=pwm" isn't present, instruct user on how to enable
#   dtoverlayString <- if (length(pin_number) > 1) {
#     "dtoverlay=pwm-2chan"
#   } else {
#     "dtoverlay=pwm"
#   }
#
#   dtoverlayCommand <- paste0(dtoverlayString, ",")
#
#   for(aPin in pin_number) {
#       dtoverlayCommand <- paste0(dtoverlayCommand,
#                                 "pin=", rpigpior::rpi_pinToBCM(aPin), ",",
#                                 "func=", pwm_func(aPin), ","
#                                 )
#   }
#   dtoverlayCommand <- substring(dtoverlayCommand, first = 0, last=nchar(dtoverlayCommand)-1)# remove trailing comma
#
#   print(dtoverlayCommand) # dtoverlayCommand contains the string to place in /boot/config.txt
#
# # end of mode=enable
#
#
#
#
# pwm_func <- function(pin_number) {
#   # helper function to convert pin to pwm function
#   switch (as.character(pin_number),
#           "12" = "2", # GPIO18, PWM0
#           "32" = "4", # GPIO12, PWM0
#           "33" = "4", # GPIO13, PWM1
#           "35" = "2"  # GPIO19, PWM1
# ) }
