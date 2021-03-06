#!/bin/sh

SERVER_URL="https://whatskraken.cal-sailing.org"
UPLOAD_URL="$SERVER_URL/cam"

CURL="curl --max-time 15"

update_cam() {
	echo `date` update cam [$2] starting...
        $CURL --globoff "http://$1/img/snapshot.cgi?[size=3][&quality=3]" | curl -F $2=@- -v $UPLOAD_URL
	echo `date` update cam [$2] done.
}

update_trendnet_tv_ip110w_a() {
        # Trendnet TV-IP110W/A
	echo `date` update cam [$2] starting...
        #curl -u 'admin:admin' --globoff "http://$1/admin/view.cgi?profile=2" | curl -F $2=@- -v $UPLOAD_URL
        STREAM_CHUNK=$2-1M.mjpeg
        curl "http://$1/cgi/mjpg/mjpeg.cgi" | head -c1048576 > $STREAM_CHUNK 
        avconv -i "$STREAM_CHUNK" -f image2 -frames:v 1 pipe:1 | curl -F $2=@- -v $UPLOAD_URL
        rm $2-1M.mjpeg
	echo `date` update cam [$2] done.
}

update_hd_cam() {
        echo `date` update cam [$2] starting...
        avconv -i "rtsp://$1:554" -f image2 -frames:v 1 pipe:1 | curl -F $2=@- -v $UPLOAD_URL
        echo `date` update cam [$2] done.
}

update_whiteboard_lowres_cam() {
	echo `date` update cam [$2] starting...
	avconv -i "rtsp://$1:554/user=admin&password=&channel=1&stream=1.sdp?real_stream--rtp-caching=100" -f image2 -frames:v 1 pipe:1 | curl -F $2=@- -v $UPLOAD_URL
	echo `date` update cam [$2] done.
}

upload_logs() {
  # upload list of running pi processes
  ps -ef | $CURL -F log=@- -v $UPLOAD_URL

  # upload list of processes to be killed
  local REGEX="curl -F dock="
  ps -e | grep "$REGEX" | sed -E 's/^\s+//g' | $CURL -F log_kill=@- -v $UPLOAD_URL

  # attempt to cleanup stale avconv processes
  #ps -e | grep "$REGEX" | sed -E 's/^\s+//g' | cut -d ' ' -f1 | xargs -L1 kill

}

curl $SERVER_URL/ping

upload_logs

update_hd_cam 192.168.1.10 restaurant

#update_cam 192.168.1.253 dock
update_trendnet_tv_ip110w_a 192.168.1.210 dock

update_whiteboard_lowres_cam 192.168.1.12 whiteboard
