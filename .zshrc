# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

if [ -n "$INSIDE_EMACS" ]; then
    ZSH_THEME="robbyrussell"
else
    ZSH_THEME="agnoster"
    # ZSH_THEME="powerline"
    # POWERLINE_HIDE_USER_NAME="true"
    # POWERLINE_HIDE_HOST_NAME="true"
    # POWERLINE_DETECT_SS="true"
    # POWERLINE_PATH="short"
fi
export ZSH_THEME

[[ "$TMUX" == "" ]] && TERM=xterm-256color
export TERM="xterm-256color"

DISABLE_AUTO_UPDATE="true"
plugins=(git autojump colored-man-pages thefuck)

# Add locations to the $PATH that actually exist.
PATH="/usr/local/bin:$PATH"
[ -d "/usr/texbin" ]               && PATH="/usr/texbin:$PATH"
[ -d "/usr/local/share/npm/bin" ]  && PATH="/usr/local/share/npm/bin:$PATH"
[ -d "$HOME/PebbleSDK-2.0.0/bin" ] && PATH="$HOME/PebbleSDK-2.0.0/bin:$PATH"

# Add my scripts directory to my path if it's there.
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# go
# export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOROOT=/usr/local/opt/go/libexec
# export GOPATH=$HOME/goEnv
export GOPATH=/Users/robertzhouxh/goEnv
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:/usr/local/lib/erlang/man:$MANPATH

# use Unix Style cmd
if brew list | grep coreutils > /dev/null ; then
  # PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
  export PATH=/usr/local/opt/coreutils/libexec/gnubin:/opt/local/libexec/gnubin:$PATH
fi
export PATH="/usr/local/sbin:$PATH"

# virtualenvwrapper for python-
if [ `id -u` != '0' ]; then
  export VIRTUALENV_USE_DISTRIBUTE=1        # <-- Always use pip/distribute
  export WORKON_HOME=$HOME/.virtualenvs       # <-- Where all virtualenvs will be stored
  source /usr/local/bin/virtualenvwrapper.sh
  export PIP_VIRTUALENV_BASE=$WORKON_HOME
  export PIP_RESPECT_VIRTUALENV=true
fi

# for nvm
# export NVM_DIR="$HOME/.nvm"
# source $(brew --prefix nvm)/nvm.sh

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='emacs'
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"
alias dc="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/githubs"
alias h="history"

if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

# alias l="ls -lF ${colorflag}"    # List all files colorized in long format
alias la="ls -laF ${colorflag}"    # List all files colorized in long format, including dot files
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"   # List only directories
alias ls='ls -F --show-control-chars --color=auto'
alias sudo='sudo '    # Enable aliases to be sudo’ed
alias week='date +%V'   # Get week number
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'    # Stopwatch
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias dus="du -smh * | sort -nr" #根据文件大小排序
alias lh='ls -d .*' # show hidden files/directories only #只显示隐藏文件
alias ld="ls -lih"
alias map='traceroute' #路由跟踪
alias tgz='tar -czf' #tar -czf [文件名] [被压缩文件] gzip压缩
alias ugz='tar -xzf' #tar -xzf [被压缩文件]
alias pwd='pwd && pwd | pbcopy' #查看当前路径并且复制
alias cleanDS='find . -name ".DS_Store" -print0 | xargs -0 rm -rf' #清除目录下的 DS_Store文件
alias route="netstat -r"
alias listport="netstat -a | egrep 'Proto|LISTEN'"

# OS X things.
if [[ `uname` == "Darwin" ]]; then
	# This is really only for OS X, so don't use it at work.
	function top() {
		if [ $# -eq 0 ]; then
			/usr/bin/top -o cpu
		else
			/usr/bin/top "$@"
		fi
	}
  alias l="ls -lhFG"
  alias la="ls -Alh -G"
else
  # Non-OS X things.
  alias l="ls -lhF --group-directories-first --color=always"
fi

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"
alias pc4="proxychains4"

# for go through G-W-F
alias ssl="sslocal -c /etc/shadowsocks.json -d -q "
alias sss="ssserver -c /etc/shadowsocks.json -d -q "

# 列出系统最大的文件 快捷 maxfile 即可
maxfile() {
   lsof / | awk '{ if($7 > 1048576) print $7/1048576 "MB "$9 }' | sort -n -u | tail
}

extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# Quick Edit
zshrc(){
   vim ~/.zshrc
}
hosts(){
   sudo vim /etc/hosts
}
vimrc(){
   vim ~/.vimrc #编辑vim配置
}

emacs.d(){
   vim ~/.emacs.d #编辑 emacs
}


# Git
 alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit "

# Emacs:
alias e="emacsclient -t"          # Preferred
alias ed="`which emacs` --daemon" # Start the daemon
#alias emacs="`which emacs` -nw"   # Failsafe
export EDITOR="emacsclient -t"
export ALTERNATE_EDITOR=""
export VISUAL="emacsclient -c -a emacs"
export EDITOR="emacsclient -t"
export ALTERNATE_EDITOR=""
export VISUAL="emacsclient -c -a emacs"

## I don't know why this isn't configured by default.
export LD_LIBRARY_PATH=/usr/local/lib


# 快速查看本机IP地址
function myip() {
    myip="$(ifconfig | grep 'inet.*netmask.*broadcast')"
    lanip="$(echo $myip | awk '{print $2}')"
    publicip="$(echo $myip | awk '{print $6}')"
    echo '你的局域网IP是: '$lanip
    echo '你的外网IP是: '$publicip
}


alias grep="grep --color=auto"
alias vi='vim'
alias -s html=vim # 在命令行直接输入后缀为 html 的文件名，会在 TextMate 中打开
alias -s rb=vi
alias -s py=vi
alias -s js=vi
alias -s txt=vi
alias -s org=emacs
alias -s c=emacs
alias -s erl=emacs
alias -s org=emacs
alias -s md=emacs

# Mac Only
alias dns="dscacheutil -flushcache"
alias oo='open .' # open current directory in OS X Finder

# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# autojump
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh

ulimit -n 1048576

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"
alias ssh='ssh -A'
# alias alybroker="ssh -i ~/.ssh/id_rsa -o ServerAliveInterval=10 root@alybroker"
# alias alydb="ssh -i ~/.ssh/id_rsa -o ServerAliveInterval=10 root@alydb"
# alias testbroker="ssh -i ~/.ssh/id_rsa -o ServerAliveInterval=10 root@testbroker"
# alias testdb="ssh -i ~/.ssh/id_rsa -o ServerAliveInterval=10 root@testdb"
alias testdb="ssh -o ServerAliveInterval=10 root@testdb"

# for emacs ggtags
export GTAGSCONF=/usr/local/share/gtags/gtags.conf
export GTAGSLABEL=ctags

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
 . `brew --prefix`/etc/profile.d/z.sh
eval "$(thefuck --alias)"
