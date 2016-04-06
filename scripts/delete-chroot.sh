#!/bin/sh
export dir=/var/chroot/
echo "Your chroot images:
$(ls $dir/images/ | sed 's/.img//g')
"
read -p "Type your image name for deletion: " image
rm $dir/images/$image.img
