// based on https://github.com/wargio/spidev/tree/master
// http://adv-r.had.co.nz/Rcpp.html
// data types: https://teuder.github.io/rcpp4everyone_en/070_data_types.html
#include <Rcpp.h>
#include <unistd.h>

#include <string.h>
#include <stdint.h>

#include <stdio.h>
#include <time.h>
#include <assert.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/types.h>
#include <linux/spi/spidev.h>

using namespace Rcpp;

typedef struct _spi{
  int dev;
  uint8_t mode;
  uint8_t bits;
  uint32_t speed;
}spi;

// [[Rcpp::export]]
void rpi_spi_close(int spi_device){
  close(spi_device);
}
