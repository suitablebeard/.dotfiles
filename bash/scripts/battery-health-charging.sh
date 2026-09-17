#!/bin/bash

USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
BATTERY_HEALTH_EXTENSION_DIR="$USER_HOME/.local/share/gnome-shell/extensions/Battery-Health-Charging@maniacx.github.com/schemas"
ACER_BATTERY_DRIVER="$USER_HOME/src/acer-wmi-battery/acer-wmi-battery.ko"
SYSTEM_HEALTH_MODE_FILE="/sys/bus/wmi/drivers/acer-wmi-battery/health_mode"

if [ -z "$SUDO_USER" ]; then
    echo "Error: This script must be run with sudo."
    exit 1
fi

if [ -f "$SYSTEM_HEALTH_MODE_FILE" ] && [ "$(cat "$SYSTEM_HEALTH_MODE_FILE")" -eq 1 ]; then
    echo 'Battery Health is already active.'
    exit 0
fi

if [ ! -e "$SYSTEM_HEALTH_MODE_FILE" ]; then
    insmod $ACER_BATTERY_DRIVER enable_health_mode=1
fi

run_as_user() {
    systemd-run --user --machine="${SUDO_USER}@.host" --quiet --collect "$@"
}

run_as_user gsettings --schemadir "$BATTERY_HEALTH_EXTENSION_DIR" \
    set org.gnome.shell.extensions.Battery-Health-Charging charging-mode 'max'
run_as_user gnome-extensions disable Battery-Health-Charging@maniacx.github.com
run_as_user gnome-extensions enable Battery-Health-Charging@maniacx.github.com

if [ "$(cat $SYSTEM_HEALTH_MODE_FILE)" -eq 1 ]; then
    echo 'Battery Health mode ACTIVATED.'
    exit 0
else
    echo 'Error: Battery Health mode was NOT enabled.'
    exit 1
fi

