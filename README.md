# Universal Chroot
Universal Chroot environment that can be deployed to most linux distros and with a portable chroot image that can be moved to one host to another.

# Build a Chroot Management System
Create your chroot scripts directory

```
sudo su #login as root
mkdir /var/chroot
mkdir /var/chroot/images #the images directory
mkdir /var/chroot/scripts #the scripts directory
mkdir /var/chroot/process #the chroot
mkdir /chroot #the chroot environment directory that will be mounted
```

/var/chroot can be anything, depends on where do you want your chroot images (The directory or partition that have enough free space). For Chrome OS it's best on /home/chronos directory and on Android it's best on /data directory.

```
cd /var/chroot/scripts #navigate to your scripts directory
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/scripts/create-chroot.sh
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/scripts/delete-chroot.sh
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/scripts/duplicate-chroot.sh
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/scripts/enter-chroot.sh
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/scripts/start-chroot.sh
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/scripts/stop-chroot.sh
```

If you have a different /var/chroot directory make sure you edit the first line of each chroot scripts to your directory:
```
#!/bin/sh
export dir=/var/chroot/
```

Install debootstrap:

```
#For Debian based
apt-get install debootstrap

#For RHEL
yum install debootstrap

#For another distro (custom debootstrap build)
#Don't do this if you can install debootstrap with package manager
cd /tmp #navigate to your tmp directory, or Download directory (any directory for trash data)
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/debootstrap/debootstrap.sh
sh debootstrap.sh
tar xvf debootstrap.tar.gz
mkdir /usr/share/debootstrap
cp debootstrap-*/debootstrap /usr/local/bin/ #or can be your another favorite bin directory
cp debootstrap-*/functions /usr/share/debootstrap/
cp -r debootstrap-*/scripts /usr/share/debootstrap/
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/debootstrap/pkgdetails -O /usr/share/debootstrap/pkgdetails
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/debootstrap/ar -O /usr/local/bin/ar #your favorite bin directory
chmod a+x /usr/share/debootstrap/pkgdetails
chmod a+x /usr/local/bin/ar
```

Setup scripts:

```
#Navigate to your favorite bin directory
cd /usr/local/bin
#Make a soft link (shortcut) of your scripts file
ln -s /var/chroot/scripts/* ./ #remember /var/chroot can be different
#For Chrome OS and Android (Skip this for another distro, Chrome OS and Android doesn't support executable shortcuts)
cp /var/chroot/scripts/* ./ #remember /var/chroot can be different

mv create-chroot.sh create-chroot
mv delete-chroot.sh delete-chroot
mv duplicate-chroot.sh duplicate-chroot
mv enter-chroot.sh enter-chroot
mv start-chroot.sh start-chroot
mv stop-chroot.sh stop-chroot

chmod a+x create-chroot
chmod a+x delete-chroot
chmod a+x duplicate-chroot
chmod a+x enter-chroot
chmod a+x start-chroot
chmod a+x stop-chroot
exit #exit from root
```

Create your first chroot image:
```
sudo create-chroot
```

Done! Now, everything you want to start your chroot just execute "sudo start-chroot".

The other scripts is as the name explain their job.
