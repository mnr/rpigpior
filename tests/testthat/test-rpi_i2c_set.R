test_that("rpi_i2c_set", {
  skip_if_not(is.rpi(), message = "Not a Raspberry Pi")
  expect_error(rpi_i2c_set(1), info = "rpi_i2c_set(1) isn't valid")
})
