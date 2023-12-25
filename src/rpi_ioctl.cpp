// ioctl documentation at https://www.man7.org/linux/man-pages/man2/ioctl.2.html

#include <Rcpp.h>

#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/types.h>
#include <linux/spi/spidev.h>

#include <string.h>
#include <errno.h>

using namespace Rcpp;

//' Communicates with the IOCTL module
//'
//' The ioctl() system call manipulates the underlying device
//'      parameters of special files.  In particular, many operating
//'     characteristics of character special files (e.g., terminals) may
//'     be controlled with ioctl() requests.
//'
//' @param spiDeviceID an open file descriptor.
//' @param ioctlRequest A device-dependent request code. For the sake of Rcpp
//'      interface, an int is passed in, then used to look up the
//'      actual value. Macros and defines used in specifying an ioctl()
//'      request are located in the file <sys/ioctl.h>
//' @param spiControl an untyped pointer to memory
//' @return ioctl_value a list containing...
//' \itemize{
//'   \item status_value - a possible return value or -1 if there was an error
//'   \item errno - if status_value == -1, then errno equals the error number
//'   \item status_message - if status_value == -1, the error message
//' }

 // [[Rcpp::export]]
Rcpp::List rpi_ioctl(int spiDeviceID, Rcpp::String ioctlRequest, Rcpp::List spiControl) {

  status_value = ioctl(spiDeviceID, ioctlRequest, spiControl);

  if (status_value < 0) {
    spiControl.status_value = status_value;
    spiControl.status_msg = strerror(errno)
    } ;

  return(spiControl);
}
