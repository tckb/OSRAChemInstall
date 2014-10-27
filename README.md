OSRAChemInstall
===============
Install scripts and deployment for OSRAChem

Copy paste the command in terminal to install OSRAChem

<code>
	eval "$(curl -s https://raw.githubusercontent.com/tckb/OSRAChemInstall/master/install)"
</code>
You need 'curl' to download and run the script; For debian based systems, <code> sudo apt-get install curl </code> <br/>
On Mac, you can install via Homebrew </br/>
<br/>
If for any reason, you are unable to install curl, alternatively, use the below code to install OSRAChem

<code>
eval "$(wget -q -O -"$@" https://raw.githubusercontent.com/tckb/OSRAChemInstall/master/install)"
</code>


