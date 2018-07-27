#/bin/bash
cd ~
rm -rf Xuez_Setup.sh* XuezUpdate.sh*
./xuez-cli stop
echo "****************************************************************************"
echo "* This script will install and configure your XUEZ Coin masternodes.       *"
echo "*                    Love from A_Block_Nut(Thermo) ;)                      *"
echo "*    If you have any issues please ask for help on the XUEZ discord.       *"
echo "*                      https://discord.gg/QWcK5Yk                          *"
echo "*                        https://xuezcoin.com/                             *"
echo "****************************************************************************"
echo "" 
echo ""
echo "!!!!!!!!!!PLEASE READ CAREFULLY!!!!!!!!!!!!!!!"
echo ""
echo "***********************************************************************************"
echo "* It is very important to install your masternode under a new user rather than root.*"
echo "* 		Please enter one of the option	below				*"
echo "*	------------------------OPTIONS BELOW-------------------------------------------*"
echo "* 1 - Enter "Y" If you are running this Script as the root 			*"
echo "* 2 - Enter "Y" If you want to access your user - Maintenance/Update only		 *"
echo "*											*"
echo "* 3 - Enter "N" if you are running this Script under your new user.		*"
echo "* 4 - Enter "N" If you want to install your Masternode under root (not recommeneded) *"
echo "*											*"
echo "*											*"
echo "***********************************************************************************"
read USRSETUP
	if 
		[[ $USRSETUP =~ "y" ]] || [[$USRSETUP =~ "Y" ]] ; then
	
		sudo adduser xuez
		usermod -aG sudo xuez
		sudo su - xuez
	fi
echo ""
echo ""
echo ""
echo "Do you to use our Express Masternode/Wallet installation? [y/n], followed by [ENTER]"
echo ""
echo ""
read EXSETUP
	if 
		if
			[[ $EXSETUP =~ "y" ]] || [[$EXSETUP =~ "Y" ]] ; then
			sudo su -c "echo 'deb http://deb.torproject.org/torproject.org '$(lsb_release -c | cut -f2)' main' > /etc/apt/sources.list.d/torproject.list"
			gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
			gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
			sudo apt-get update
			sudo apt-get install tor deb.torproject.org-keyring -y
			sudo usermod -a -G debian-tor $(whoami)

			sudo sed -i 's/#ControlPort 9051/ControlPort 9051/g' /etc/tor/torrc
			sudo sed -i 's/#CookieAuthentication 1/CookieAuthentication 1/g' /etc/tor/torrc 
			sudo su -c "echo 'CookieAuthFileGroupReadable 1' >> /etc/tor/torrc"
			sudo su -c "echo 'LongLivedPorts 9033' >> /etc/tor/torrc"
			sudo systemctl restart tor.service
			rm -rf Xuez_Setup.sh* XuezUpdate.sh*
			./xuez-cli stop	
			sudo apt-get update
			sudo apt-get -y upgrade
			sudo apt-get -y dist-upgrade
			sudo apt-get install -y ufw
			sudo ufw allow ssh/tcp
			sudo ufw limit ssh/tcp
			sudo ufw logging on
			sudo ufw allow 22
			sudo ufw allow 41798
			sudo ufw allow 9033
			echo "y" | sudo ufw enable
			sudo ufw status
			./xuez-cli stop
			rm xuezd
			rm xuez-cli
			rm xuez-tx
			wget https://github.com/XUEZ/xuez/releases/download/1.0.1.10/xuez-linux-cli-10110.tgz
			tar -xf xuez-linux-cli-10110.tgz
			rm xuez-linux-cli-10110.tgz
			sudo su -c "echo 'listenonion=1' >> /$CONF_DIR/$CONF_FILE"
		fi

		echo "Masternode Configuration"
		echo "Your recognised IP address is:"
		sudo hostname -I 
		echo "Is this the IP you wish to use for MasterNode ? [y/n] , followed by [ENTER]"
		read IPDEFAULT
	
		if
			[[ $IPDEFAULT =~ "y" ]] || [[$IPDEFAULT =~ "Y" ]] ; then
			echo ""
			echo "We are using your default IP address"
			echo "Enter masternode private key for node, followed by [ENTER]: $ALIAS"
			read PRIVKEY
			CONF_DIR=~/.xuez\/
			CONF_FILE=xuez.conf
			PORT=41798
			IP=$(hostname -I)
			mkdir -p $CONF_DIR
			echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
			echo "rpcpassword=passw"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
			echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
			echo "listen=1" >> $CONF_DIR/$CONF_FILE
			echo "server=1" >> $CONF_DIR/$CONF_FILE
			echo "daemon=1" >> $CONF_DIR/$CONF_FILE
			echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
			echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
			echo "masternode=1" >> $CONF_DIR/$CONF_FILE
			echo "" >> $CONF_DIR/$CONF_FILE
			echo "" >> $CONF_DIR/$CONF_FILE
			echo "port=$PORT" >> $CONF_DIR/$CONF_FILE
			echo "masternodeaddr=$IP:$PORT" >> $CONF_DIR/$CONF_FILE
			echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE
			sudo su -c "echo 'listenonion=1' >> /.xuez/xuez.conf"
			./xuezd -resync
			echo "if server start failure try ./xuezd -reindex"
			echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			echo "!                                                 !"
			echo "! Your MasterNode Is setup please close terminal  !"
			echo "!   and continue the local wallet setup guide     !"
			echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			echo ""
		else	
			echo "Type the custom IP of this node, followed by [ENTER]:"
			read DIP
			echo ""
			echo "Enter masternode private key for node, followed by [ENTER]: $ALIAS"
			read PRIVKEY
			CONF_DIR=~/.xuez\/
			CONF_FILE=xuez.conf
			PORT=41798
			mkdir -p $CONF_DIR
			echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
			echo "rpcpassword=passw"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
			echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
			echo "listen=1" >> $CONF_DIR/$CONF_FILE
			echo "server=1" >> $CONF_DIR/$CONF_FILE
			echo "daemon=1" >> $CONF_DIR/$CONF_FILE
			echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
			echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
			echo "masternode=1" >> $CONF_DIR/$CONF_FILE
			echo "" >> $CONF_DIR/$CONF_FILE
			echo "" >> $CONF_DIR/$CONF_FILE
			echo "port=$PORT" >> $CONF_DIR/$CONF_FILE
			echo "masternodeaddr=$DIP:$PORT" >> $CONF_DIR/$CONF_FILE
			echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE
			sudo su -c "echo 'listenonion=1' >> /.xuez/xuez.conf"
			./xuezd -resync
			echo "if server start failure try ./xuezd -reindex"
			echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			echo "!                                                 !"
			echo "! Your MasterNode Is setup please close terminal  !"
			echo "!   and continue the local wallet setup guide     !"
			echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			echo ""
		fi
	else 
		echo ""
		echo "Do you want TOR Integrated into this VPS? [y/n], followed by [ENTER]"
		echo ""
		echo ""
		read TSETUP
		if 
			[[ $TSETUP =~ "y" ]] || [[$TSETUP =~ "Y" ]] ; then
			sudo su -c "echo 'deb http://deb.torproject.org/torproject.org '$(lsb_release -c | cut -f2)' main' > /etc/apt/sources.list.d/torproject.list"
			gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
			gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
			sudo apt-get update
			sudo apt-get install tor deb.torproject.org-keyring -y
			sudo usermod -a -G debian-tor $(whoami)

			sudo sed -i 's/#ControlPort 9051/ControlPort 9051/g' /etc/tor/torrc
			sudo sed -i 's/#CookieAuthentication 1/CookieAuthentication 1/g' /etc/tor/torrc 
			sudo su -c "echo 'CookieAuthFileGroupReadable 1' >> /etc/tor/torrc"
			sudo su -c "echo 'LongLivedPorts 9033' >> /etc/tor/torrc"
			sudo systemctl restart tor.service
			rm -rf Xuez_Setup.sh* XuezUpdate.sh*
			./xuez-cli stop
		fi
		echo ""
		echo ""
		echo "Do you want to configure your VPS with Xuez recommended settings? [y/n], followed by [ENTER]"
		read DOSETUP
		if 
			[[ $DOSETUP =~ "y" ]] || [[$DOSETUP =~ "Y" ]] ; then
			sudo apt-get update
			sudo apt-get -y upgrade
			sudo apt-get -y dist-upgrade
	
			sudo apt-get install -y ufw
			sudo ufw allow ssh/tcp
			sudo ufw limit ssh/tcp
			sudo ufw logging on
			sudo ufw allow 22
			sudo ufw allow 41798
			sudo ufw allow 9033
			echo "y" | sudo ufw enable
			sudo ufw status
		fi
		echo ""
		echo ""
		echo ""
		echo "Are you installing/updating your Masternode? [y/n]"
		read MSETUP
		if
			[[ $MSETUP =~ "y" ]] || [[$MSETUP =~ "Y" ]] ; then
			./xuez-cli stop
			rm xuezd
			rm xuez-cli
			rm xuez-tx
			wget https://github.com/XUEZ/xuez/releases/download/1.0.1.10/xuez-linux-cli-10110.tgz
			tar -xf xuez-linux-cli-10110.tgz
			rm xuez-linux-cli-10110.tgz
			sudo su -c "echo 'listenonion=1' >> /.xuez/xuez.conf"
			echo "Masternode Configuration"
			echo "Your recognised IP address is:"
			sudo hostname -I 
			echo "Is this the IP you wish to use for MasterNode ? [y/n] , followed by [ENTER]"
			read IPDEFAULT
			if
				[[ $IPDEFAULT =~ "y" ]] || [[$IPDEFAULT =~ "Y" ]] ; then
				echo ""
				echo "We are using your default IP address"
				echo "Enter masternode private key for node, followed by [ENTER]: $ALIAS"
				read PRIVKEY
				CONF_DIR=~/.xuez\/
				CONF_FILE=xuez.conf
				PORT=41798
				IP=$(hostname -I)
				mkdir -p $CONF_DIR
				echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
				echo "rpcpassword=passw"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
				echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
				echo "listen=1" >> $CONF_DIR/$CONF_FILE
				echo "server=1" >> $CONF_DIR/$CONF_FILE
				echo "daemon=1" >> $CONF_DIR/$CONF_FILE
				echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
				echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
				echo "masternode=1" >> $CONF_DIR/$CONF_FILE
				echo "" >> $CONF_DIR/$CONF_FILE
				echo "" >> $CONF_DIR/$CONF_FILE
				echo "port=$PORT" >> $CONF_DIR/$CONF_FILE
				echo "masternodeaddr=$IP:$PORT" >> $CONF_DIR/$CONF_FILE
				echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE
				sudo su -c "echo 'listenonion=1' >> /.xuez/xuez.conf"
				./xuezd -resync
				echo "if server start failure try ./xuezd -reindex"
				echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
				echo "!                                                 !"
				echo "! Your MasterNode Is setup please close terminal  !"
				echo "!   and continue the local wallet setup guide     !"
				echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
				echo ""
			else	
				echo "Type the custom IP of this node, followed by [ENTER]:"
				read DIP
				echo ""
				echo "Enter masternode private key for node, followed by [ENTER]: $ALIAS"
				read PRIVKEY
				CONF_DIR=~/.xuez\/
				CONF_FILE=xuez.conf
				PORT=41798
				mkdir -p $CONF_DIR
				echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
				echo "rpcpassword=passw"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
				echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
				echo "listen=1" >> $CONF_DIR/$CONF_FILE
				echo "server=1" >> $CONF_DIR/$CONF_FILE
				echo "daemon=1" >> $CONF_DIR/$CONF_FILE
				echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
				echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
				echo "masternode=1" >> $CONF_DIR/$CONF_FILE
				echo "" >> $CONF_DIR/$CONF_FILE
				echo "" >> $CONF_DIR/$CONF_FILE
				echo "port=$PORT" >> $CONF_DIR/$CONF_FILE
				echo "masternodeaddr=$DIP:$PORT" >> $CONF_DIR/$CONF_FILE
				echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE
				sudo su -c "echo 'listenonion=1' >> /.xuez/xuez.conf"
				./xuezd -resync
				echo "if server start failure try ./xuezd -reindex"
				echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
				echo "!                                                 !"
				echo "! Your MasterNode Is setup please close terminal  !"
				echo "!   and continue the local wallet setup guide     !"
				echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
				echo ""
			fi
		fi
	fi
	
echo ""
echo ""
echo ""
echo ""
echo ""
echo "Would you like to Activate your Masternode under the TOR Network? [y/n], followed by [ENTER]"
	read TORSETUP
	if 
		[[ $TORSETUP =~ "y" ]] || [[$TORSETUP =~ "Y" ]] ; then
		./xuez-cli getnetworkinfo
		echo "Please copy the TOR Output address EG.aedFAWE235AGa2.onion above"
		echo "onto your notepad then change your IP:PORT into TOR:Port"
		echo " for the next part of this script"
		echo ""
		echo "For example 15.123.15.34:41798 into aedFAWE235AGa2.onion:47198"
		echo "on both Local and VPS xuez.conf file"
		echo ""
		echo ""
		echo "*****Ready to carry on? [y/n], followed by [ENTER]*****"
	fi
	read CARRYONSETUP
	if 
		[[ $CARRYONSETUP =~ "y" ]] || [[$CARRYONSETUP =~ "Y" ]] ; then
		cd
		./xuez-cli stop
		cd .xuez 
		vi xuez.conf
		./xuezd -reindex
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!                                                 !"
		echo "! Your MasterNode Is TOR Configured close the terminal  !"
		echo "!   and continue the local wallet setup 	     !"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo ""
	fi
