#!/bin/bash
echo Updating Linux...
sudo apt-get update        # Fetches the list of available updates
sudo apt-get upgrade       # Strictly upgrades the current packages
sudo apt-get dist-upgrade  # Installs updates (new ones)
echo "Updated!"
echo "It is best to restart with sudo reboot, now that the updating is done."
