test_that("is.rpi confirms/denies RPi", {
  expect_true(
     # if /etc/os-release exists,
     # ...and it contains "Raspbian"
     # then is.rpi() should == TRUE
     # else !is.rpi() should == TRUE
     if(file.exists("/etc/os-release")){
        if (any(grepl("Raspbian",readLines("/etc/os-release")))) {is.rpi()}
     } else {!is.rpi()}
  )
})
