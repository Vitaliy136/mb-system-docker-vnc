#!/bin/sh

sudo rm /tmp/.X20-lock

export LD_LIBRARY_PATH=/usr/local/lib

sudo chown -R researcher:data /home/researcher/Data

export DISPLAY=:20
Xvfb :20 -screen 0 1024x768x24 &
x11vnc -passwd SecretKey -display :20 -N -forever &
fluxbox
