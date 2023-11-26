#include <Rcpp.h>

#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/types.h>
#include <linux/spi/spidev.h>

using namespace Rcpp;

//' Communicates with the IOCTL module
//'
//' @param spiDeviceID
//' @param SpiMode
//' @return spiControl

 // [[Rcpp::export]]
int rpi_ioctl(int spiDeviceID, int spiMode, Rcpp::List spiControl) {
  status_value = ioctl(spiDeviceID, spiMode, spiControl);
  if(status_value < 0)
  {
    perror("Could not set SPIMode (WR)...ioctl fail");
    exit(1);
  }
   */


  return(0);
}
