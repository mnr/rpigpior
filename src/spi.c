/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{																			}
{       Filename: spi.c														}
{       Copyright(c): Leon de Boer(LdB) 2019, 2020							}
{       Version: 1.10														}
{																			}
{***************************************************************************}
{                                                                           }
{     Defines an API interface for the SPI devices on Linux					}
{																            }
{++++++++++++++++++++++++[ REVISIONS ]++++++++++++++++++++++++++++++++++++++}
{  1.00 Initial version														}
{  1.10 Compacted stuct fields  											}
{++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

#include <stdbool.h>			// C standard unit for bool, true, false
#include <stdint.h>				// C standard unit for uint32_t etc
#include <fcntl.h>				// Needed for SPI port
#include <sys/ioctl.h>			// Needed for SPI port
#include <linux/spi/spidev.h>	// Needed for SPI port
#include <unistd.h>				// Needed for SPI port
#include <stdio.h>				// neded for sprintf_s
#include <pthread.h>			// Posix thread unit
#include <semaphore.h>			// Linux Semaphore unit
#include "spi.h"				// This units header

#if SPI_DRIVER_VERSION != 1100
#error "Header does not match this version of file"
#endif

struct spi_device
{
	int spi_fd;									// File descriptor for the SPI device
	uint32_t spi_speed;							// SPI speed
    sem_t lock;									// Semaphore for lock
	struct {
        uint16_t spi_bitsPerWord: 8;			// SPI bits per word
        uint16_t spi_num : 4;					// SPI device table number
        uint16_t _reserved: 2;        			// reserved
		uint16_t uselocks : 1;					// Locks to be used for access
		uint16_t inuse : 1;						// In use flag
	};
};

/* Global table of SPI devices.  */
static struct spi_device spitab[NSPI] = { {0} };

/*-[ SpiOpenPort ]----------------------------------------------------------}
. Creates a SPI handle which provides access to the SPI device number.
. The SPI device is setup to the bits, speed and mode provided.
. RETURN: valid SPI_HANDLE for success, NULL for any failure
.--------------------------------------------------------------------------*/
SPI_HANDLE SpiOpenPort (uint8_t spi_devicenum, uint8_t bit_exchange_size, uint32_t speed, uint8_t mode, bool useLock)
{
	SPI_HANDLE spi = 0;												// Preset null handle
	struct spi_device* spi_ptr = &spitab[spi_devicenum];			// SPI device pointer
	if (spi_devicenum < NSPI && spi_ptr->inuse == 0 && speed != 0)
	{
		spi_ptr->spi_fd = 0;										// Zero SPI file device
		spi_ptr->spi_num = spi_devicenum;							// Hold spi device number
		spi_ptr->spi_bitsPerWord = bit_exchange_size;				// Hold SPI exchange size
		spi_ptr->spi_speed = speed;									// Hold SPI speed setting
		spi_ptr->uselocks = (useLock == true) ? 1 : 0;				// Set use lock
        if (useLock)                                                // Using locks
        {
			sem_init(&spi_ptr->lock, 0, 1);							// Initialize mutex to 1
        }
        uint8_t spi_mode = mode;
		uint8_t spi_bitsPerWord = bit_exchange_size;
        char buf[256] = { 0 };
		sprintf(&buf[0], "/dev/spidev0.%c", (char)(0x30 + spi_devicenum));
		int fd = open(&buf[0], O_RDWR);								// Open the SPI device
		if (fd >= 0)												// SPI device opened correctly
		{
			spi_ptr->spi_fd = fd;									// Hold the file device to SPI
			if (ioctl(spi_ptr->spi_fd, SPI_IOC_WR_MODE, &spi_mode) >= 0 &&
				ioctl(spi_ptr->spi_fd, SPI_IOC_RD_MODE, &spi_mode) >= 0 &&
				ioctl(spi_ptr->spi_fd, SPI_IOC_WR_BITS_PER_WORD, &spi_bitsPerWord) >= 0 &&
				ioctl(spi_ptr->spi_fd, SPI_IOC_RD_BITS_PER_WORD, &spi_bitsPerWord) >= 0 &&
				ioctl(spi_ptr->spi_fd, SPI_IOC_WR_MAX_SPEED_HZ, &spi_ptr->spi_speed) >= 0 &&
				ioctl(spi_ptr->spi_fd, SPI_IOC_RD_MAX_SPEED_HZ, &spi_ptr->spi_speed) >= 0)
			{
				spi_ptr->inuse = 1;									// The handle is now in use
				spi = spi_ptr;										// Return SPI handle
			}
		}
	}
	return(spi);													// Return SPI handle result
}

/*-[ SpiClosePort ]---------------------------------------------------------}
. Given a valid SPI handle the access is released and the handle freed.
. RETURN: true for success, false for any failure
.--------------------------------------------------------------------------*/
bool SpiClosePort (SPI_HANDLE spiHandle)
{
	if (spiHandle && spiHandle->inuse)								// SPI handle valid and SPI handle is in use
	{
		if (spiHandle->uselocks)									// Using locks
		{
			sem_destroy(&spiHandle->lock);							// Destroy lock mutex
		}
		close(spiHandle->spi_fd);									// Close the spi handle
		spiHandle->spi_fd = 0;										// Zero the SPI handle
		spiHandle->spi_num = 0;										// Zero SPI handle number
		spiHandle->inuse = 0;										// The SPI handle is now free
		return true;												// Return success
	}
	return false;													// Return failure
}

/*-[ rpi_spi_WriteAndRead ]------------------------------------------------------}
. Given a valid SPI handle and valid data pointers the call will send and
. receive data to and from the buffer pointers. As the write occurs before
. the read the buffer pointers can be the same buffer space.
. RETURN: >= 0 transfer count for success, < 0 for any error
.--------------------------------------------------------------------------*/
int rpi_spi_WriteAndRead (SPI_HANDLE spiHandle, uint8_t* TxData, uint8_t* RxData, uint16_t Length, bool LeaveCsLow)
{
	int retVal = -1;												// Preset -1
	if (spiHandle && spiHandle->inuse)								// SPI handle valid and SPI handle is in use
	{
		if (spiHandle->uselocks)									// Using locks
		{
			sem_wait(&spiHandle->lock);								// Take semaphore
		}
		struct spi_ioc_transfer spi = { 0 };
		spi.tx_buf = (unsigned long)TxData;							// transmit from "data"
		spi.rx_buf = (unsigned long)RxData;							// receive into "data"
		spi.len = Length;											// length of data to tx/rx
		spi.delay_usecs = 0;										// Delay before sending
		spi.speed_hz = spiHandle->spi_speed;						// Speed for transfer
		spi.bits_per_word = spiHandle->spi_bitsPerWord;				// Bits per exchange
		spi.cs_change = LeaveCsLow;									// 0=Set CS high after a transfer, 1=leave CS set low
		retVal = ioctl(spiHandle->spi_fd, SPI_IOC_MESSAGE(1), &spi);// Execute exchange
		if (spiHandle->uselocks)									// Using locks
		{
			sem_post(&spiHandle->lock);							    // Give semaphore
		}
	}
	return retVal;													// Return result
}

/*-[ rpi_spi_WriteBlockRepeat ]--------------------------------------------------}
. Given a valid SPI handle and valid data pointers the call will send the
. data block repeat times. It is used to speed up things like writing to SPI
. LCD screen with areas a fixed colour.
. RETURN: >= 0 blocks transfered for success, < 0 for any error
.--------------------------------------------------------------------------*/
int rpi_spi_WriteBlockRepeat (SPI_HANDLE spiHandle, uint8_t* TxBlock, uint16_t TxBlockLen, uint32_t Repeats, bool LeaveCsLow)
{
	int retVal = -1;												// Preset -1
	if (spiHandle && TxBlock && spiHandle->inuse)					// SPI handle and TxBlock valid and SPI handle is in use
	{
		if (spiHandle->uselocks)									// Using locks
		{
			sem_wait(&spiHandle->lock);								// Take semaphore
		}
		struct spi_ioc_transfer spi = { 0 };
		spi.tx_buf = (unsigned long)TxBlock;						// transmit from "data"
		spi.rx_buf = (unsigned long)0;          					// receive into "data"
		spi.len = TxBlockLen;										// length of data to tx/rx
		spi.delay_usecs = 0;										// Delay before sending
		spi.speed_hz = spiHandle->spi_speed;						// Speed for transfer
		spi.bits_per_word = spiHandle->spi_bitsPerWord;				// Bits per exchange
		spi.cs_change = LeaveCsLow;									// 0=Set CS high after a transfer, 1=leave CS set low
        retVal = 0;                                                 // Zero retVal
        uint32_t j;
        for (j = 0; j < Repeats && retVal == TxBlockLen; j++)       // For each block repeat
        {
            retVal = ioctl(spiHandle->spi_fd, SPI_IOC_MESSAGE(1), &spi);// Execute exchange
        }
        retVal = j;                                                 // Return block count
		if (spiHandle->uselocks)									// Using locks
		{
			sem_post(&spiHandle->lock);							    // Give semaphore
		}
	}
	return retVal;													// Return result
}
