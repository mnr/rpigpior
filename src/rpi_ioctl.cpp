#include <Rcpp.h>

#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/types.h>
#include <linux/spi/spidev.h>

using namespace Rcpp;

//' Communicates with the IOCTL module
//'
//' @param spiDeviceID
//' @param Spi_mode
//' @return spiControl

 // [[Rcpp::export]]
int rpi_ioctl(int spiDeviceID, int Spi_mode, Rcpp::List spiControl) {
  status_value = ioctl(spiDeviceID, Spi_mode, spiControl);
  if(status_value < 0)
  {
    perror("Could not set SPIMode (WR)...ioctl fail");
    exit(1);
  }
   */


  return(0);
}
