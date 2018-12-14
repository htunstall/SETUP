#!/bin/bash
echo "Unmounting SD Card"
sudo umount /media/sdcard

echo "Mounting SD Card with write access"
sudo mount -t vfat -o rw,uid=1000 /dev/mmcblk1p1 /media/sdcard
