// based on https://github.com/wargio/spidev/tree/master
#include <Rcpp.h>
#include <unistd.h>
#include <stdlib.h>

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

# define RX_LEN 3

typedef struct _spi{
  int dev;
  uint8_t mode;
  uint8_t bits;
  uint32_t speed;
}spi;

int  spi_open(spi* s, const char* device);
void spi_close(spi* s);
int  spi_getadc(spi* s, int channel);

// [[Rcpp::export]]
Rcpp::NumericVector rpi_spi_cpp_read() {
  printf("MCP3008 Example\n");
  spi s;
  spi_open(&s, "/dev/spidev0.0");
  int ret, ch = 0;
  while(ch < 8){
    ret = spi_getadc(&s, ch);
    printf("channel: %d got: %d/1023\n", ch, ret);
    ++ch;
  }
  spi_close(&s);
  return 0;

}


int spi_open(spi* s, const char* device){
  assert(s);
  s->dev   = -1;
  s->mode  = SPI_MODE_0;
  s->bits  = 8;
  s->speed = 1000000;

  int ret = -1;
  ret = open(device, O_RDWR);
  if(ret < 0){
    printf("can't open the device '%s'\n", device);
    return 1;
  }

  s->dev = ret;
  ret = ioctl(s->dev, SPI_IOC_WR_MODE, &s->mode);
  if(ret < 0){
    printf("can't set spi mode 'SPI_IOC_WR_MODE'\n");
    return 1;
  }

  ret = ioctl(s->dev, SPI_IOC_RD_MODE, &s->mode);
  if(ret < 0){
    printf("can't set spi mode 'SPI_IOC_RD_MODE'\n");
    return 1;
  }

  ret = ioctl(s->dev, SPI_IOC_WR_BITS_PER_WORD, &s->bits);
  if(ret < 0){
    printf("can't set bits per word 'SPI_IOC_WR_BITS_PER_WORD'\n");
    return 1;
  }

  ret = ioctl(s->dev, SPI_IOC_RD_BITS_PER_WORD, &s->bits);
  if(ret < 0){
    printf("can't get bits per word 'SPI_IOC_RD_BITS_PER_WORD'\n");
    return 1;
  }

  ret = ioctl(s->dev, SPI_IOC_WR_MAX_SPEED_HZ, &s->speed);
  if(ret < 0){
    printf("can't set max speed hz 'SPI_IOC_WR_MAX_SPEED_HZ'\n");
    return 1;
  }

  ret = ioctl(s->dev, SPI_IOC_RD_MAX_SPEED_HZ, &s->speed);
  if(ret < 0){
    printf("can't get max speed hz 'SPI_IOC_RD_MAX_SPEED_HZ'\n");
    return 1;
  }

  printf("spi mode: %d\n", s->mode);
  printf("bits per word: %d\n", s->bits);
  printf("max speed: %d Hz (%d KHz)\n", s->speed, s->speed/1000);

  return 0;
}

void spi_close(spi* s){
  assert(s && s->dev>=0);
  s->dev   = -1;
  close(s->dev);
}

int spi_getadc(spi* s, int channel){
  assert(s && s->dev >= 0);
  if(channel < 0 && channel >7)
    return -1;
  int ret;

  struct spi_ioc_transfer xfer[3];
  uint8_t buf[RX_LEN] = {1, 128 | (channel << 4), 0};
  memset(xfer, 0, sizeof(struct spi_ioc_transfer)*3);

  xfer[0].tx_buf = (unsigned long) &buf[0];
  xfer[0].rx_buf = (unsigned long) &buf[0];
  xfer[0].len           = 1;
  xfer[0].speed_hz      = s->speed;
  xfer[0].bits_per_word = s->bits;

  xfer[1].tx_buf = (unsigned long) &buf[1];
  xfer[1].rx_buf = (unsigned long) &buf[1];
  xfer[1].len = 1;
  xfer[1].speed_hz      = s->speed;
  xfer[1].bits_per_word = s->bits;

  xfer[2].tx_buf = (unsigned long) &buf[2];
  xfer[2].rx_buf = (unsigned long) &buf[2];
  xfer[2].len           = 1;
  xfer[2].speed_hz      = s->speed;
  xfer[2].bits_per_word = s->bits;

  ret = ioctl(s->dev, SPI_IOC_MESSAGE(3), xfer);
  if(ret < 0){
    printf("SPI_IOC_MESSAGE failed.. %d\n", ret);
    return -1;
  }

  ret  = (((uint32_t)buf[1])<< 8) & 0b1100000000;
  ret |= (buf[2] & 0xff);
  return ret;
}
