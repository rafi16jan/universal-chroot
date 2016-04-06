#!/bin/sh
export dir=/var/chroot/
read -p "Type your new chroot name: " chroot
read -p "Type your new chroot size: " size
dd if=/dev/zero of=$dir/images/$chroot.img bs=1 count=0 seek=$size
mke2fs -t ext4 $dir/images/$chroot.img
mount $dir/images/$chroot.img /chroot
rm -rf /chroot/*
read -p "Type your distro codename: " distro
read -p "Type your mirror url (leave blank for default mirror): " mirror
debootstrap --arch i386 $distro /chroot/ $mirror &&
chroot /chroot /bin/su -c 'echo "#!/bin/sh" > /boot/boot.sh' &&
chroot /chroot /bin/su -c 'echo "" > /etc/resolv.conf'
umount /chroot
