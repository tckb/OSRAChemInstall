#!/bin/bash
# Install script for OSRAChem
# Author tckb <tckb.504@gmail.com>

wget -q https://raw.githubusercontent.com/tckb/OSRAChemInstall/master/scripts/funct -O /var/tmp/funct
source /var/tmp/funct


printf "\n### Install script for OSRAChem ###"
printf "\n### 		v0.1		###"

printf "\n->Detecting operating system ... "
detectOS

case $OS in
	'mac' )

	printf "Mac osx"

	wget -q https://raw.githubusercontent.com/tckb/OSRAChemInstall/master/scripts/install_osx -O /var/tmp/install_osx
	chmod a+x /var/tmp/install_osx
	/var/tmp/install_osx


;;

'linux')

printf "Linux  "
if [[ $DistroBasedOn -eq 'Debian' ]]; then
	printf "(Debian flavour)"

	wget -q https://raw.githubusercontent.com/tckb/OSRAChemInstall/master/scripts/install_deb -O /var/tmp/install_deb
	chmod a+x /var/tmp/install_deb
	/var/tmp/install_deb
else
	printf "($DistroBasedOn)"
	printf "\n Sorry, only Debian based systems are supported."
	exit 0
fi

;;
esac
