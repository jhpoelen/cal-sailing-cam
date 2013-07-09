echo `date` update cam starting...
rm /tmp/view.jpg
curl http://sv.berkeley.edu/view/images/newview.jpg > /tmp/view.jpg
curl -F "view=@/tmp/view.jpg" -v http://cal-sailing.appspot.com/cam
echo `date` update cam done.
