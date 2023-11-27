test_that("rpi_i2c_get works", {
  skip_if_not(is.rpi())
  expect_no_error(rpi_i2c_get(chip_address = 0x09,
                              data_address = 0xf0,
                              data_size = "b"))
})

test_that("rpi_i2c_get err chip address", {
  skip_if_not(is.rpi())
  expect_error(rpi_i2c_get(chip_address = 0x07,
                           data_address = 0xf0,
                           data_size = "b"))
})

test_that("rpi_i2c_get err data address", {
  skip_if_not(is.rpi())
  expect_error(rpi_i2c_get(chip_address = 0x09,
                           data_address = 0xFFF,
                           data_size = "b"))
})

test_that("rpi_i2c_get err data size", {
  skip_if_not(is.rpi())
  expect_error(rpi_i2c_get(chip_address = 0x09,
                           data_address = 0xf0,
                           data_size = "x"))
})
