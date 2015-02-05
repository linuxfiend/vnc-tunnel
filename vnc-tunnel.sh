#!/bin/bash
#
# A simple script to connect to my X11 session on my home system (either locally or remotely).
# 1) Determines the MAC address of the connected router, sets the $ADDR appropriately.
# 2) Creates a local port forward over SSH and starts x11vnc to connect to running X11 session.
# 3) Starts KDE's VNC client krdc locally and connects via the port forward.
#
# It isn't robust, e.g.  doesn't handle error conditions.
#


GATEWAYADDR=$(ip route | grep default | awk '{print $3}')
APMAC=$(ip neigh | grep $GATEWAYADDR | awk '{print $5}')

echo "Default gateway at $GATEWAYADDR has MAC $APMAC"

if [[ $APMAC = "00:00:00:00:00:00" ]]; then
        echo "On home network";
        ADDR="192.168.2.2";
else
        echo "On external network";
        ADDR="my.domain.net";
fi

ssh -L 5900:localhost:5900 user@$ADDR -f x11vnc -q -display :0 -nodpms -once;
sleep 2s && krdc vnc://localhost:5900;
