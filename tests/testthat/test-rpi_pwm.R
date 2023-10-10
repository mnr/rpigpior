
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
