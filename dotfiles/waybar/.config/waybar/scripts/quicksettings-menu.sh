#!/bin/bash

# QuickSettings Menu Script for Waybar
# Place this file in ~/.config/waybar/scripts/quicksettings-menu.sh
# Make it executable: chmod +x ~/.config/waybar/scripts/quicksettings-menu.sh

LOCKFILE="/tmp/quicksettings.lock"

# Check if menu is already open
if [ -f "$LOCKFILE" ]; then
    rm -f "$LOCKFILE"
    pkill -f "rofi.*quicksettings"
    exit 0
fi

# Create lockfile
touch "$LOCKFILE"

# Function to cleanup on exit
cleanup() {
    rm -f "$LOCKFILE"
}
trap cleanup EXIT

# Get current states with proper formatting
get_wifi_status() {
    if command -v nmcli >/dev/null 2>&1; then
        if nmcli radio wifi | grep -q "enabled"; then
            local ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
            local strength=$(nmcli -t -f active,signal dev wifi | grep '^yes' | cut -d: -f2)
            if [[ -n "$ssid" ]]; then
                echo "$ssid ${strength}%"
            else
                echo "Disconnected"
            fi
        else
            echo "Disabled"
        fi
    else
        echo "Not Available"
    fi
}

get_wifi_icon() {
    if command -v nmcli >/dev/null 2>&1; then
        if nmcli radio wifi | grep -q "enabled"; then
            local ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
            if [[ -n "$ssid" ]]; then
                echo "󰤨"
            else
                echo "󰤭"
            fi
        else
            echo "󰤭"
        fi
    else
        echo "󰤭"
    fi
}

get_bluetooth_status() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        local connected=$(bluetoothctl devices Connected | head -n1 | cut -d' ' -f3-)
        if [[ -n "$connected" ]]; then
            echo "$connected"
        else
            echo "Ready"
        fi
    else
        echo "Disabled"
    fi
}

get_bluetooth_icon() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        echo "󰂯"
    else
        echo "󰂲"
    fi
}

get_battery_info() {
    local capacity=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n1)
    local status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -n1)
    
    if [[ -n "$capacity" ]]; then
        if [[ "$status" == "Charging" ]]; then
            echo "󰂄 ${capacity}%"
        else
            if [[ $capacity -gt 80 ]]; then
                echo "󰁹 ${capacity}%"
            elif [[ $capacity -gt 60 ]]; then
                echo "󰂀 ${capacity}%"  
            elif [[ $capacity -gt 40 ]]; then
                echo "󰁾 ${capacity}%"
            elif [[ $capacity -gt 20 ]]; then
                echo "󰁼 ${capacity}%"
            else
                echo "󰁻 ${capacity}%"
            fi
        fi
    else
        echo "󰂑 N/A"
    fi
}

get_brightness_info() {
    if command -v brightnessctl >/dev/null 2>&1; then
        local brightness=$(brightnessctl get)
        local max_brightness=$(brightnessctl max)
        local percentage=$((brightness * 100 / max_brightness))
        echo "${percentage}"
    else
        echo "50"
    fi
}

get_volume_info() {
    if command -v pactl >/dev/null 2>&1; then
        local vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -n1 | tr -d '%')
        local muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes" && echo "true" || echo "false")
        if [[ "$muted" == "true" ]]; then
            echo "0"
        else
            echo "${vol}"
        fi
    else
        echo "50"
    fi
}

# Get all the info
WIFI_ICON=$(get_wifi_icon)
WIFI_STATUS=$(get_wifi_status)
BT_ICON=$(get_bluetooth_icon)
BT_STATUS=$(get_bluetooth_status)
BATTERY_INFO=$(get_battery_info)
BRIGHTNESS_PERCENT=$(get_brightness_info)
VOLUME_PERCENT=$(get_volume_info)

# Create the menu structure with proper tile layout
menu_layout="Quick Settings                          󰍹 $BATTERY_INFO ⏻
$WIFI_ICON|Wi-Fi||$BT_ICON|Bluetooth
|$WIFI_STATUS||      |$BT_STATUS
󰖔 󰸉 󰹑
󰍬 󰂚 󰐪
󰃠│$BRIGHTNESS_PERCENT%│━━━━━━━━━━
󰕾│$VOLUME_PERCENT%│━━━━━━━━━━"

# Show menu with rofi
selected=$(echo "$menu_layout" | rofi -dmenu -i \
    -p "" \
    -theme ~/.config/waybar/themes/quicksettings.rasi \
    -no-custom \
    -format s \
    -markup-rows)

# Handle selections based on content and icons
case "$selected" in
    *"󰤨"*|*"󰤭"*|*"Wi-Fi"*)
        echo "WiFi button clicked!"
        # Future: nmcli radio wifi toggle
        ;;
    *"󰂯"*|*"󰂲"*|*"Bluetooth"*)
        echo "Bluetooth button clicked!"
        # Future: bluetoothctl power toggle
        ;;
    *"󰖔"*)
        echo "Theme toggle button clicked!"
        # Future: gsettings theme toggle
        ;;
    *"󰸉"*)
        echo "Color picker button clicked!"
        # Future: hyprpicker -a &
        ;;
    *"󰹑"*)
        echo "Screenshot button clicked!"
        # Future: grim screenshot
        ;;
    *"󰍬"*)
        echo "Microphone button clicked!"
        # Future: pactl set-source-mute toggle
        ;;
    *"󰂚"*)
        echo "DND button clicked!"
        # Future: makoctl mode toggle
        ;;
    *"󰐪"*)
        echo "Coming Soon button clicked!"
        # Future: your custom function
        ;;
    *"󰃠"*|*"Brightness"*)
        echo "Brightness slider clicked!"
        # Future: brightness control
        ;;
    *"󰕾"*|*"Volume"*)
        echo "Volume slider clicked!"
        # Future: volume control
        ;;
    *"Quick Settings"*|*"󰍹"*|*"⏻"*)
        echo "Header clicked!"
        # Future: power menu or settings
        ;;
esac

cleanup
