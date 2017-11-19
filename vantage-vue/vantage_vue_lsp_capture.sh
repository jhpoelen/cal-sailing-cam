# attempt to grab data from vantage vue and push to http://cal-sailing.appspot.com/cam endpoint
update_vantage_vue() {
    VUE_SERIAL=/dev/ttyUSB0

    # configure the port
    stty -F $VUE_SERIAL speed 19200

    # get cat to listen for at most 10 seconds, stream result to cal-sailing server
    timeout 10 cat $VUE_SERIAL | curl -F "vue=@-" -v http://cal-sailing.appspot.com/cam &
    # request LOOP2 data chunk 
    echo "LPS 1 1\n" > $VUE_SERIAL
}

update_vantage_vue
