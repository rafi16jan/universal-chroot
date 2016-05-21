#!/bin/sh
export dir=/var/chroot/
read -p "Type your new chroot name: " chroot
read -p "Type your new chroot size: " size
dd if=/dev/zero of=$dir/images/$chroot.img bs=1 count=0 seek=$size
mke2fs -t ext4 $dir/images/$chroot.img
mount $dir/images/$chroot.img $dir/chroot/environment
rm -rf $dir/chroot/environment/*
read -p "Type your architecture: " arch
read -p "Type your distro codename: " distro
read -p "Type your mirror url (leave blank for default mirror): " mirror
debootstrap --arch $arch $distro $dir/chroot/environment/ $mirror &&
chroot $dir/chroot/environment /bin/su -c 'echo "#!/bin/sh" > /boot/boot.sh' &&
chroot $dir/chroot/environment /bin/su -c 'echo "" > /etc/resolv.conf'
umount $dir/chroot/environment
