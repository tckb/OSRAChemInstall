#!/bin/bash
# Install script for OSRAChem
# Author tckb <tckb.504@gmail.com>

source $(dirname $0)/scripts/funct.sh
source $(dirname $0)/scripts/install_osx.sh
source $(dirname $0)/scripts/install_deb.sh

# Public links

OsraChemDownloadLink='https://www.dropbox.com/s/k68a8ai09u4z18v/bundle-0.1.tgz'
OsraDownloadLink='http://downloads.sourceforge.net/project/osra/osra/2.0.0/osra-2.0.0.tgz'

printf "\n### Install script for OSRAChem ###"
printf "\n### 		v0.1		###"

printf "\n->Detecting operating system ... "
detectOS

case $OS in
	'mac' )

	printf "Mac osx"
	do_install_osx

;;

'linux')

printf "Linux  "
if [[ $DistroBasedOn -eq 'Debian' ]]; then
	printf "(Debian flavour)"
	do_install_deb
else
	printf "($DistroBasedOn)"
	printf "\n Sorry, only Debian based systems are supported."
	exit 0
fi

;;
esac
