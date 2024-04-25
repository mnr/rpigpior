test_that("Can we set a pin", {
  message("Real world test of setting board pin 11")
  skip_if_not(is.rpi())
  expect_silent({
    rpi_set(11, 1)
    Sys.sleep(1)
    rpi_set(11, 0)
    Sys.sleep(1)
    rpi_set(11, 1)
    Sys.sleep(1)
    rpi_set(11, 0)
  })
})
