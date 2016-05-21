#!/bin/sh
export dir=/var/chroot/
echo "Your chroot images:
$(ls $dir/images/ | sed 's/.img//g')
"
read -p "Type your image name: " image
mount $dir/images/$image.img $dir/chroot/environment
mount -o bind /etc/resolv.conf $dir/chroot/environment/etc/resolv.conf
mount -o bind /dev $dir/chroot/environment/dev
mount -o bind /proc $dir/chroot/environment/proc
mount -o bind /sys $dir/chroot/environment/sys
chroot $dir/environment/chroot /bin/su -c 'sh /boot/boot.sh'
