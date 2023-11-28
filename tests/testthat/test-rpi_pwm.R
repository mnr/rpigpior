
test_that("is pin_number valid for use with PWM?", {
  skip_if_not(is.rpi())
  expect_error(rpi_pwm(30, pwm_debug = TRUE))
})

test_that("Do two PWM pins collide?", {
  skip_if_not(is.rpi())
  expect_error(rpi_pwm(c(12,32), pwm_debug = TRUE))
})

test_that("length(pin_number) > 3", {
  skip_if_not(is.rpi())
  expect_error(rpi_pwm(c(12,32,33), pwm_debug = TRUE))
})

test_that("real world test of pwm", {
  skip_if_not(is.rpi())
  message("Testing PWM in real world")
  expect_silent({
    rpi_pwm(pin_number=12, pwm_period = 50000, pwm_dutycycle = 10000)
    Sys.sleep(1)
    rpi_pwm(pin_number=33, pwm_period = 50000, pwm_dutycycle = 40000)
    Sys.sleep(1)
    rpi_pwm(pin_number=c(12,33), pwm_period = 0, pwm_dutycycle = 0)
  })
  })
