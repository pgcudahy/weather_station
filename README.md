A solar powered weather station based on:

1) [SparkFun weather meters](https://www.sparkfun.com/products/15901) and [weather shield](https://www.sparkfun.com/products/13674)

2) [makerPower-solar](https://www.crowdsupply.com/danjuliodesigns/makerpower-solar) charge controller

3) [ESP8266](https://www.nodemcu.com/index_en.html) running [micropython](http://micropython.org/). 

The system POSTS json data over wifi to a [fastAPI](https://fastapi.tiangolo.com/) running on a local Raspberry pi.

Micropython code developed as a series of jupyter notebooks using the [MicroPython Upydevice Kernel](https://github.com/Carglglz/jupyter_upydevice_kernel)
