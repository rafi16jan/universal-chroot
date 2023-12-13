[![Shell Linter](https://github.com/estebanways/pandoras/actions/workflows/shell-linter.yml/badge.svg)](https://github.com/estebanways/pandoras/actions/workflows/shell-linter.yml)

# Pandoras

Universal Chroot environment that can be deployed to most linux distros and with a portable chroot image that can be moved to one host to another.

<img alt="sword-vim" src="./images/pandoras.jpg?raw=true" width="500" height="320" />

## Build a Chroot Management System

### Create your chroot directory

Login as root.

```shell
sudo su -
```

Navigate to your /var directory.

```shell
cd /var
```

Create the Pandoras directories.

```
git clone git@github.com:estebanways/pandoras.git
```

This is going to create the directories:

`/var/pandoras`: Your chroot directory.
<br />`/var/pandoras/images`: The images directory.
<br />`/var/pandoras/process`: The process directory.
<br />`/var/pandoras/environment`: The chroot environment directory that will be mounted.

If you want to have a chroot directory instead of /var/pandoras make sure you edit the Pandoras script to your directory.

/var/pandoras can be anything, depends on where you do want to put your chroot images (The directory or partition that have enough free space). For Chrome OS it's best on /home/chronos directory and on Android it's best on /storage or /data directory.

```shell
#!/bin/env bash
export dir=#your custom directory, or just leave it if you want to use /var/chroot
```
Keep in mind that the availability and functionality of Bash may vary based on the specific device, Android version, or Chromebook model you are using.

## Install Debootstrap

For Debian based distributions, run:

```shell
apt-get update
apt-get install debootstrap
```

For RHEL, do run:

```shell
yum install debootstrap
```

For another distro (custom debootstrap build):

Don't do this if you can install debootstrap with package manager.

```shell
cd /tmp  # Navigate to your tmp directory, or Download directory (any directory for trash data)
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/debootstrap/debootstrap.sh
sh debootstrap.sh
tar xvf debootstrap.tar.gz
mkdir /usr/share/debootstrap
cp debootstrap-*/debootstrap /usr/bin/  # Or can be your another favorite bin directory
cp debootstrap-*/functions /usr/share/debootstrap/
cp -r debootstrap-*/scripts /usr/share/debootstrap/
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/debootstrap/pkgdetails -O /usr/share/debootstrap/pkgdetails
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/debootstrap/ar -O /usr/local/bin/ar # Your favorite bin directory
chmod a+x /usr/share/debootstrap/pkgdetails
chmod a+x /usr/bin/ar
```

## Setup the Pandoras script

Navigate to your favorite bin directory.

```shell
cd /usr/bin
```

Make a soft link (shortcut) of your scripts file.

```
ln -s /var/pandoras/pandoras.sh ./pandoras  # Remember /var/pandoras can be different
chmod a+x pandoras
exit  # Exit from root
```

`a+x`: This part specifies the change to be made. Here, a refers to "all users," and +x means to add the execute permission.

Create your first chroot image.

```
sudo pandoras create-box
```

Done! Now, everything you want to start your chroot just execute `sudo pandoras start-box`.

The other scripts is as the name explain their job.
