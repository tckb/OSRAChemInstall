#!/bin/bash
# Install script for OSRAChem
# Author tckb <tckb.504@gmail.com>

do_install_deb(){
	check_command osra
	if [[ $? -ne 0 ]]; then



		check_command apt-get

		if [[ $? -eq 0 ]]; then

			printf "\n->Installing the dependencies ..."
			rm -fr osra-dep; mkdir osra-dep
			cd osra-dep


			printf "\n->Installing Graphicsmagick..."
			sudo apt-get -f install graphicsmagick graphicsmagick-imagemagick-compat graphicsmagick-libmagick-dev-compat libghc-hsmagick-dev  libgraphicsmagick++1-dev libgraphicsmagick1-dev  libgraphicsmagick++3 libgraphicsmagick3 >>ochem.log
			check_install

			printf "\n->Installing OpenBabel,tclap, potrace..."	
			sudo apt-get -f install libpotrace0 libpotrace-dev libocrad-dev libtclap-dev libopenbabel-dev &>>ochem.log
			check_install

			printf "\n->Installing GOCR-patched..."
			wget -q http://downloads.sourceforge.net/project/osra/gocr-patched/gocr-0.50pre-patched.tgz -O gocr.tgz
			tar -zxvf gocr.tgz >>ochem.log
			cd gocr*
			./configure &>>ochem.log
			sudo make libs &>>ochem.log
			sudo make install &>>ochem.log
			check_install


			printf "\n->Installing ocrad..."
			cd ..
			wget -q http://ftp.heanet.ie/mirrors/gnu/ocrad/ocrad-0.21.tar.gz -O ocrad.tgz
			tar -zxvf ocrad.tgz &>>ochem.log
			cd ocrad*
			./configure &>>ochem.log
			sudo make all &>>ochem.log
			check_install

			printf "\n->Installing osra..."
			wget -q $OsraDownloadLink -O osra.tgz
			tar -zxvf osra.tgz &>>ochem.log
			cd osra*
			./configure &>>ochem.log
			sudo make all &>>ochem.log
			check_install

		# remove temporary files
		rm -fr osra-dep

		check_command java
		if [[ $? -eq 0 ]]; then
			printf "\n->All dependencies are satisfied; Installing OSRAChem\n"
		else
			sudo apt-get install openjdk-7-jdk 	&>>ochem.log
		fi

	else
		printf "\n->Cannot install from terminal! quitting"
		exit 1

	fi
else
	printf "\nOsra already installed; Downloding OSRAChem"
fi

DownloadAndRunOsraChem



}