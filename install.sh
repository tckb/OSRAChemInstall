#!/bin/bash
# Install script for OSRAChem
# Author tckb <tckb.504@gmail.com>

wget -q https://raw.githubusercontent.com/tckb/OSRAChemInstall/master/scripts/funct.sh -O /var/tmp/funct.sh
source /var/tmp/funct.sh


printf "\n### Install script for OSRAChem ###"
printf "\n### 		v0.1		###"

printf "\n->Detecting operating system ... "
detectOS

case $OS in
	'mac' )

	printf "Mac osx"

	wget -q https://raw.githubusercontent.com/tckb/OSRAChemInstall/master/scripts/install_osx.sh -O /var/tmp/install_osx.sh
	chmod a+x /var/tmp/install_osx.sh
	/var/tmp/install_osx.sh


;;

'linux')

printf "Linux  "
if [[ $DistroBasedOn -eq 'Debian' ]]; then
	printf "(Debian flavour)"

	wget -q https://raw.githubusercontent.com/tckb/OSRAChemInstall/master/scripts/install_deb.sh -O /var/tmp/install_deb.sh
	chmod a+x /var/tmp/install_deb.sh
	/var/tmp/install_deb.sh
else
	printf "($DistroBasedOn)"
	printf "\n Sorry, only Debian based systems are supported."
	exit 0
fi

;;
esac
