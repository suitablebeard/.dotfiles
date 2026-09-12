#!/bin/bash

if [ "$(cat /sys/bus/wmi/drivers/acer-wmi-battery/health_mode)" -eq 1 ]; then
    echo 'Battery Health is already active.'
    exit 0
fi

sudo insmod ~/src/acer-wmi-battery/acer-wmi-battery.ko enable_health_mode=1
gsettings --schemadir ~/.local/share/gnome-shell/extensions/Battery-Health-Charging@maniacx.github.com/schemas set org.gnome.shell.extensions.Battery-Health-Charging charging-mode 'max'
gnome-extensions disable Battery-Health-Charging@maniacx.github.com
gnome-extensions enable Battery-Health-Charging@maniacx.github.com

if [ "$(cat /sys/bus/wmi/drivers/acer-wmi-battery/health_mode)" -eq 1 ]; then
    echo 'Battery Health mode ACTIVATED.'
else
    echo 'Battery Health mode DISABLED.'
fi

