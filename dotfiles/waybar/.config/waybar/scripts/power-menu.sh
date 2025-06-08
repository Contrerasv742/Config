#!/bin/bash

chosen=$(printf "Shutdown\nReboot\nSleep\nCancel" | wofi --dmenu --prompt "Power Menu" --width 200 --height 150)

case "$chosen" in
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Sleep)
        systemctl suspend
        ;;
    *)
        ;;
esac
