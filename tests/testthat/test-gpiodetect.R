test_that("gpiodetect returns the gpiochips", {
  # this will obviously fail if libgpiod isn't installed
  skip_if_not(is.rpi(), "gpiodetect - is.rpi() failed")
  expect_no_error( gpiodetect())
})
