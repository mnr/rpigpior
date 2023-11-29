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

//' Read data from an SPI device
//'
//' @param spiDeviceID An identifier supplied by rpi_spi_open()
//' @param speed
//' @return SPI identifier
//' @export
//'
// [[Rcpp::export]]
int rpi_spi_read(int spiDeviceID)
{

  int err;
  struct spi_ioc_transfer spi;

  memset(&spi, 0, sizeof(spi));

   spi.tx_buf        = (unsigned) NULL;
   spi.rx_buf        = (unsigned) buf;
   spi.len           = count; // length of tx/rx buffers in bytes
   spi.speed_hz      = speed;
   spi.delay_usecs   = 0;
   spi.bits_per_word = 8;
   spi.cs_change     = 0;

   err = ioctl(spiDeviceID, SPI_IOC_MESSAGE(1), &spi);

   return err;
}

/*
 *   errors
 * EBADF  fd is not a valid file descriptor.

       EFAULT argp references an inaccessible memory area.

       EINVAL request or argp is not valid.

       ENOTTY fd is not associated with a character special device.

       ENOTTY The specified request does not apply to the kind of object
              that the file descriptor fd references.
 */
