#!/bin/sh
export dir=/var/chroot/
read -p "Type your new chroot name: " chroot
read -p "Type your new chroot size (in GB): " size
dd if=/dev/zero of=$dir/images/$chroot.img bs=1G count=$size
mke2fs -t ext4 $dir/images/$chroot.img
mount $dir/images/$chroot.img $dir/environment
rm -rf $dir/environment/*
read -p "Type your architecture: " arch
read -p "Type your distro codename: " distro
read -p "Type your mirror url (leave blank for default mirror): " mirror
debootstrap --arch $arch $distro $dir/environment/ $mirror &&
chroot $dir/environment /bin/su -c 'echo "#!/bin/sh" > /boot/boot.sh' &&
chroot $dir/environment /bin/su -c 'echo "" > /etc/resolv.conf'
umount $dir/environment
