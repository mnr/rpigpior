test_that("gpiodetect returns the gpiochips", {
  # this will obviously fail if libgpiod isn't installed
  expect_no_error(
    if (is.rpi()) {
      gpiodetect()
      })
})
