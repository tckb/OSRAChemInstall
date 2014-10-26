# Install script for OSRAChem
# Author tckb <tckb.504@gmail.com>

##### Function declarations

# functions are all posix compliant
OsraChemDownloadLink='https://raw.githubusercontent.com/tckb/OSRAChemInstall/master/binaries/bundle-0.1.tgz'
OsraDownloadLink='http://downloads.sourceforge.net/project/osra/osra/2.0.0/osra-2.0.0.tgz'


detectOS(){
# Original source : https://github.com/coto/server-easy-install/blob/master/lib/core.sh
# Modified to support osx

OpSys=`uname| tr '[:upper:]' '[:lower:]'` # OpSys=`lowercase \`uname\`` ==> 'lowercase' is not posix standard
Kernl=`uname -r`
MACH=`uname -m`
if [ "${OpSys}" == "windowsnt" ]; then
	OpSys=windows
elif [ "${OpSys}" == "darwin" ]; then
	OpSys=mac
else
	OpSys=`uname`
	if [ "${OpSys}" = "SunOS" ] ; then
		OpSys=Solaris
		ARCH=`uname -p`
		OSSTR="${OpSys} ${REV}(${ARCH} `uname -v`)"
	elif [ "${OpSys}" = "AIX" ] ; then
		OSSTR="${OpSys} `oslevel` (`oslevel -r`)"
	elif [ "${OpSys}" = "Linux" ] ; then
		if [ -f /etc/redhat-release ] ; then
			LinuxFlavour='RedHat'
			Dst=`cat /etc/redhat-release |sed s/\ release.*//`
			PSUEDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
			REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
		elif [ -f /etc/SuSE-release ] ; then
			LinuxFlavour='SuSe'
			PSUEDONAME=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
			REV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
		elif [ -f /etc/mandrake-release ] ; then
			LinuxFlavour='Mandrake'
			PSUEDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
			REV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
		elif [ -f /etc/debian_version ] ; then
			LinuxFlavour='Debian'
			if [ -f /etc/lsb-release ] ; then
				Dst=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F= '{ print $2 }'`
				PSUEDONAME=`cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F= '{ print $2 }'`
				REV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F= '{ print $2 }'`
			fi
		fi
		if [ -f /etc/UnitedLinux-release ] ; then
			Dst="${Dst}[`cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//`]"
		fi
		OpSys=`uname| tr '[:upper:]' '[:lower:]'`
		LinuxFlavour=`echo $LinuxFlavour | tr '[:upper:]' '[:lower:]'`
		readonly OpSys
		readonly Dst
		readonly LinuxFlavour
		readonly PSUEDONAME
		readonly REV
		readonly Kernl
		readonly MACH
	fi
fi

}
check_install(){
	if [[ $? -ne 0 ]]; then
		printf "failed, please check ochem.log file"
		exit 1
	else
		printf "done"
	fi
}
# Pass the command name to the function
# returns 0 if the command exists else, 1  if does not
check_command(){

printf  "\n[ Checking for $1 ..."
hash $1 &>/dev/null
# Command does not exists
if [[ $? -ne 0 ]]; then
	printf "not found ]"
	return 1
else
	printf "found ]"
	return 0
fi
}

DownloadOSRAChem(){

	wget -q $OsraChemDownloadLink -O osrachem.tgz
	if [[ $? -ne 0 ]]; then
		printf "\nDownload failed, check the installation link for OsrChem"
		exit 1
	fi
	tar -zxvf osrachem.tgz & >> ochem.log

}

RunOSRAChem(){
	printf "\nRunning OsraChem...\n"
	cd OsraChem
	java -jar OSRAChem.jar
}

DownloadAndRunOsraChem(){
	DownloadOSRAChem
	RunOSRAChem
}

############### End of function declarations