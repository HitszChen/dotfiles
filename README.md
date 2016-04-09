##  xuehao zhou’s dotfiles

* This is a derived work from Mathias's dotfiles. Consider to use his setup directly. See: https://github.com/mathiasbynens/dotfiles.
* Disclaimer: I have tuned the dotfiles for my own use. Some of the setup may not be good for you.

## Chaged to Mathias's dotfiles:

### for MacOSX && ubuntu
* use [liquidprompt](https://github.com/nojhan/liquidprompt) for shell prompt instead of the default.
* use [z](https://github.com/rupa/z) for shell auto jump instead of autojump.
* add my awesome vim automatic configuration, you can decide whether use or not in bootsrap.
* add my awesome emacs automatic configuration, you can decide whether use or not in bootsrap.
* support both zsh and bash.
* support both ubuntu and macosx automatic deployment.

### for ubuntu
* For China Users, add **shadowsocks proxychains privoxy** tools to be free online.
* Add an awesome flat theme **Flatabulous** deployment
* add some awesome utilities **htop2 swagger how2 thefuck ...**


## Attension: get you into colorful world

- iterm2 - Preferences - Profiles - Text - Text Rendering， remove the **Draw bold text in bright colors**, and then you will get the color world!
- iterm2 - Preferences - Profiles - Terminal - Terminal Emulation - Report Terminal Type: change **xterm** into **xterm-256color**
- man color - add the followiing export into your .bashrc or .zshrc, here you can add into .exports file

    ```
    export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
    export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
    export LESS_TERMCAP_me=$'\E[0m'           # end mode
    export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
    export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
    export LESS_TERMCAP_ue=$'\E[0m'           # end underline
    export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
    ```

    you can also use the zsh && oh-my-zsh plugin: colored-man-pages instead.


## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Quick intallation

```bash
git clone https://github.com/robertzhouxh/dotfiles /path/to/dotfiles
cd dotfiles
set -- -f; source bootsrap.sh
```

enjoy it!
