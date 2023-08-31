# gpioset - set values of specified GPIO lines, potentially keep the lines exported and wait until timeout, user input or signal
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpioset.c
# https://lloydrochester.com/post/hardware/libgpiod-intro-rpi/

# Usage: %s [OPTIONS] <line=value>...\n", get_prog_name());

# Set values of GPIO lines.

# Lines are specified by name, or optionally by offset if the chip option
# is provided.
# Values may be '1' or '0', or equivalently 'active'/'inactive' or 'on'/'off'.

# The line output state is maintained until the process exits, but after that
# is not guaranteed.

# Options:
#       --banner    display a banner on successful startup
# print_bias_help();
#       --by-name    treat lines as names even if they would parse as an offset
#   -c, --chip <chip>  restrict scope to a particular chip
#   -C, --consumer <name>  consumer name applied to requested lines (default is 'gpioset')
#   -d, --drive <drive>  specify the line drive mode
#       Possible values: 'push-pull', 'open-drain', 'open-source'.
#       (default is 'push-pull')
#   -h, --help    display this help and exit
#ifdef GPIOSET_INTERACTIVE
#   -i, --interactive  set the lines then wait for additional set commands
#       Use the 'help' command at the interactive prompt to get help
#       for the supported commands.
#endif
#   -l, --active-low  treat the line as active low
#   -p, --hold-period <period>
#       the minimum time period to hold lines at the requested values
#   -s, --strict    abort if requested line names are not unique
#   -t, --toggle <period>[,period]...
#       toggle the line(s) after the specified period(s)
#       If the last period is non-zero then the sequence repeats.
#       --unquoted  don't quote line names
#   -v, --version    output version information and exit
#   -z, --daemonize  set values then detach from the controlling terminal
#print_chip_help();
#print_period_help();

# *Note*
#     The state of a GPIO line controlled over the character device reverts to default
#     when the last process referencing the file descriptor representing the device file exits.
#     This means that it's wrong to run gpioset, have it exit and expect the line to continue
#     being driven high or low. It may happen if given pin is floating but it must be interpreted
#     as undefined behavior.
gpioset <- function(version = FALSE,
                    active_low = FALSE,
                    mode = "exit",
                    sec = 0,
                    usec = 0,
                    background = FALSE) {

}
