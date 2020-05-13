#!/bin/sh

update_cam() {
	echo `date` update cam [$2] starting...
	TMP_FILE=/tmp/$2.jpg
	curl --globoff "http://$1/img/snapshot.cgi?[size=3][&quality=3]" > $TMP_FILE
	if [ -f $TMP_FILE ] 
	then
		curl -F "$2=@$TMP_FILE" -v http://cal-sailing.appspot.com/cam
		rm $TMP_FILE
	else
		echo cam image [$TMP_FILE] not available 
	fi
	echo `date` update cam [$2] done.
}

update_hd_cam() {
	echo `date` update cam [$2] starting...
	TMP_FILE=/tmp/$2.jpg
	avconv -i "rtsp://$1:554" $TMP_FILE
	if [ -f $TMP_FILE ] 
	then
		curl -F "$2=@$TMP_FILE" -v http://cal-sailing.appspot.com/cam
		rm $TMP_FILE
	else
		echo cam image [$TMP_FILE] not available 
	fi
	echo `date` update cam [$2] done.
}

update_whiteboard_hires_cam() {
	echo `date` update cam [$2] starting...
	TMP_FILE=/tmp/$2.jpg
	avconv -i "rtsp://$1:554/user=admin&password=&channel=&stream=.sdp?real_stream--rtp-caching=500" $TMP_FILE
	if [ -f $TMP_FILE ] 
	then
		curl -F "$2=@$TMP_FILE" -v http://cal-sailing.appspot.com/cam
		rm $TMP_FILE
	else
		echo cam image [$TMP_FILE] not available 
	fi
	echo `date` update cam [$2] done.
}

update_whiteboard_lowres_cam() {
	echo `date` update cam [$2] starting...
	TMP_FILE=/tmp/$2.jpg
	avconv -i "rtsp://$1:554/user=admin&password=&channel=1&stream=1.sdp?real_stream--rtp-caching=100" $TMP_FILE
	if [ -f $TMP_FILE ] 
	then
		curl -F "$2=@$TMP_FILE" -v http://cal-sailing.appspot.com/cam
		rm $TMP_FILE
	else
		echo cam image [$TMP_FILE] not available 
	fi
	echo `date` update cam [$2] done.
}

# reduce load on server by only processing every other 5 cycles
COIN_TOSS=$(($RANDOM % 6))
if [ $COIN_TOSS -eq 0 ] 
then
  curl http://cal-sailing.appspot.com/ping?date=$(date +%s)
  update_hd_cam 192.168.1.10 restaurant_cam
  update_cam 192.168.1.253 dock_cam
  update_whiteboard_lowres_cam 192.168.1.12 whiteboard
  #update_whiteboard_hires_cam 192.168.1.12 whiteboard
fi

