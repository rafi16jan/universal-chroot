#!/bin/env bash
################################################################################
#                                   Pandoras                                   #
#                                                                              #
# Universal Chroot environment that can be deployed to most linux distros      #
#                                                                              #
# Change History                                                               #
# 12/11/2023  Esteban Herrera Original code.                                   #
#                           Add new history entries as needed.                 #
#                                                                              #
#                                                                              #
################################################################################
################################################################################
################################################################################
#                                                                              #
#  Copyright (c) 2023-present Esteban Herrera C.                               #
#  stv.herrera@gmail.com                                                       #
#                                                                              #
#  This program is free software; you can redistribute it and/or modify        #
#  it under the terms of the GNU General Public License as published by        #
#  the Free Software Foundation; either version 3 of the License, or           #
#  (at your option) any later version.                                         #
#                                                                              #
#  This program is distributed in the hope that it will be useful,             #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of              #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               #
#  GNU General Public License for more details.                                #
#                                                                              #
#  You should have received a copy of the GNU General Public License           #
#  along with this program; if not, write to the Free Software                 #
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   #

# pandoras
# Universal Chroot environment that can be deployed to most linux distros
# Starts the.
# 
# Run the application using sudo and with parameters, for example:
# shell> sudo pandoras start-box

# TODO:
# Export dir
#export dir=/var/chroot/

# Prints license
display_license() {

cat <<EOT
Copyright (c) 2023-present Esteban Herrera                                  
stv.herrera@gmail.com                                                       

This program is free software; you can redistribute it and/or modify        
it under the terms of the GNU General Public License as published by        
the Free Software Foundation; either version 3 of the License, or           
(at your option) any later version.                                         

This program is distributed in the hope that it will be useful,             
but WITHOUT ANY WARRANTY; without even the implied warranty of              
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               
GNU General Public License for more details.                                

You should have received a copy of the GNU General Public License           
along with this program; if not, write to the Free Software                 
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   
EOT
}

# Prints help
display_help() {

cat <<EOT
Pandoras (v0.0.1)

Options Usage: pandoras [option]

Boxes Options:
  	start-box		Starts chroot
  	stop-box		Stops chroot
  	create-box		Creates chroot
  	delete-box		Deletes chroot
  	duplicate-box		Duplicates chroot
  	enter-box		Enters the chroot
  	list-boxes		Lists all the chroots

Other Options:
	-g, --license		Print the GPL license notification
	-h, --help		Print this Help
	-V, -v, --version		Print software version and exit

EOT
}

# Prints version
display_version() {
	echo "Commbase (v0.0.1)";
}

# Starts chroot
start-box() {
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
} 

# Stops chroot
stop_box() {
export dir=/var/chroot/
lsof | grep "/environment/" > $dir/process/1
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
}

# Creates chroot
create_box() {
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
}

# Deletes chroot
delete_box() {
export dir=/var/chroot/
echo "Your chroot images:
$(ls $dir/images/ | sed 's/.img//g')
"
read -p "Type your image name for deletion: " image
rm $dir/images/$image.img
}

# Duplicates chroot
duplicate_box() {
export dir=/var/chroot/
echo "Your chroot images:
$(ls $dir/images/ | sed 's/.img//g')
"
read -p "Type your old image name: " old
read -p "Type your new image name: " new
cp $dir/images/$old.img $dir/images/$new.img
}

# Enters the chroot
enter-box() {
export dir=/var/chroot/
chroot $dir/environment /bin/su -
} 

# Lists all the chroots
list_boxes() {

}

# Routes options
route_option() {
	command="$1 ""$2";

	case "$1" in

		'start-box')
      start-box 
			;;
		'stop-box')
      stop_box
			;;
		'create-box')
      create_box
			;;
		'delete-box')
      delete_box
			;;
		'duplicate-box')
      duplicate_box 
			;;
		'enter-box')
      enter-box 
			;;
		'list-boxes')
      list_boxes
			;;			
	  '-g' | '--license')
	    display_license | more
			exit 99
			;;
	  '-h' | '--help')
	    display_help | less
			exit 99
			;;
	  '-V' | '-v' | '--version')
	    display_version
			exit 99
			;;
	esac

main() {
route_option $1;
}

main $1;

exit 99

