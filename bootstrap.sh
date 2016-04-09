#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh"  --exclude "vim.sh" --exclude "emacs.sh" \
	      --exclude "README.md" --exclude "LICENSE-MIT.txt" --exclude ".vimrc" --exclude ".vim" --exclude ".emacs.d" -avh --no-perms . ~;
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;


echo ""

echo -e "\033[40;32m start to install command line tools for your system ...\033[0m"

sysType=`uname -s`

echo -e "\033[40;32m Your system is $sysType \033[0m"

if [ $sysType = "Linux" ]; then
  source ./apt.sh;
elif [ $sysType = "Darwin" ]; then
  source ./brew.sh;
else
  echo -e "\033[40;32m unsupported system, exit \033[0m"
fi

echo -e "\033[40;32m you can enter 1 to deploy my awesome vim configuration or 2 to skip it \033[0m"
select yn in "Yes" "No"; do
  case $yn in
    Yes )
      echo ""
      echo ""
      echo -e "\033[40;32m Cool, i will give you a awesome vim journey ... \033[0m"
      source ./vim.sh
      break;;
    No ) break;;
  esac
done

echo ""
echo ""
echo -e "\033[40;32m All done, HAPPY HACKING :-) \033[0m"
echo ""
echo ""
