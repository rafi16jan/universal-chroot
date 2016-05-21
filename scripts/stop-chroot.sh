#!/bin/sh
export dir=/var/chroot/
lsof | grep " $dir/environment/" > $dir/process/1
cut -c11-15 $dir/process/1 > $dir/process/2
uniq $dir/process/2 > $dir/process/3
echo "
$(cat $dir/process/3)" > $dir/process/4
sed 's/ //g' $dir/process/4 > $dir/process/5
sed ':a;N;$!ba;s/\n/\nkill -9 /g' $dir/process/5 > $dir/process/6
sed '1 d' $dir/process/6 > $dir/process/7
sh $dir/process/6
umount $dir/environment/sys
umount $dir/environment/proc
umount $dir/environment/dev
umount $dir/environment/etc/resolv.conf
umount $dir/environment
