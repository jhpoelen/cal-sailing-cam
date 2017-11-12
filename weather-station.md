This page describes the setup of the weather station at [cal sailling club](http://cal-sailing.org). The weather station is supposed to report data to https://www.wunderground.com/personal-weather-station/dashboard?ID=KCABERKE32 .

![diagram](weather-station.dot.png)

# documentation

[Davis Vantage Serial Protocol Docs](http://www.davisnet.com/support/weather/download/VantageSerialProtocolDocs_v261.pdf)

# Troubleshooting

## Check whether data is coming from the Davis Vantage Vue console
Serial Connection settings, from http://madscientistlabs.blogspot.com/2011/01/davis-weatherlink-software-not-required.html - Weatherlink adapter: 19.2 kbaud and 8N1. 

(testing on ubuntu 16.04)
1. Connect USB from WeatherLink 6510 USB to (linux) laptop
2. open terminal and execute 
```sudo minicom -D /dev/ttyUSB0 --baudrate 19200``` (ubuntu typically ttyUSB0). Expected output something like 
```
Welcome to minicom 2.7

OPTIONS: I18n 
Compiled on Feb  7 2016, 13:37:27.
Port /dev/ttyUSB0, 11:54:59

Press CTRL-A Z for help on special keys
```

3. type ```TEST``` --> expect device to return TEST in response, looks something like: 
```
TEST
```
4. type ```VER``` --> expect version of firmware to return, looks something like: 
```
OK
May  1 2012
```
5. type ```STRMON``` --> start streaming data from device. Looks something like: 
```
OK
0 = 61
1 = 0
2 = e4
3 = ff
4 = c2
5 = 0
6 = eb                                                                          
7 = f6
``` 
with data segments 0-7 repeating every 2s . 

6. type ```STRMOFF``` to turn off the data streaming 

