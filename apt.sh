#!/usr/bin/env bash


# Set the colours you can use
black='\033[0;30m'
white='\033[0;37m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'

#  Reset text attributes to normal + without clearing screen.
alias Reset="tput sgr0"

# Color-echo.
# arg $1 = message
# arg $2 = Color
cecho() {
  echo -e "${2}${1}"
  # Reset # Reset to normal.
  return
}


if hash apt-get 2>/dev/null; then
  cecho "apt has been installed, just continue install ..." $green
else
  cecho "no apt found! exit ..." $yellow
  exit
fi


# Ask for the administrator password upfront.
sudo -v


cecho "config the DNS" $yellow
echo ""

sudo chmod a+w  /etc/resolv.conf
cat > /etc/resolv.conf <<EOF
nameserver 180.76.76.76
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo ""
cecho "Now time to install my favorate tools ..." $yellow

sudo apt-add-repository ppa:ubuntu-elisp/ppa
sudo apt-get update

cecho "purge the old tools: firefox ..." $yellow
#sudo apt-get purge firefox

apps=(
    # Utilities
    ## for openresty
    libreadline-dev
    libncurses5-dev
    libpcre3-dev
    libssl-dev
    perl
    make
    build-essential
    cmake

    ## for python
    python-pip
    python-dev

    ## Dev tools
    unzip
    cmatrix
    wget
    curl
    git
    firefox
    autojump
    emacs-snapshot    # install the latest version from ppa
    openssh-server
    nodejs
    npm
)

for item in ${apps[@]}; do
  cecho "> ${item}" $magenta
done

echo ""

select yn in "Yes" "No"; do
  case $yn in
    Yes )
        cecho "Ok! installing apps, please wait ... " $yellow
        sudo apt-get install -y ${apps[@]}
        break;;
    No ) break;;
  esac
done


echo -e "\033[40;32m install the fzf \033[0m"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo -e "\033[40;32m install the z, refer: https://github.com/rupa/z/blob/master/z.sh \033[0m"
git clone https://github.com/rupa/z ~/z
. ~/z/z.sh

echo -e "\033[40;32m install liquidprompt \033[0m"
git clone https://github.com/nojhan/liquidprompt.git ~/.liquidprompt
source ~/.liquidprompt/liquidprompt

#echo -e "\033[40;32m install thefuck: you can also use this to install thefuck on macosx \033[0m"
#wget -O - https://raw.githubusercontent.com/nvbn/thefuck/master/install.sh | sh - && $0
echo -e "\033[40;32m install thefuck: sudo -H pip install thefuck \033[0m"
sudo -H pip install thefuck


echo ""
read -p "install the awesome swagger, are you sure? (y/n) " -n 1;
echo "npm install -g swagger";
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo npm install -g swagger
fi;

echo ""
read -p "install the awesome tool terminal stackoverflow how2, are you sure? (y/n) " -n 1;
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "npm install -g how2";
  sudo npm install -g how2
fi;

echo ""
read -p "install the awesome tool htop2.0, are you sure? (y/n) " -n 1;
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "install htop2.0";
  git clone https://github.com/hishamhm/htop
  CUR_DIR=$(pwd)
  cd $CUR_DIR/htop && ./autogen.sh && ./configure && make && sudo ln -s $CUR_DIR/htop/htop /usr/bin/htop
  cd -
fi;

echo ""
echo ""

read -p "For China users, do you want to go through G-F-W? (y/n) " -n 1;
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "sudo pip install shadowsocks";
  sudo -H pip install shadowsocks

  echo -e "\033[40;32m deploy the proxy server on your remote vps: server[1,2,3] \033[0m"

  SS_CFG="/etc/shadowsocks.json"
  if [ ! -f "$SS_CFG" ]; then
    echo "no found shadowsocks config file: /etc/shadowsocks.json";
    sudo touch "$SS_CFG"
  fi
  sudo chmod a+w "$SS_CFG"

cat > "$SS_CFG" <<EOF
{
  "server":["server1","server2"],
  "server_port":8080,
  "local_address":"127.0.0.1",
  "local_port":1080,
  "password":"password",
  "timeout":300,
  "method":"aes-256-cfb",
  "fast_open": false
}
EOF

  echo -e "\033[40;32m you can start the shadowsocks server on remote vps: sudo ssserver -c /etc/shadowsocks.json -d start \033[0m"
  #sudo ssserver -c $SS_CFG -d stop
  #sudo ssserver -c $SS_CFG -d start
  echo -e "\033[40;32m you can start the shadowsocks client on your local laptop: sslocal -c /etc/shadowsocks.json \033[0m"
fi;

echo ""
read -p "install a awesome flat theme icons for your ubuntu, are you sure? (y/n) " -n 1;
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "install the flat themes and icons for ubuntu ...";
  echo -e "\033[40;32m You can refer: https://blog.anmoljagetia.me/flatabulous-ubuntu-theme/  website to deploy you theme 033[0m"
  echo ""
  echo "install the Ubuntu tweak tool"
  sudo add-apt-repository ppa:tualatrix/ppa
  sudo apt-get update
  sudo apt-get install ubuntu-tweak
  echo ""
  echo "install themes"
  wget -P /tmp/ https://github.com/anmoljagetia/Flatabulous/archive/master.zip
  unzip master.zip -d /usr/share/themes/
  echo ""

  echo "install the icons"
  sudo add-apt-repository ppa:noobslab/icons
  sudo apt-get update
  sudo apt-get install ultra-flat-icons
  #sudo apt-get install ultra-flat-icons-orange
  #sudo apt-get install ultra-flat-icons-gree
  echo ""

cat <<EOF
Now press your super key,
search for Ubuntu Tweak and fire it.
Under the tweaks tab, there is an option for theme.
Under that select the Flatabulous theme.
Under the icon settings, select ultra-flat-icons.
Restart your computer, and you should be good to go!
EOF

  echo ""
fi;

echo -e "\033[40;32m change the default shell into: /bin/bash\033[0m"
sudo chsh -s /bin/bash

cecho "Done, Happy Hacking At the Speed Of The Thought" $green
