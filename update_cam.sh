function update_cam {
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

update_cam 192.168.1.252 restaurant
update_cam 192.168.1.253 dock
