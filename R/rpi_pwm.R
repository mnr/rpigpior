#' Provide R with access to PWM
#'
#' Provides the R programming language with access to Raspberry Pi hardware Pulse Width Modulation (PWM)
#'
#'     Only two PWM lines are available on the Raspberry Pi - pwm0 and pwm1. Although it is possible to create software PWM, this isn't advised due to latency of linux and R.
#'     It might be helpful to read the article on `rpi_pwm()` located at the [rpigpior website](https://mnr.github.io/rpigpior/articles/rpi_pwm.html).
#'
#' @param pin_number. One or two pins for hardware PWM. Must be 12, 32, 33, or 35.
#'    If two pins are selected, they must be one of these combinations: (12,33), (32,33), (12,35), or (32,35)
#' @param pwm_period. The length of a cycle. aka Frequency
#' @param pwm_dutycycle. The amount of time a cycle is on.
#' @param pwm_debug. If TRUE, checks Raspberry Pi OS settings for PWM and provides diagnostics
#'
#' @return void
#'     `rpi_pwm()` provides extensive error checking. Possible errors include:
#'     \itemize{
#'      \item Invalid PWM pin: Hardware PWM is only supplied to pins 12, 32, 33, or 35.
#'      \item Invalid PWM pin combination: The combination of pins both select PWM0 or PWM1
#'      \item PWM not enabled: This PWM channel is not enabled
#'      \item (see https://mnr.github.io/rpigpior/articles/rpi_pwm.html for fixing errors)
#'      }
#' @export
#'
#' @examplesIf is.rpi()
#' rpi_pwm(12) # provides 50% PWM to pin 12 (PWM0)
#'
#' rpi_pwm(c(12,33), pwm_period = 50000, pwm_dutycycle = 10000) # provides 20% PWM to pin 12 (PWM0) and pin 33 (PWM1)
#'
rpi_pwm <- function(pin_number = 12, pwm_period = 50000, pwm_dutycycle = 25000, pwm_debug = FALSE ) {
  # check that pin_number == 12, 32, 33, or 35 ---------
  if (pwm_debug) {
    for (aPin in pin_number) {
    if(isFALSE(rpigpior::rpi_pin_desc[aPin,"valid_PWM_pair_1"])) {
      stop(paste("Invalid PWM pin:", pin_number, "is not a valid PWM channel. Use 12, 32, 33, or 35"))
    }
    }
  }

  # Check that combinations of pins are one of (12,33), (32,33), (12,35), or (32,35) ------------
  if(pwm_debug && length(pin_number) == 2) {
    if( !(any(c(rpigpior::rpi_pin_desc[pin_number[1],"valid_PWM_pair_1"] == pin_number[2],
                rpigpior::rpi_pin_desc[pin_number[1],"valid_PWM_pair_2"] == pin_number[2])
         ) )
      ) {
           # the pin set isn't a valid combination
           stop(paste("Invalid PWM pin combination:", paste(pin_number, collapse = ","), "is not a valid PWM combination."))
        }

    }

  if (pwm_debug && length(pin_number) > 2) {
    stop("Invalid PWM pin combination: You have specified more than two pins for PWM.")
  }


# Is PWM enabled? ---------------------------------------------------------
  # Check if PWM is enabled and that the correct channels are open
      if (pwm_debug ) {

          # construct the correct dtoverlay string for this pin_number
          dtoverlayString <- if (length(pin_number) == 1) {
                                    paste0("dtoverlay=pwm,",
                                           "pin=", rpigpior::rpi_pinToBCM(pin_number[1]), ",",
                                           "func=", pwm_func(pin_number[1])
                                          )
                                } else {
                                  # pin_number has 2 pins
                                  paste0("dtoverlay=pwm-2chan,",
                                         "pin=", rpigpior::rpi_pinToBCM(pin_number[1]), ",",
                                         "func=", pwm_func(pin_number[1]), ",",
                                         "pin2=", rpigpior::rpi_pinToBCM(pin_number[2]), ",",
                                         "func2=", pwm_func(pin_number[2])
                                        )

                                }

          # is dtoverlayString already in /boot/config.txt ?
          # There might be no version or a different version...
          if (!any(grepl(dtoverlayString, readLines("/boot/config.txt")))) {

          # dtoverlayString contains the string to place in /boot/config.txt
          print(paste("Add this string to /boot/config:", dtoverlayString))
          print("Refer to https://mnr.github.io/rpigpior/articles/rpi_pwm.html#handling-errors")

          stop(paste("PWM not enabled")) }
      }

     # Is the channel or channels exported? -----
       for (aPin in pin_number) {
       if (!(dir.exists(paste0("/sys/class/pwm/pwmchip0/pwm",
                               rpigpior::rpi_pin_desc[aPin,"PWM_channel"]
                               )
                        )
            )
       ) {
         # if not enabled, do so by sending...
         # sudo echo 0 > /sys/class/pwm/pwmchip0/export

         gpio_sysCall <- paste("echo",
                               rpigpior::rpi_pin_desc[aPin,"PWM_channel"],
                               "> /sys/class/pwm/pwmchip0/export")
         system(gpio_sysCall, intern = TRUE)
       }
     }

  for (aPin in pin_number) {
      # start PWM ---------
      # sudo echo 50000 > /sys/class/pwm/pwmchip0/pwm0/period
      gpio_sysCall <- paste0("echo ",
                            pwm_period,
                            " > /sys/class/pwm/pwmchip0/pwm",
                            rpigpior::rpi_pin_desc[aPin,"PWM_channel"],
                            "/period"
                      )
      system(gpio_sysCall, intern = TRUE)
      if(pwm_debug) print(gpio_sysCall)

      # sudo echo 25000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
      gpio_sysCall <- paste0("echo ",
                             pwm_dutycycle,
                             " > /sys/class/pwm/pwmchip0/pwm",
                             rpigpior::rpi_pin_desc[aPin,"PWM_channel"],
                             "/duty_cycle"
      )
      system(gpio_sysCall, intern = TRUE)
      if(pwm_debug) print(gpio_sysCall)

      # sudo echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
      gpio_sysCall <- paste0("echo 1 > /sys/class/pwm/pwmchip0/pwm",
                             rpigpior::rpi_pin_desc[aPin,"PWM_channel"],
                             "/enable"
      )
      system(gpio_sysCall, intern = TRUE)
      if(pwm_debug) print(gpio_sysCall)

  }
} # end of rpi_pwm


pwm_func <- function(pin_number) {
  # helper function to convert pin to pwm function
  switch (as.character(pin_number),
          "12" = "2", # GPIO18, PWM0
          "32" = "4", # GPIO12, PWM0
          "33" = "4", # GPIO13, PWM1
          "35" = "2"  # GPIO19, PWM1
) }


# do we need to disable audio? ---------
# Sound must be disabled to use GPIO18.
# This can be done in /boot/config.txt by changing "dtparam=audio=on"
# to "dtparam=audio=off" and rebooting.
# Failing to do so can result in a segmentation fault.


