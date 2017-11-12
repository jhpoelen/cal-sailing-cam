This page describes the setup of the weather station at [cal sailling club](http://cal-sailing.org). The weather station is supposed to report data to https://www.wunderground.com/personal-weather-station/dashboard?ID=KCABERKE32 .

![diagram](weather-station.dot.png)

# documentation

[Davis Vantage Serial Protocol Docs](http://www.davisnet.com/support/weather/download/VantageSerialProtocolDocs_v261.pdf)

# Troubleshooting

## Check whether data is coming from the Davis Vantage Vue console
Serial Connection settings, from http://madscientistlabs.blogspot.com/2011/01/davis-weatherlink-software-not-required.html - Weatherlink adapter: 19.2 kbaud and 8N1. 

(not yet tested)
1. Connect USB from WeatherLink 6510 USB to (linux) laptop
2. execute ```sudo minicom -s```
3. type ```TEST``` --> expect device to return TEST in response
4. type ```VER``` --> expect version of firmware to return
5. type ```STRMON``` --> start streaming data from device
