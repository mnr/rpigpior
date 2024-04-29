test_that("is.rpi confirms/denies RPi", {
  skip_on_os("mac")
  skip_on_os("windows")
  skip_if_not( file.exists("/etc/os-release"), message = "missing /etc/os-release")
  skip_if_not( any(grepl("Raspbian", readLines("/etc/os-release"))),
               message = "Raspbian is not in /etc/os-release")
  expect_true( is.rpi() )
})
