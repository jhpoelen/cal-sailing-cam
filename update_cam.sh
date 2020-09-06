#!/bin/sh

SERVER_URL="https://whatskraken.cal-sailing.org"
UPLOAD_URL="$SERVER_URL/cam"

update_cam2() {
	echo `date` update cam [$2] starting...
        curl --globoff "http://$1/img/snapshot.cgi?[size=3][&quality=3]" | curl -F $2=@- -v $UPLOAD_URL
	echo `date` update cam [$2] done.
}

update_hd_cam() {
	echo `date` update cam [$2] starting...
	TMP_FILE=/tmp/$2.jpg
	avconv -i "rtsp://$1:554" $TMP_FILE
	if [ -f $TMP_FILE ] 
	then
		curl -F "$2=@$TMP_FILE" -v $UPLOAD_URL
		rm $TMP_FILE
	else
		echo cam image [$TMP_FILE] not available 
	fi
	echo `date` update cam [$2] done.
}

update_hd_cam2() {
        echo `date` update cam [$2] starting...
        avconv -i "rtsp://$1:554" - | curl -F $2=@- -v $UPLOAD_URL
        echo `date` update cam [$2] done.
}

update_whiteboard_lowres_cam2() {
	echo `date` update cam [$2] starting...
	avconv -i "rtsp://$1:554/user=admin&password=&channel=1&stream=1.sdp?real_stream--rtp-caching=100" - | curl -F $2=@- -v $UPLOAD_URL
	echo `date` update cam [$2] done.
}

curl $SERVER_URL/ping
update_hd_cam2 192.168.1.10 restaurant
update_cam2 192.168.1.253 dock
update_whiteboard_lowres_cam2 192.168.1.12 whiteboard
