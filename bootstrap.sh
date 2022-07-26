#!/usr/bin/env bash

sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "\n\033[1m🚀 Setting up prerequisites\n\033[0m"
# -------- PREREQUISITES ---------
xcode-select --install;

# Check for Homebrew,
if ! [ -x "$(command -v brew)" ]; then
	echo "\033[1mInstalling homebrew...\033[0m"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
brew link coreutils
if ! [ -f /usr/local/bin/sha256sum ]; then
	sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum
fi;
brew install findutils

# -------- TOOLS ---------

echo "\n\033[1m🛠 Installing tools\n\033[0m"
UTILS=(
	wget
	git
	git-flow
	git-extras
	ffmpeg
	itermocil
	tldr
	tree
	vim
	webkit2png
	youtube-dl
	brew-php-switcher
	transmission
	php-cs-fixer
	zsh
)
for util in "${UTILS[@]}"
do
	if ! [ -x "$(command -v $util)" ]; then
		echo "\n→ \033[1mInstalling $util\033[0m"
		brew install $util
	fi
done

if ! [ -x "$(command -v convert)" ]; then
	echo "\n→ \033[1mInstalling imagemagick\033[0m"
	brew install imagemagick
fi

if ! [ "$(ls -a $HOME | grep -i .zcompdump)" ]; then
	echo "\n→ \033[1mInstalling zsh-completions\033[0m"
	brew install zsh-completions
fi

# DEV
if ! [ -x "$(command -v node)" ]; then
	echo "\n→ \033[1mInstalling node\033[0m"
	brew install node
fi

npm install -g eslint eslint-plugin-standard eslint-plugin-import eslint-config-standard eslint-config-import eslint-plugin-node eslint-plugin-promise

if ! [ -x "$(command -v sass)" ]; then
	echo "\n→ \033[1mInstalling sass\033[0m"
	brew install sass/sass/sass
fi

if ! [ -x "$(command -v python2)" ]; then
	echo "\n→ \033[1mInstalling python@2\033[0m"
	brew install python@2
fi

if ! [ -x "$(command -v python3)" ]; then
	echo "\n→ \033[1mInstalling current version of python\033[0m"
	brew install python
fi

brew install php@7.1
brew install php

if ! [ -x "$(command -v heroku)" ]; then
	brew install heroku/brew/heroku
fi
heroku update

# -------- APPS ---------
echo "\n\033[1m💼 Installing apps\n\033[0m"
APP_FOLDER="/Applications"

APPS=(
	virtualbox
	dropbox
	telegram
	keeweb
	firefox
	vlc
	webtorrent
	rectangle
	visual-studio-code
	nicotine-plus
	rescuetime
)
for app in "${APPS[@]}"
do
	if ! [ "$(ls $APP_FOLDER | grep -i $app)" ]; then
		echo "\n→ \033[1mInstalling $app...\033[0m"
		brew cask install --appdir=$APP_FOLDER $app
	fi
done

if ! [ -x "$(command -v vagrant)" ]; then
	echo "\n→ \033[1mInstalling vagrant\033[0m"
	brew cask install --appdir=$APP_FOLDER vagrant
fi

if ! [ "$(ls $APP_FOLDER | grep -i 'google chrome')" ]; then
	brew cask install --appdir=$APP_FOLDER google-chrome
fi

if ! [ "$(ls $APP_FOLDER | grep -i iterm)" ]; then
	brew cask install --appdir=$APP_FOLDER iterm2
fi

if ! [ "$(ls $APP_FOLDER | grep -i 'sublime text')" ]; then
	brew cask install --appdir=$APP_FOLDER sublime-text
fi

# Install developer friendly quick look plugins; see https://github.com/sindresorhus/quick-look-plugins
echo "\n\033[1m🧸 Installing quicklook plugins\n\033[0m"
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzip qlimagesize webpquicklook suspicious-package quicklookase qlvideo

# Remove outdated versions from the cellar.
echo "\n\033[1m🧼 Cleaning up\n\033[0m"
brew cleanup

# -------- SHELL ---------
echo "\n\033[1m🐚 Customizing shell\n\033[0m"

if ! [ -d $HOME/.oh-my-zsh ]; then
	# oh-my-zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi;

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
# Spaceship theme
if ! [ -d $ZSH_CUSTOM/themes/spaceship-prompt ]; then
	git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH_CUSTOM/themes/spaceship-prompt
fi;

if ! [ -f $ZSH_CUSTOM/themes/spaceship.zsh-theme ]; then
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" $ZSH_CUSTOM/themes/spaceship.zsh-theme
fi;

#dotfiles
DOTFILES=(
	.zshrc
	.vimrc
	.eslintrc
)
for dotfile in "${DOTFILES[@]}"
do
	if [ -f $HOME/$dotfile ]; then
		cp $HOME/$dotfile $HOME/$dotfile_BACKUP
	fi
	cp -f dotfiles/$dotfile $HOME/$dotfile
done

# -------- EXTRA cli TOOLS ---------
# sublime from the shell
if ! [ -x "$(command -v sublime)" ]; then
	ln -s "$APP_FOLDER/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sublime
fi

SCRIPT_DIR="$HOME/scripts"
[ -d $SCRIPT_DIR ] || mkdir $SCRIPT_DIR

# install asimov (excluder of vendor, composer, nodemodules from time machine)
if ! [ -x "$(command -v asimov)" ]; then
	git clone https://github.com/stevegrunwell/asimov.git $SCRIPT_DIR/asimov && sh $SCRIPT_DIR/asimov/install.sh && ln -s $SCRIPT_DIR/asimov/asimov /usr/local/bin
fi;

# Install z and its man
if ! [ -d $SCRIPT_DIR/z ]; then
	git clone https://github.com/rupa/z.git $SCRIPT_DIR/z && cp $SCRIPT_DIR/z/z.sh $HOME && sudo cp $SCRIPT_DIR/z/z.1 /usr/local/share/man/man1/
fi;

# Install transfer.sh
if ! [ -f $SCRIPT_DIR/transfer.sh ]; then
	curl -o $SCRIPT_DIR/transfer.sh "https://gist.githubusercontent.com/nl5887/a511f172d3fb3cd0e42d/raw/d2f8a07aca44aa612b6844d8d5e53a05f5da3420/transfer.sh"
fi;

echo "\n\033[1m👌 All done!\033[0m"
