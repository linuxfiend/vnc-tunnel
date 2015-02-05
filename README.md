# vnc-tunnel

# A simple script to connect to my X11 session on my home system (either locally or remotely).
# 1) Determines the MAC address of the connected router, compares it to my access point's MAC,
#   if local, set to internal address, if remote, set to external address.
# 2) Creates a local port forward over SSH and starts x11vnc to connect to running X11 session.
# 3) Starts KDE's VNC client krdc locally and connects via the port forward.
#
# It isn't robust, e.g. doesn't handle error conditions.
