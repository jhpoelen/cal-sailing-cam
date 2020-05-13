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


NOW_UNIX_EPOCH=$(date +%s)
curl "http://cal-sailing.appspot.com/ping?date=${NOW_UNIX_EPOCH}"
update_hd_cam 192.168.1.10 restaurant
update_cam 192.168.1.253 dock
update_whiteboard_lowres_cam 192.168.1.12 whiteboard
#update_whiteboard_hires_cam 192.168.1.12 whiteboard
