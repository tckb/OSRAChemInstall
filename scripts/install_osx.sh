# Install script for OSRAChem
# Author tckb <tckb.504@gmail.com>

wget -q https://raw.githubusercontent.com/tckb/OSRAChemInstall/master/scripts/funct.sh -O /var/tmp/funct.sh
source $(dirname $0)/funct.sh


printf "\n->Checking for dependencies... "

check_command brew

if [[ $? -ne 0 ]]; then

	printf "\n->Installing Homebrew ..."
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
	printf"..finished \n"

	printf "\n->Checking for homebrew"
	check_command brew
	if [[ $? -eq 0 ]]; then
		printf "\n->Installation successful!.. continuing"
	else
		printf "\n->Installation failed! exiting "
		exit 1
	fi

fi

printf "\n->Installing resources for homebrew...\n"
brew tap mcs07/cheminformatics

printf "\n->Installing osra\n"
brew install osra

check_command osra

if [[ $? -ne 0 ]]; then
	printf "\n->Osra installation failed! aborting"
	exit 1
fi

check_command java
if [[ $? -eq 0 ]]; then
	printf "\n->All dependencies are satisfied"
	DownloadAndRunOsraChem
else
	printf "\n->Java not found on System. Download and install Java and re-reun the install script  "

fi
