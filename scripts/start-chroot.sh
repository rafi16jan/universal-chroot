#!/bin/sh
export dir=/var/chroot/
echo "Your chroot images:
$(ls $dir/images/ | sed 's/.img//g')
"
read -p "Type your image name: " image
mount $dir/images/$image.img $dir/environment
mount -o bind /etc/resolv.conf $dir/environment/etc/resolv.conf
mount -o bind /dev $dir/environment/dev
mount -o bind /proc $dir/environment/proc
mount -o bind /sys $dir/environment/sys
chroot $dir/environment /bin/su -c 'sh /boot/boot.sh'
