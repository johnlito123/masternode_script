#/bin/bash
echo ""
echo "................................................................................"
echo "......................................N0OKW....................................."
echo "....................................W0c'.,dX...................................."
echo "..................................WKo'.....:ON.................................."
echo ".................................Nx;........'lKW................................"
echo "...............................WO:............,xX..............................."
echo ".............................WKl'...............cOW............................."
echo "............WWWWWWWWWWWWWWWWWN0xxxxxxxxxxxxxxxxxxOXWWWWWWWWWWWWWWWWWW..........."
echo "............WWNNNNNNNNWWWWXOxxxxxxdddddddddddxxxdkKNNNNNNNNNNNNNNNWW............"
echo "..............WWNNNNNNWMW0l'....................;xXNNNNNNNNNNNNNWW.............."
echo "................WWNNNNWXd,.....................l0NNNNNNNNNNNNNWW................"
echo "...................WWNk::cccccccc:...........;xXNNNNNNNNNNNNWW.................."
echo "...................W0o,'xXNNNNNNNXx;.......'o0NNNNNNNNNNNX00N..................."
echo ".................WKo,..'oXNNNNNNNNNKd,....:kXNNNNNNNNNNX0o,,l0W................."
echo "................Nx;.....,lOXNNNNNNNNNOl::dKNNNNNNNNNNXOl'....;dX................"
echo "..............WOc'........,o0XNNNNNNNNXXXNNNNNNNNNNXOl'.......':kN.............."
echo "............WKo,............,o0XNNNNNNNNNNNNNNNNNXOl,...........'l0W............"
echo "...........Xx;................;dKNNNNNNNNNNNNNNXOl,...............,dXW.........."
echo ".........Nk:'...................:kNNNNNNNNNNNNKo,...................;kN........."
echo "........Nx,....................,o0NNNNNNNNNNNNKd,....................'xW........"
echo "........WKl'..................:xKXXXXXXXXXXXXXXXOc'.................,dXW........"
echo "..........Nk;...............'lk0000000OkkO0000000Od:'.............'c0W.........."
echo "...........WKl'............:xO000000Oxc,,:dO0000000ko;'.''.''..'';xX............"
echo ".............Nk;.........,oO000000Oxc'....':xO000000Okl,''''.'''l0W............."
echo "..............WKl'......:dkOO000Oxc'........,cxO000000Od;'''.';xX..............."
echo "................Nk;...,lxkkkkkkdc'............,cxO00000k:''''c0W................"
echo ".................WKl,:dkkkkkxo;................',lxOOOOx;;llxX.................."
echo "..................WKkxkkkkxo;....................',;:::;';x0XW.................."
echo ".................WKOkkkkxo;...........................'';d000KN................."
echo "...............WN0kkkkkOo'............................'c0NK0000XW..............."
echo "..............NKOkkkkk0KOl;,,,,,,,,,,,,,,,,,,,,,,,,;;:o0NNK00000KNW............."
echo ".............N0OOkkkOOOOOOkkxddddddddddddddddddddddxkkOO00000000KKNW............"
echo "............WWNNNNNNNNNNNNNXx:'''''''''''''''''''':kXNNNNNNWWWWWWWW............."
echo "............................WO:..................:OW............................"
echo ".............................MXo'..............'oX.............................."
echo "...............................WO:............:OW..............................."
echo ".................................Xo'........'oX................................."
echo "..................................WO:......;OW.................................."
echo "....................................Xo'..'oK...................................."
echo ".....................................W0ddON....................................."
echo ""
echo "****************************************************************************"
echo "* This script will install and configure your XUEZ Coin masternodes.       *"
echo "*                 										                 *"
echo "*    If you have any issues please ask for help on the XUEZ discord.       *"
echo "*                      https://discord.gg/QWcK5Yk                          *"
echo "*                        https://xuezcoin.com/                             *"
echo "****************************************************************************"
echo ""
echo ""
echo ""
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
	echo ""
	echo ""
	echo ""
	./xuez-cli stop
	rm xuezd
	rm xuez-cli
	rm xuez-tx
	wget https://bitbucket.org/davembg/xuez-distribution-repo/downloads/xuez-linux-cli-10110.tgz
	tar -xf xuez-linux-cli-10110.tgz
	rm xuez-linux-cli-10110.tgz
	sudo su -c "echo 'listenonion=1' >> $CONF_DIR/$CONF_FILE"
echo "Masternode Configuration"
echo "Your recognised IP address is:"
sudo hostname -I

echo "Is this the IP you wish to use for MasterNode ? [y/n] , followed by [ENTER]"
read ipd
	if [[ $ipd =~ "y" ]] || [[$ipd =~ "Y" ]] ; then
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
	sudo su -c "echo 'listenonion=1' >> $CONF_DIR/$CONF_FILE"
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
