test_that("Does /proc/device-tree/model exist?", {
  expect_no_error(file.exists("/proc/device-tree/model"))
})

test_that("Is this an RPi?", {
  expect_true(rpigpior::rpi_whatami()$is_rpi)
})

test_that("Are the correct types returned?", {
  whatAmI <- rpigpior::rpi_whatami()
  expect_type(whatAmI$i2c_enabled, logical)
  expect_type(whatAmI$spi_enabled, logical)
})

test_that("Is valid gpiochip# returned",{
  expect_in(rpigpior::rpi_whatami()$gpiochip,
            c("gpiochip0","gpiochip4"))
})
