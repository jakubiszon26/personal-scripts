#!/bin/bash

resolution=$(xrandr --current | grep -oP '\d+x\d+' | head -n 1)

if [ "$resolution" = "2160x1440" ]; then
    STEAM_FORCE_DESKTOPUI_SCALING=1.5 steam &
else
    steam &
fi