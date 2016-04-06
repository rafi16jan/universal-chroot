#!/bin/sh
export dir=/var/chroot/
echo "Your chroot images:
$(ls $dir/images/ | sed 's/.img//g')
"
read -p "Type your image name: " image
mount $dir/images/$image.img /chroot
mount -o bind /etc/resolv.conf /chroot/etc/resolv.conf
mount -o bind /dev /chroot/dev
mount -o bind /proc /chroot/proc
mount -o bind /sys /chroot/sys
chroot /chroot /bin/su -c 'sh /boot/boot.sh'
