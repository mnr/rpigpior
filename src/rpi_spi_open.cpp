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

//' Open an SPI session
//'
//' This assumes the SPI device is attached to bus zero.
//'
//' @param spiChan The SPI channel to use. /dev/spidev[spiBus].[spiChan]
//' @param spiBus The SPI Bus to use, defaults to bus 0.
//' @param max_speed_hz spi transfer speed
//' @return SPI identifier
//' @export
//' @examplesIf is.rpi.spi()
//' spi_identifier <- rpi_spi_open(spiBus = 0, spiChan = 0)
//'
// [[Rcpp::export]]
int rpi_spi_open(unsigned spiChan, unsigned spiBus = 0,
                  unsigned max_speed_hz = 32000000)
{
   int spiDeviceID;
   char theSPIdevice[32];
   char errMessage[100];

   sprintf(theSPIdevice, "/dev/spidev%d.%d", spiBus, spiChan);

   if ((spiDeviceID = open(theSPIdevice, O_RDWR)) < 0)
   {
      // return -1;
      sprintf(errMessage, "Failure to open %s", theSPIdevice);
      Rcpp::stop(errMessage);
   }

   if (ioctl(spiDeviceID, SPI_IOC_WR_MAX_SPEED_HZ, &max_speed_hz) < 0)
   {
      close(spiDeviceID);
      sprintf(errMessage, "Failure to set the speed for %s to %d", theSPIdevice, max_speed_hz);

     Rcpp::stop(errMessage);
      //return -4;
   }

   return spiDeviceID;
}

