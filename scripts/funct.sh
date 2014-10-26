# Install script for OSRAChem
# Author tckb <tckb.504@gmail.com>

##### Function declarations

# functions are all posix compliant

detectOS(){
# Original source : https://github.com/coto/server-easy-install/blob/master/lib/core.sh
# Modified to support osx

OS=`uname| tr '[:upper:]' '[:lower:]'` # OS=`lowercase \`uname\`` ==> 'lowercase' is not posix standard
KERNEL=`uname -r`
MACH=`uname -m`
if [ "${OS}" == "windowsnt" ]; then
	OS=windows
elif [ "${OS}" == "darwin" ]; then
	OS=mac
else
	OS=`uname`
	if [ "${OS}" = "SunOS" ] ; then
		OS=Solaris
		ARCH=`uname -p`
		OSSTR="${OS} ${REV}(${ARCH} `uname -v`)"
	elif [ "${OS}" = "AIX" ] ; then
		OSSTR="${OS} `oslevel` (`oslevel -r`)"
	elif [ "${OS}" = "Linux" ] ; then
		if [ -f /etc/redhat-release ] ; then
			DistroBasedOn='RedHat'
			DIST=`cat /etc/redhat-release |sed s/\ release.*//`
			PSUEDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
			REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
		elif [ -f /etc/SuSE-release ] ; then
			DistroBasedOn='SuSe'
			PSUEDONAME=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
			REV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
		elif [ -f /etc/mandrake-release ] ; then
			DistroBasedOn='Mandrake'
			PSUEDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
			REV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
		elif [ -f /etc/debian_version ] ; then
			DistroBasedOn='Debian'
			if [ -f /etc/lsb-release ] ; then
				DIST=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F= '{ print $2 }'`
				PSUEDONAME=`cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F= '{ print $2 }'`
				REV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F= '{ print $2 }'`
			fi
		fi
		if [ -f /etc/UnitedLinux-release ] ; then
			DIST="${DIST}[`cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//`]"
		fi
		OS=`uname| tr '[:upper:]' '[:lower:]'`
		DistroBasedOn=`echo $DistroBasedOn | tr '[:upper:]' '[:lower:]'`
		# readonly OS
		# readonly DIST
		# readonly DistroBasedOn
		# readonly PSUEDONAME
		# readonly REV
		# readonly KERNEL
		# readonly MACH
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

	tar -zxvf osrachem.tgz &>>ochem.log


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