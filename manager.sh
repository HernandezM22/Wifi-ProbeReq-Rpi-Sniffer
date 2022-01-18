#!/bin/bash

<<<<<<< HEAD
        starttime1=1430 #e.g. 201712312355 for date+time or 1530 for time
=======
        starttime1=1400 #e.g. 201712312355 for date+time or 1530 for time
>>>>>>> fe5bdfa296ee2a834fa5bbce8f97db4eaa0723fd
        scriptname1="./sniff-probes.sh"

        # wait for starttime
        echo "Waiting for " "$starttime1" " to start " "$scriptname1"
        while [ $((10#$(date +"%H%M") != 10#$starttime1)) = 1 ]; do #just time. 10# forces following number to be interpreted as base 10. Otherwise numbers with leading zero will be interpreted as octal and this causes errors.
            sleep 10;
        done;

        # run target script
        sh "$scriptname1";
