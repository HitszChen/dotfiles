# xuehao zhou’s dotfiles

This is a derived work from Mathias's dotfiles. Consider to use his setup directly. See: https://github.com/mathiasbynens/dotfiles.

Disclaimer: I have tuned the dotfiles for my own use. Some of the setup may not be good for you.

## Chaged to Mathias's dotfiles:

* use [liquidprompt](https://github.com/nojhan/liquidprompt) for shell prompt instead of the default.
* use [z](https://github.com/rupa/z) for shell auto jump instead of autojump.
* support my awesome vim automatic configuration, you can decide whether use or not in bootsrap.
* support my awesome emacs automatic configuration, you can decide whether use or not in bootsrap.
* support zsh && bash both.
* support both ubuntu and macosx automatic deployment.

### for ubuntu

* add an awesome flat theme **Flatabulous** deployment
* add some cool utilities, htop2, swagger, how2 , thefuck ...
* for china users, add **shadowsocks** automatically deployment


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

**(the following guide is from Mathias's project. Read on if you want to know more.)**

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/Projects/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/mathiasbynens/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
set -- -f; source bootstrap.sh
```

### Git-free install

To install these dotfiles without Git:

```bash
cd; curl -#L https://github.com/mathiasbynens/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh,LICENSE-MIT.txt}
```

To update later on, just run that command again.

### Specify the `$PATH`

If `~/.path` exists, it will be sourced along with the other files, before any feature testing (such as [detecting which version of `ls` is being used](https://github.com/mathiasbynens/dotfiles/blob/aff769fd75225d8f2e481185a71d5e05b76002dc/.aliases#L21-26)) takes place.

Here’s an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```bash
export PATH="/usr/local/bin:$PATH"
```

### Add custom commands without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.extra` looks something like this:

```bash
# Git credentials
# Not in the repository, to prevent people from accidentally committing under my name
GIT_AUTHOR_NAME="Mathias Bynens"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="mathias@mailinator.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

You could also use `~/.extra` to override settings, functions and aliases from my dotfiles repository. It’s probably better to [fork this repository](https://github.com/mathiasbynens/dotfiles/fork) instead, though.

### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./.osx
```

### Install Homebrew formulae

When setting up a new Mac, you may want to install some common [Homebrew](http://brew.sh/) formulae (after installing Homebrew, of course):

```bash
./brew.sh
```

## Feedback

Suggestions/improvements
[welcome](https://github.com/mathiasbynens/dotfiles/issues)!

## Author

| [![twitter/mathias](http://gravatar.com/avatar/24e08a9ea84deb17ae121074d0f17125?s=70)](http://twitter.com/mathias "Follow @mathias on Twitter") |
|---|
| [Mathias Bynens](https://mathiasbynens.be/) |

## Thanks to…

* @ptb and [his _OS X Lion Setup_ repository](https://github.com/ptb/Mac-OS-X-Lion-Setup)
* [Ben Alman](http://benalman.com/) and his [dotfiles repository](https://github.com/cowboy/dotfiles)
* [Chris Gerke](http://www.randomsquared.com/) and his [tutorial on creating an OS X SOE master image](http://chris-gerke.blogspot.com/2012/04/mac-osx-soe-master-image-day-7.html) + [_Insta_ repository](https://github.com/cgerke/Insta)
* [Cătălin Mariș](https://github.com/alrra) and his [dotfiles repository](https://github.com/alrra/dotfiles)
* [Gianni Chiappetta](http://gf3.ca/) for sharing his [amazing collection of dotfiles](https://github.com/gf3/dotfiles)
* [Jan Moesen](http://jan.moesen.nu/) and his [ancient `.bash_profile`](https://gist.github.com/1156154) + [shiny _tilde_ repository](https://github.com/janmoesen/tilde)
* [Lauri ‘Lri’ Ranta](http://lri.me/) for sharing [loads of hidden preferences](http://osxnotes.net/defaults.html)
* [Matijs Brinkhuis](http://hotfusion.nl/) and his [dotfiles repository](https://github.com/matijs/dotfiles)
* [Nicolas Gallagher](http://nicolasgallagher.com/) and his [dotfiles repository](https://github.com/necolas/dotfiles)
* [Sindre Sorhus](http://sindresorhus.com/)
* [Tom Ryder](http://blog.sanctum.geek.nz/) and his [dotfiles repository](https://github.com/tejr/dotfiles)
* [Kevin Suttle](http://kevinsuttle.com/) and his [dotfiles repository](https://github.com/kevinSuttle/dotfiles) and [OSXDefaults project](https://github.com/kevinSuttle/OSXDefaults), which aims to provide better documentation for [`~/.osx`](https://mths.be/osx)
* [Haralan Dobrev](http://hkdobrev.com/)
* anyone who [contributed a patch](https://github.com/mathiasbynens/dotfiles/contributors) or [made a helpful suggestion](https://github.com/mathiasbynens/dotfiles/issues)
