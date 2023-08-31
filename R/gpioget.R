# gpioget - read values of specified GPIO lines
# https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/tree/tools/gpioget.c

# Usage: %s [OPTIONS] <line>...\n", get_prog_name());

# Read values of GPIO lines.

# Lines are specified by name, or optionally by offset if the chip option
# is provided.

# Options:
#   -a, --as-is    leave the line direction unchanged, not forced to input
print_bias_help();
#       --by-name    treat lines as names even if they would parse as an offset
#   -c, --chip <chip>\trestrict scope to a particular chip
#   -C, --consumer <name>\tconsumer name applied to requested lines (default is 'gpioget')
#   -h, --help    display this help and exit
#   -l, --active-low\ttreat the line as active low
#   -p, --hold-period <period>
#     \twait between requesting the lines and reading the values
#       --numeric    display line values as '0' (inactive) or '1' (active)
#   -s, --strict    abort if requested line names are not unique
#       --unquoted\tdon't quote line names
#   -v, --version    output version information and exit
