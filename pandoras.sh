#!/bin/env bash
################################################################################
#                                   Pandoras                                   #
#                                                                              #
# Universal Chroot environment that can be deployed to most Linux distros      #
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
# Export dir if required
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

# Routes options
route_option() {

	# Path to functions
	export dir=/var/pandoras/includes

	#command="$1 ""$2";

	case "$1" in

		'start-box')
      start_box.sh 
			;;
		'stop-box')
      stop_box.sh
			;;
		'create-box')
      create_box.sh
			;;
		'delete-box')
      delete_box.sh
			;;
		'duplicate-box')
      duplicate_box.sh 
			;;
		'enter-box')
      enter_box.sh 
			;;
		'list-boxes')
      list_boxes.sh
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

}

main() {
route_option "$1";
}

main "$1";

exit 99

