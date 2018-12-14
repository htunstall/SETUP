#!/bin/bash

# If the mountpoint is not mounted
mountpoint="/media/sdcard"
if [ "$(df | grep $mountpoint)" ]; then
  echo "Unmounting SD Card"
  sudo umount /media/sdcard
else
  echo "SD Card is not already mounted!"
fi

echo "Mounting SD Card with write access"
sudo mount -t ext4 /dev/mmcblk1p1 /media/sdcard

# Make usre it's owned by the user
sudo chown -R $USER:$USER /media/sdcard
