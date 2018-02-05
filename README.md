# ESP Enumerator

Enumerates multiple ESP8266 and ESP32 according their MAC address and chip id (derived from MAC), 
e.g. `/dev/esp/` so you can address them easily, and no longer with the ever changing `/dev/ttyUSBx`.

## Requirements

Install `nodemcu-tool` & `esptool.py`
```
% sudo npm install nodemcu-tool -g
% sudo -H pip install esptool
```

Make sure you (username) is part of the `dialout` group:
```
% sudo usermod -a -G dialout "your-username"
```
If you are added newly, preferably reboot the machine.

## Installation

```
% make install
```

## Usage

Once after the boot of your machine:
```
% sudo esp-enum
esp-enum: INFO: /dev/esp created, please re-run script `esp-enum` again as normal user
```
and then as normal user: 
```
% esp-enum
esp-enum: probing all ESP devices (it will reset/reboot each)
esp-enum:    /dev/ttyUSB0: /dev/esp/xx:xx:xx:4d:98:d0 and /dev/esp/0x4d98d0
esp-enum:    /dev/ttyUSB1: /dev/esp/xx:xx:xx:9f:77:72 and /dev/esp/0x9f7772
esp-enum:    /dev/ttyUSB2: /dev/esp/xx:xx:xx:9f:7c:f3 and /dev/esp/0x9f7cf3
esp-enum:    /dev/ttyUSB3: /dev/esp/xx:xx:xx:9f:77:23 and /dev/esp/0x9f7723
esp-enum:    /dev/ttyUSB4: /dev/esp/xx:xx:xx:4e:3c:e0 and /dev/esp/0x4e3ce0
esp-enum:    /dev/ttyUSB5: /dev/esp/xx:xx:xx:4c:cf:68 and /dev/esp/0x4ccf68
esp-enum:    /dev/ttyUSB6: /dev/esp/xx:xx:xx:4d:31:fc and /dev/esp/0x4d31fc
esp-enum:    /dev/ttyUSB7: /dev/esp/xx:xx:xx:9f:77:a6 and /dev/esp/0x9f77a6
esp-enum:    /dev/ttyUSB8: /dev/esp/xx:xx:xx:9f:70:82 and /dev/esp/0x9f7082
esp-enum:    /dev/ttyUSB9: /dev/esp/xx:xx:xx:9f:70:20 and /dev/esp/0x9f7020
esp-enum: done.
```

then you can connect your devices like with NodeMCU firmware:
```
% nodemcu-tool --port /dev/esp/0x9f7082 terminal
% nodemcu-tool --port /dev/esp/0x9f7082 upload --keeppath shell/main.lua
```
or with Mongoose OS firmware:
```
% mos --port /dev/esp/*98:d0 console
% mos --port /dev/esp/0x4d98d0 console
% mos --port /dev/esp/0x4d98d0 put fs/init.js
```

**Note:**
- `esp-enum` deletes all links in `/dev/esp/*` before (re-)creating new links
- `esp-enum` resets/reboots each devices as a side-effect of probing the MAC address

Whenever you disconnect or connect an ESP8266 or ESP32, rerun `esp-enum`.

I personally label each device physically with the last 4 digits of the MAC address (e.g. `77:23`), so I can distinct them, 
so I access them like
```
% nodemcu-tool --port /dev/esp/*70:23 terminal
```
