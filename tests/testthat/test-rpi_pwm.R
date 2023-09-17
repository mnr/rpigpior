test_that("is pin_number valid for use with PWM?", {
  expect_error(rpi_pwm(30))
})

test_that("Do two PWM pins collide?", {
  expect_error(rpi_pwm(c(12,32)))
})

test_that("length(pin_number) > 3", {
  expect_error(rpi_pwm(c(12,32,33)))
})
