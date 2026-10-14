#/usr/bin/env bash

echo "Before continuing, you should create a backup for you current configs"
read -p "Do you wish to continue? [y/N] " is_ready
[[ ! "$is_ready" =~ ^[yY]([eE][sS])?$ ]] && { echo "Aborted."; exit 1; }

echo
echo "Choose the OS for the installation:"
echo "1) Linux"
echo "2) Windows"
echo "3) Quit"

read -p "Enter your choice [1-3]: " os_choice

case $os_choice in
    1)
        chmod +x ./installers/install_linux.sh
        ./installers/install_linux.sh
        ;;
    2)
        echo "We don't have yet an installer Windows :("
        # chmod +x ./installers/install_windows.sh
        # ./installers/install_windows.sh
        ;;
    3)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option. Please run the script again and select 1-3."
        exit 1
        ;;
esac
