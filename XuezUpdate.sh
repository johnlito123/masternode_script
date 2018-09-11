#!/bin/bash

clear
cd ~
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
echo "*                 					                 *"
echo "*    If you have any issues please ask for help on the XUEZ discord.       *"
echo "*                      https://discord.gg/QWcK5Yk                          *"
echo "*                        https://xuezcoin.com/                             *"
echo "****************************************************************************"

echo && echo && echo
sleep 5

# Check if is root
if [ "$(whoami)" != "root" ]; then
  echo "Script must be run as user: root"
  exit -1
fi

# Check for systemd
systemctl --version >/dev/null 2>&1 || { echo "systemd is required. Are you using Ubuntu 16.04 (Xenial)?"  >&2; exit 1; }

# Gather input from user
KEY=$1
if [ "$KEY" == "" ]; then
    echo "Enter your Masternode Private Key"
    read -e -p "(e.g. 88WRmoBx85zd9vibCw6ALETe7pEfNk6xZAYZxvzNpQCjUtY8se3) : " KEY
    if [[ "$KEY" == "" ]]; then
        echo "WARNING: No private key entered, exiting!!!"
        echo && exit
    fi
fi
IP=$(curl http://icanhazip.com --ipv4)
PORT="41798"
if [[ "$IP" == "" ]]; then
    read -e -p "VPS Server IP Address: " IP
fi
echo "Your IP and Port is $IP:$PORT"
if [ -n "$3" ]; then
    echo "Saving IP"
    echo "Your DocumentId is $DOCUMENTID"
fi
if [ -z "$2" ]; then
echo && echo "Pressing ENTER will use the default value for the next prompts."
    echo && sleep 3
    read -e -p "Add swap space? (Recommended) [Y/n] : " add_swap
fi
if [[ ("$add_swap" == "y" || "$add_swap" == "Y" || "$add_swap" == "") ]]; then
    if [ -z "$2" ]; then
        read -e -p "Swap Size [2G] : " swap_size
    fi
    if [[ "$swap_size" == "" ]]; then
        swap_size="2G"
    fi
fi
if [ -z "$2" ]; then
    read -e -p "Install Fail2ban? (Recommended) [Y/n] : " install_fail2ban
    read -e -p "Install UFW and configure ports? (Recommended) [Y/n] : " UFW
fi

# Add swap if needed
if [[ ("$add_swap" == "y" || "$add_swap" == "Y" || "$add_swap" == "") ]]; then
    if [ -n "$3" ]; then
    fi

    if [ ! -f /swapfile ]; then
        echo && echo "Adding swap space..."
        sleep 3
        sudo fallocate -l $swap_size /swapfile
        sudo chmod 600 /swapfile
        sudo mkswap /swapfile
        sudo swapon /swapfile
        echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
        sudo sysctl vm.swappiness=10
        sudo sysctl vm.vfs_cache_pressure=50
        echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
        echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.conf
    else
        echo && echo "WARNING: Swap file detected, skipping add swap!"
        sleep 3
    fi
fi


# Update system and  
echo && echo "Upgrading system..."
if [ -n "$3" ]; then
    fi
sleep 3
sudo apt-get -y update
sudo apt-get -y upgrade

# Update system and Install Tor
echo && echo "Installing Tor system..."
if [ -n "$3" ]; then
    
fi
        echo && echo "Adding swap space..."
        sleep 3
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


# Install required packages
echo && echo "Installing base packages..."
if [ -n "$3" ]; then
    fi
sleep 3
sudo apt-get -y install \
unzip \
python-virtualenv 

# Install fail2ban if needed
if [[ ("$install_fail2ban" == "y" || "$install_fail2ban" == "Y" || "$install_fail2ban" == "") ]]; then
    if [ -n "$3" ]; then
       fi

    echo && echo "Installing fail2ban..."
    sleep 3
    sudo apt-get -y install fail2ban
    sudo service fail2ban restart 
fi

# Create config for Xuez
if [ -n "$3" ]; then
    fi
echo && echo "Putting The Gears Motion..."
sleep 3
sudo mkdir /root/.xuez #jm

rpcuser=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`
rpcpassword=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`
sudo touch /root/.xuez/xuez.conf
echo '
rpcuser='$rpcuser'
rpcpassword='$rpcpassword'
rpcallowip=127.0.0.1
listen=1
server=1
rpcport=41798
daemon=0 # required for systemd
logtimestamps=1
maxconnections=256
externalip='$IP:$PORT'
masternodeprivkey='$KEY'
masternode=1
' | sudo -E tee /root/.xuez/xuez.conf


#Download pre-compiled xuez and run
if [ -n "$3" ]; then
    fi
mkdir xuez 
mkdir xuez/src
cd xuez/src

wget https://bitbucket.org/davembg/xuez-distribution-repo/downloads/xuez-linux-cli-10110.tgz
tar xzvf xuez-linux-cli-10110.tgz

#run daemon
xuezd -reindex 

TOTALBLOCKS=$(curl http://xuez.donkeypool.com/api/getblockcount)

sleep 10

# Create a cronjob for making sure xuez runs after reboot
if ! crontab -l | grep "@reboot xuezd -daemon"; then
  (crontab -l ; echo "@reboot xuezd -daemon") | crontab -
fi

# cd to xuez-cli for final, no real need to run cli with commands as service when you can just cd there
echo && echo "Xuez Masternode Setup Complete!"
echo && echo "Now we will wait until the node get full sync."

COUNTER=0
if [ -n "$3" ]; then
    fi
while [ $COUNTER -lt $TOTALBLOCKS ]; do
    echo The current progress is $COUNTER/$TOTALBLOCKS
    let COUNTER=$(xuez-cli getblockcount)
    sleep 5
done
echo "Sync complete"
if [ -n "$3" ]; then
    fi

echo && echo "If you put correct PrivKey and VPS IP the daemon should be running."
echo "Now you can start ALIAS on local wallet and finally check here with xuez-cli masternode status."
echo && echo
