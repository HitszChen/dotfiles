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



cecho "attension: please make sure you have installed the command line tools use: xcode-select --install" $yellow
echo ""


if hash apt-get 2>/dev/null; then
	cecho "apt has been installed, just continue install ..." $green
else
	cecho "no apt found! exit ..." $yellow
  exit
fi


# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo ""
cecho "Now time to install my favorate tools ..." $yellow

sudo apt-add-repository ppa:ubuntu-elisp/ppa
sudo apt-get update

cecho "purge the old tools: firefox ..." $yellow
sudo apt-get purge firefox

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

	  ## Dev tools
    cmatrix
    wget
    curl
    git
		##firefox
		autojump
    ##emacs-snapshot    # install the latest version from ppa
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
git clone https://github.com/rupa/z ~/.z
. ~/.z/z.sh

echo -e "\033[40;32m install liquidprompt \033[0m"
git clone https://github.com/nojhan/liquidprompt.git ~/.liquidprompt
source ~/.liquidprompt/liquidprompt

echo -e "\033[40;32m install thefuck: you can also use this to install thefuck on macosx \033[0m"
wget -O - https://raw.githubusercontent.com/nvbn/thefuck/master/install.sh | sh - && $0

read -p "install the awesome swagger, are you sure? (y/n) " -n 1;
echo "npm install -g swagger";
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo npm install -g swagger
fi;

read -p "install the awesome tool terminal stackoverflow how2, are you sure? (y/n) " -n 1;
echo "npm install -g how2";
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo npm install -g how2
fi;

read -p "install the awesome tool htop2.0, are you sure? (y/n) " -n 1;
echo "install htop2.0";
CUR_DIR = $(pwd)
if [[ $REPLY =~ ^[Yy]$ ]]; then
  git clone https://github.com/hishamhm/htop
  cd $CUR_DIR/htop && ./autogen.sh && ./configure && make && sudo ln -s $CUR_DIR/htop/htop /usr/bin/htop
  cd -
fi;

echo ""
echo ""
echo ""
echo ""
echo -e "\033[40;32m You can refer: https://blog.anmoljagetia.me/flatabulous-ubuntu-theme/  website to deploy you theme 033[0m"
echo ""
echo ""
echo ""
echo ""

echo -e "\033[40;32m change the default shell into: /bin/bash\033[0m"
sudo chsh -s /bin/bash

cecho "Done, Happy Hacking At the Speed Of The Thought" $green
