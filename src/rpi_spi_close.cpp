/*
 * https://forums.raspberrypi.com/viewtopic.php?p=1927979
 * https://www.kernal.org/doc/html/latest/spi/spidev.html
 * https://sigmdel.ca/michael/ha/rpi/dnld/draft_spidev_doc.pdf
 * Public Domain
*/

#include <Rcpp.h>

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <getopt.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/types.h>
#include <linux/spi/spidev.h>

using namespace Rcpp;

//' Close an SPI session
//'
//' @param spiDeviceID An identifier supplied by rpi_spi_open()
//' @return SPI identifier
//' @export
//'
// [[Rcpp::export]]
int spiClose(int spiDeviceID)
{
   return close(spiDeviceID);
}
