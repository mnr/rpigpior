test_that("is pin correctly converted to BCM", {
  expect_named(rpi_pinToBCM(40), "GPIO21")
  expect_error(rpi_pinToBCM(1))
})
