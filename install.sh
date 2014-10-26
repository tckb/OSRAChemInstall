# Install script for OSRAChem
# Author tckb <tckb.504@gmail.com>


OsraChemDownloadLink='https://raw.githubusercontent.com/tckb/OSRAChemInstall/master/binaries/bundle-0.1.tgz'
OsraDownloadLink='http://downloads.sourceforge.net/project/osra/osra/2.0.0/osra-2.0.0.tgz'

printf "\n### Install script for OSRAChem ###"
printf "\n### 		v0.1		###"

printf "\n->Detecting operating system ... "
detectOS

case $OS in
	'mac' )

	printf "Mac osx"

	wget -q https://raw.githubusercontent.com/tckb/OSRAChemInstall/master/scripts/install_deb.sh -O /var/tmp/install_osx.sh
	bash /var/tmp/install_osx.sh


;;

'linux')

printf "Linux  "
if [[ $DistroBasedOn -eq 'Debian' ]]; then
	printf "(Debian flavour)"

	wget -q https://raw.githubusercontent.com/tckb/OSRAChemInstall/master/scripts/install_deb.sh -O /var/tmp/install_deb.sh
	bash /var/tmp/install_deb.sh
else
	printf "($DistroBasedOn)"
	printf "\n Sorry, only Debian based systems are supported."
	exit 0
fi

;;
esac
