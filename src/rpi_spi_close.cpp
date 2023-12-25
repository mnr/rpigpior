// based on https://github.com/wargio/spidev/tree/master
using namespace Rcpp;
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

typedef struct _spi{
  int dev;
  uint8_t mode;
  uint8_t bits;
  uint32_t speed;
}spi;

void rpi_spi_close(spi* s);

// [[Rcpp::export]]
void rpi_spi_close(spi* s){
  assert(s && s->dev>=0);
  s->dev   = -1;
  close(s->dev);
}
