echo -e "Running apt update..."
apt update -y > /dev/null 2> /dev/null
echo -e "\e[1A\e[KRunning apt update... \u2705"

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
yarn -V
YARNVERSION=$(yarn -V)
echo -e "The latest dependencies for NodeJS and yarn has successfully installed. Version of Yarn: $YARNVERSION"


NODEVERSION=$(node -v)
echo -e "NodeJS and these dependencies have been successfully installed. Version of NodeJS: $NODEVERSION"

echo -e "Installing Git..."
apt-get -y install git
echo -e "Git has successfully installed. Version of NodeJS: $NODEVERSION"

echo -e "Installing PM2..."
npm install pm2 -g && pm2 install pm2-logrotate
echo -e "\e[1A\e[K\e[1A\e[KInstalling PM2... \u2705"

echo -e "Updating of NPM..."
npm install npm -g
echo -e "\e[1A\e[K\e[1A\e[KUpdating of NPM... \u2705"

echo -e ""
