To get micropython to work, flash with `-fm dio` option. eg `
`esptool.py --port /dev/tty.SLAB_USBtoUART write_flash -fm dio 0x00000 ~/Documents/Projects/weather_station/esp8266-20200416-v1.12-375-g28833690b.bin`

per https://github.com/espressif/esptool, 

Some ESP8266 modules, including the ESP-12E modules on some (not all) NodeMCU boards, are dual I/O and the firmware will only boot when flashed with 
`--flash_mode dio`
