## code to prepare `rpi_pin_desc` dataset
# used by rpi_pwm(), rpi_pinToBCM()

Description <- c("3.3v","5v","GPIO02","5v","GPIO03",
              "GROUND","GPIO04","GPIO14","GROUND","GPIO15",
              "GPIO17","GPIO18","GPIO27","GROUND","GPIO22",
              "GPIO23","3.3v","GPIO24","GPIO10","GROUND",
              "GPIO09","GPIO25","GPIO11","GPIO08","GROUND",
              "GPIO07","GPIO00","GPIO01","GPIO05","GROUND",
              "GPIO06","GPIO12","GPIO13","GROUND","GPIO19",
              "GPIO16","GPIO26","GPIO20","GROUND","GPIO21")

Secondary <- c(" "," ","I2C 1 SDA"," ","I2C 1 SCL",
                " ","GPCLK0","UART TX","","UART RX",
                " ","PCM CLK"," "," "," ",
                " "," "," ","SPIO MOSI"," ",
                "SPIO MISO"," ","SPIO SCLK","SPIO CE0"," ",
                "SPIO CE1","EEPROM SDA","EEPROM SCL"," "," ",
                " ","PWM0","PWM1"," ","PCM FS",
                " "," ","PCM DIN"," ","PCM DOUT")

valid_PWM_pair_1 <- c("FALSE","FALSE","FALSE","FALSE","FALSE",
                    "FALSE","FALSE","FALSE","FALSE","FALSE",
                    "FALSE","33","FALSE","FALSE","FALSE",
                    "FALSE","FALSE","FALSE","FALSE","FALSE",
                    "FALSE","FALSE","FALSE","FALSE","FALSE",
                    "FALSE","FALSE","FALSE","FALSE","FALSE",
                    "FALSE","33","12","FALSE","12",
                    "FALSE","FALSE","FALSE","FALSE","FALSE")

valid_PWM_pair_2 <- c("FALSE","FALSE","FALSE","FALSE","FALSE",
                      "FALSE","FALSE","FALSE","FALSE","FALSE",
                      "FALSE","35","FALSE","FALSE","FALSE",
                      "FALSE","FALSE","FALSE","FALSE","FALSE",
                      "FALSE","FALSE","FALSE","FALSE","FALSE",
                      "FALSE","FALSE","FALSE","FALSE","FALSE",
                      "FALSE","35","32","FALSE","32",
                      "FALSE","FALSE","FALSE","FALSE","FALSE")


rpi_pin_desc <- data.frame(Description, Secondary, valid_PWM_pair_1, valid_PWM_pair_2)

usethis::use_data(rpi_pin_desc, overwrite = TRUE)
