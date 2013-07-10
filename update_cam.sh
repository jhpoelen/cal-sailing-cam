function update_cam() {
	echo `date` update cam [$2] starting...
	tmp_file = /tmp/$2.jpg
	rm $tmp_file
	curl http://$1/img/snapshot.cgi?[size=3][&quality=3] > $tmp_file
	curl -F "$2=@/tmp/$2.jpg" -v http://cal-sailing.appspot.com/cam
	rm $tmp_file
	echo `date` update cam [$2] done.
}

update_cam 192.168.1.252 restaurant_test
update_cam 192.168.1.253 dock_test
