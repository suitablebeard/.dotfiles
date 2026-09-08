#!/bin/bash

sudo insmod ~/src/acer-wmi-battery/acer-wmi-battery.ko enable_health_mode=1
gsettings --schemadir ~/.local/share/gnome-shell/extensions/Battery-Health-Charging@maniacx.github.com/schemas set org.gnome.shell.extensions.Battery-Health-Charging charging-mode 'max'
gnome-extensions disable Battery-Health-Charging@maniacx.github.com
gnome-extensions enable Battery-Health-Charging@maniacx.github.com

cat /sys/bus/wmi/drivers/acer-wmi-battery/health_mode
