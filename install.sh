#! /bin/bash
# Script developped by 𝐶𝛳𝐷𝐼𝛱𝐺'𝛱𝛴𝑃𝛥𝐿𝛴 from Pinous-Heberg.com
# Tested on Ubuntu 22.04 + Debian 11
if [ $(id -u) -ne 0 ]
then
    echo "Script must be run as root"
    exit 1
fi
echo -e "Running apt update..."
sudo apt update -y > /dev/null 2> /dev/null
echo -e "\e[1A\e[KRunning apt update... \u2705"
echo -e "Installing UFW Firewall..."
sudo apt-get -y install ufw > /dev/null 2> /dev/null
echo -e "\e[1A\e[K\e[1A\e[KInstalling UFW Firewall... \u2705"
echo -e "Firewall setup ..."
ufw allow 3001 && ufw allow ssh && ufw enable
echo -e "\e[1A\e[K\e[1A\e[KFirewall setup... \u2705"
echo -e "Creation of an apt source list file for the current NodeSource Node.js 14.x..."
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
echo -e "\e[1A\e[KCreation of an apt source list file for the current NodeSource Node.js 14.x repo... \u2705"

echo -e "Installing NodeJS..."
sudo apt -y install nodejs
echo -e "\e[1A\e[K\e[1A\e[KInstalling NodeJS... \u2705"

echo -e "Installation of the latest dependencies for NodeJS and installation of yarn..."
sudo apt -y install gcc g++ make
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt -y update && sudo apt -y install yarn
YARNVERSION=$(yarn -V)
echo -e "The latest dependencies for NodeJS and yarn has successfully installed. Version of Yarn: $YARNVERSION"


NODEVERSION=$(node -v)
echo -e "NodeJS and these dependencies have been successfully installed. Version of NodeJS: $NODEVERSION"

echo -e "Installing Git..."
apt-get -y install git
echo -e "Git has successfully installed."

echo -e "Installing PM2..."
npm install pm2 -g && pm2 install pm2-logrotate
echo -e "\e[1A\e[K\e[1A\e[KInstalling PM2... \u2705"

echo -e "Updating of NPM..."
npm install npm -g
echo -e "\e[1A\e[K\e[1A\e[KUpdating of NPM... \u2705"

echo -e "Cloning of git repository github.com/louislam/uptime-kuma"
DIR="/var/www"
if [ ! -d "$DIR" ]; then
  mkdir -p $DIR
fi
cd $DIR
git clone https://github.com/louislam/uptime-kuma.git
cd uptime-kuma
npm run setup
echo -e "\e[1A\e[K\e[1A\e[KGit repository github.com/louislam/uptime-kuma successfully cloned... \u2705"

read -p "Do you want to run uptime-kuma now? [Y/n]" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]];
then
    echo "Starting uptime-kuma..."
    pm2 start server/server.js --name uptime-kuma
    echo -e "Uptime-kuma has successfully started."
    IP=$(hostname -I | cut -d ' ' -f 1)
    echo -e "------------------------------------------------------------------------------" >> /etc/motd
    echo -e "Welcome to the uptime-kuma environment via the install bash script by 𝐶𝛳𝐷𝐼𝛱𝐺'𝛱𝛴𝑃𝛥𝐿𝛴. Please use your web browser to 
    configure uptime-kuma - log in at :
    http://$IP:3001/" >> /etc/motd
    echo -e "------------------------------------------------------------------------------" >> /etc/motd
    echo -e "Uptime-kuma has been successfully installed and started up and will be automatically restarted at the next reboot"
else
    echo -e "Uptime-kuma has been successfully installed and will be automatically started on the next reboot"
    IP=$(hostname -I | cut -d ' ' -f 1)
    echo -e "------------------------------------------------------------------------------" >> /etc/motd
    echo -e "Welcome to the uptime-kuma environment via the install bash script by 𝐶𝛳𝐷𝐼𝛱𝐺'𝛱𝛴𝑃𝛥𝐿𝛴. Please use your web browser to 
    configure uptime-kuma - log in at :
    http://$IP:3001/" >> /etc/motd
    echo -e "------------------------------------------------------------------------------" >> /etc/motd
fi
