test_that("test rpi_monitor", {
  skip_if_not(is.rpi(), message = "Not a Raspberry Pi")
  expect_error(rpi_monitor(1), info = "rpi_monitor(1) isn't valid")
})
