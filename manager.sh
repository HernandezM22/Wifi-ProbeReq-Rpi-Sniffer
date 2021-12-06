#!/bin/bash

    if [ "$1" = "go" ]; then

        starttime1=0600 #e.g. 201712312355 for date+time or 1530 for time
        stoptime1=1200
        scriptname1="./myscript"

        # wait for starttime
        echo "Waiting for " "$starttime1" " to start " "$scriptname1";
        #while [ $(($(date +"%Y%m%d%H%M") < $starttime1)) = 1 ]; do #day and time
        while [ $((10#$(date +"%H%M") != 10#$starttime1)) = 1 ]; do #just time. 10# forces following number to be interpreted as base 10. Otherwise numbers with leading zero will be interpreted as octal and this causes errors.
            sleep 10;
        done;

        # run target script
        lxterminal -e "$scriptname1";

        # check if the target script is running, until the stoptime is reached and restart it if necessary
        echo "Waiting for " "$stoptime1" " to stop " "$scriptname1";
        #while [ $(($(date +"%Y%m%d%H%M")<$stoptime1)) = 1 ]; do #day and time
        while [ $((10#$(date +"%H%M") != 10#$stoptime1)) = 1 ]; do #just time. 10# forces following number to be interpreted as base 10. Otherwise numbers with leading zero will be interpreted as octal and this causes errors.
            sleep 10;
            if [ -z $(pidof -x "$scriptname1") ]; then
                echo "script was stopped.";
                lxterminal -e "$scriptname1";
            fi;
        done;

        # end the target script when the stoptime is reached
        kill $(pidof -x "$scriptname1");
        echo "ok.";

    else
        lxterminal -e "$0" go;
        exit;
    fi