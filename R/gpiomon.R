# gpiomon - wait for events on a GPIO line, specify which events to watch, how many events to process before exiting or if the events should be reported to the console
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpiomon.c

# Usage: %s [OPTIONS] <line>...\n", get_prog_name());

# Wait for events on GPIO lines and print them to standard output.

# Lines are specified by name, or optionally by offset if the chip option
# is provided.

# Options:
#       --banner    display a banner on successful startup
# print_bias_help();
#       --by-name    treat lines as names even if they would parse as an offset
#   -c, --chip <chip>\trestrict scope to a particular chip
#   -C, --consumer <name>\tconsumer name applied to requested lines (default is 'gpiomon')
#   -e, --edges <edges>\tspecify the edges to monitor
#       Possible values: 'falling', 'rising', 'both'.
#       (default is 'both')
#   -E, --event-clock <clock>
#       specify the source clock for event timestamps
#       Possible values: 'monotonic', 'realtime', 'hte'.
#       (default is 'monotonic')
#       By default 'realtime' is formatted as UTC, others as raw u64.
#   -h, --help    display this help and exit
#   -F, --format <fmt>\tspecify a custom output format
#       --idle-timeout <period>
#       exit gracefully if no events occur for the period specified
#   -l, --active-low\ttreat the line as active low, flipping the sense of
#       rising and falling edges
#       --localtime\tformat event timestamps as local time
#   -n, --num-events <num>
#       exit after processing num events
#   -p, --debounce-period <period>
#       debounce the line(s) with the specified period
#   -q, --quiet    don't generate any output
#   -s, --strict    abort if requested line names are not unique
#       --unquoted\tdon't quote line or consumer names
#       --utc    format event timestamps as UTC (default for 'realtime')
#   -v, --version    output version information and exit
# print_chip_help();
# We print_period_help();

# Format specifiers:
#   %%o   GPIO line offset
#   %%l   GPIO line name
#   %%c   GPIO chip name
#   %%e   numeric edge event type ('1' - rising or '2' - falling)
#   %%E   edge event type ('rising' or 'falling')
#   %%S   event timestamp as seconds
#   %%U   event timestamp as UTC
#   %%L   event timestamp as local time
gpiomon <- function(active = FALSE,
                    num_events = 1,
                    silent = FALSE,
                    rising_edge = FALSE,
                    falling_edge = FALSE,
                    format) {

}
