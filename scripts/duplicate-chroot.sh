#!/bin/sh
export dir=/var/chroot/
echo "Your chroot images:
$(ls $dir/images/ | sed 's/.img//g')
"
read -p "Type your old image name: " old
read -p "Type your new image name: " new
cp $dir/images/$old.img $dir/images/$new.img
