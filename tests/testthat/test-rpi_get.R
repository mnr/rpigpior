test_that("rpi_get", {
  skip_if_not(is.rpi(), message = "Not a Raspberry Pi")
  expect_error(rpi_get(1), info = "rpi_get(1) isn't valid")
})
