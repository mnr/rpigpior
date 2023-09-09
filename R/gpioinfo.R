# gpioinfo - list all lines of specified gpiochips, their names, consumers, direction, active state and additional flags
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpioinfo.c

#' List all lines of a gpio chip
#'
#' List all lines of specified gpio chips, their names, consumers, direction, active state and additional flags
#'
#' @param gpio_chip The GPIO chip to search. Probably 0, 1, or something like gpiochip0
#'
#' @return a data.frame. The first row identifies the chip and number of lines.
#'     The following rows identify line number, line name, used/unused status, input/output, active-high/active-low.
#'
#' @export
#'
#' @examplesIf is.rpi()
#' gpioinfo(0)
gpioinfo <- function(gpio_chip) {
  # read gpio info
  gpio_sysCall <- paste("gpioinfo",gpio_chip)
  allLines <- system(gpio_sysCall, intern = TRUE)

  # set up receiver data.frame
  df_forReturn_names <- c("line","name","usedUnused","input_output","active")
  df_forReturn <- data.frame(matrix(ncol = length(df_forReturn_names), nrow = 0))
  names(df_forReturn) <- df_forReturn_names

  # read each line into df_forReturn
  for(aLine in allLines) {
    gInfoLine <- substr(aLine, start = 8, stop = 10)
    gInfoName <- substr(aLine, start = 11, stop = 28)
    gInfoUsedUnused <- substr(aLine, start = 30, stop = 36)
    gInfoInOut <- substr(aLine, start = 37, stop = 43)
    gInfoActive <- substr(aLine, start = 44, stop = 54)

    tmpDF <- data.frame(gInfoLine, gInfoName, gInfoUsedUnused, gInfoInOut, gInfoActive)
    df_forReturn <- rbind(df_forReturn, tmpDF)
  }
  return(df_forReturn)
}
