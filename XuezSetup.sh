#/bin/bash
cd ~
echo "****************************************************************************"
echo "* This script will install and configure your XUEZ Coin masternodes.       *"
echo "*                    Love from A_Block_Nut(Thermo) ;)                      *"
echo "*    If you have any issues please ask for help on the XUEZ discord.       *"
echo "*                      https://discord.gg/QWcK5Yk                          *"
echo "*                        https://xuezcoin.com/                             *"
echo "****************************************************************************"
echo "" 
echo ""
echo ""
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!                                                 !"
echo "! Make sure you double check before hitting enter !"
echo "!                                                 !"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo ""
echo ""
echo ""
echo "Do you want to install all needed updates and firewall settings? [y/n]"
read DOSETUP
	if [[ $DOSETUP =~ "y" ]] || [[$DOSETUP =~ "Y" ]] ; then
	sudo apt-get update
	sudo apt-get -y upgrade
	sudo apt-get -y dist-upgrade
	
	sudo apt-get install -y ufw
	sudo ufw allow ssh/tcp
	sudo ufw limit ssh/tcp
	sudo ufw logging on
	sudo ufw allow 22
	echo "y" | sudo ufw enable
	sudo ufw status
  
  sudo su -c "echo 'deb http://deb.torproject.org/torproject.org '$(lsb_release -c | cut -f2)' main' > /etc/apt/sources.list.d/torproject.list"
  gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
  gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install tor deb.torproject.org-keyring
  sudo usermod -a -G debian-tor $(whoami)
  sudo sed -i 's/#ControlPort 9051/ControlPort 9051/g' /etc/tor/torrc
  sudo sed -i 's/#CookieAuthentication 1/CookieAuthentication 1/g' /etc/tor/torrc
  sudo su -c "echo 'CookieAuthFileGroupReadable 1' >> /etc/tor/torrc"
  sudo su -c "echo 'LongLivedPorts 9033' >> /etc/tor/torrc"
  sudo systemctl restart tor.service

fi

echo ""
wget https://github.com/XUEZ/xuez/releases/download/1.0.1.10/xuez-linux-cli-10110.tgz
tar -xvzf xuez-linux-cli-10110.tgz
echo ""

echo "Are you installing a new Masternode (Y) Or updating to the most recent wallet (n)? [y/n]
if [[ $IPDEFAULT =~ "y" ]] || [[$IPDEFAULT =~ "Y" ]] ; then

echo "Configure your masternodes now!"
echo "Your recognised IP address is:"
sudo hostname -I 
echo "Is this the IP you wish to use for MasterNode ? [y/n] , followed by [ENTER]"
read IPDEFAULT
	if [[ $IPDEFAULT =~ "y" ]] || [[$IPDEFAULT =~ "Y" ]] ; then
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
	./xuezd -daemon
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
	./xuezd -daemon
	echo "if server start failure try ./xuezd -reindex"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "!                                                 !"
	echo "! Your MasterNode Is setup please close terminal  !"
	echo "!   and continue the local wallet setup guide     !"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo ""
fi

else

./xuez-cli stop
rm xuezd
rm xuez-cli
rm xuez-tx
wget https://github.com/XUEZ/xuez/releases/download/1.0.1.10/xuez-linux-cli-10110.tgz
tar -xf xuez-linux-cli-10110.tgz
rm xuez-linux-cli-10110.tgz
./xuezd -resync 
