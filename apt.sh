#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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
    proxychains
    privoxy
    lua-socket

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
    nmon             # a cool system monitor instead of free and htop

    ## Terminal
    tmux
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

#pip install pygments
#install the global
#VERSION=6.5
#wget http://tamacom.com/global/global-${VERSION}.tar.gz
#tar xvf global-${VERSION}.tar.gz
#cd global-${VERSION}
#./configure
#make
#make install

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
  cd $CURRENT_DIR/htop && ./autogen.sh && ./configure && make && sudo ln -s $CURRENT_DIR/htop/htop /usr/bin/htop
  cd -
fi;

echo ""
echo ""
read -p "For China users,>>> shadowsocks: [ SOCKS5_PROXY ] without [ HTTP_PROXY ] <<< go through G-F-W? (y/n) " -n 1;
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
read -p "Use proxychains proxy the socks5 request to the SS (y/n) " -n 1;
if [[ $REPLY =~ ^[Yy]$ ]]; then
  PC_CFG_DIR=$HOME/.proxychains
  if [ ! -f "$PC_CFG_DIR/proxychains.conf" ]; then
    echo ""
    echo "no found shadowsocks config file: $PC_CFG_DIR/proxychains.conf";
    sudo mkdir "$PC_CFG_DIR"
    sudo touch "$PC_CFG_DIR/proxychains.conf"
  fi
  sudo chmod a+w "$PC_CFG_DIR/proxychains.conf"

cat > "$PC_CFG_DIR/proxychains.conf" <<EOF
# proxychains.conf  VER 4.x
#
#        HTTP, SOCKS4a, SOCKS5 tunneling proxifier with DNS.
strict_chain
proxy_dns
remote_dns_subnet 224
tcp_read_time_out 15000
tcp_connect_time_out 8000
[ProxyList]
# socks4 	127.0.0.1 9050
socks5 127.0.0.1 1080
EOF

  echo -e "\033[40;32m attension!!! vi /usr/lib/proxychains3/proxyresolv, DNS_SERVER=8.8.8.8 \033[0m"
  echo -e "\033[40;32m attension!!! sudo ln -s /usr/lib/proxychains3/proxyresolv /usr/bin/ \033[0m"
  sudo ln -s /usr/lib/proxychains3/proxyresolv /usr/bin/
fi;


echo ""
read -p "Use privoxy to transform Socks5 Proxy into HTTP Proxy (y/n) " -n 1;
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [ -f "/etc/privoxy/config" ]; then
    sudo chmod o+w "/etc/privoxy/config"

cat >> "/etc/privoxy/config" <<EOF
# 监听端口为8118，如果需要其他设备访问，则需要将ip改为路由器的IP 192.168.1.1 或 0.0.0.0 或者直接 :8118
# listen-address  127.0.0.1:8118

# ss运行于1080端口，我们加入下面的配置，不要忘了最后的点.
forward-socks5 / 127.0.0.1:1080 .

# local network do not use proxy
forward 192.168.*.*/ .
forward 10.*.*.*/ .
forward 127.*.*.*/ .
EOF

    sudo chmod o-w "/etc/privoxy/config"

echo ""
cat <<EOF
Now: $ /etc/init.d/privoxy restart
add followings into your .bashrc or .zshrc

#export http_proxy='http://127.0.0.1:8118'
#export https_proxy='http://127.0.0.1:8118'
EOF

  fi;
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
  wget -O flatTheme.zip https://github.com/anmoljagetia/Flatabulous/archive/master.zip
  sudo unzip flatTheme.zip -d /usr/share/themes/
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

fi;

echo ""
echo -e "\033[40;32m change the default shell into: /bin/bash\033[0m"
sudo chsh -s /bin/bash

echo -e "\033[40;32mclean the temp files: flatTheme.zip\033[0m"
rm flatTheme.zip


echo ""
read -p "install an awesome tmux configuration file, are you sure? (y/n) " -n 1;
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo ""
  git clone https://github.com/gpakosz/.tmux.git
  if [ -f "$HOME/.tmux.conf" ]; then
    sudo rm $HOME/.tmux.conf
  fi;
  sudo ln -s $CURRENT_DIR/.tmux/.tmux.conf $HOME/.tmux.conf
  sudo ln -s $CURRENT_DIR/.tmux/.tmux.conf.local $HOME/.tmux.conf.local
fi;
echo ""

cecho "Done, Happy Hacking At the Speed Of The Thought" $green
