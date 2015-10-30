#!/usr/bin/env bash

username=$1

if [ -z "$username" ]; then
    echo "Must provide username as 1st arguement."
    exit 1
fi

# init
function pause(){
   read -p "$*"
 }

# Hack to remind me to get Xcode.
echo "Get Xcode from: https://developer.apple.com/downloads/index.action#."
pause 'Press [Enter] once installed.'

# Accept terms and install command line tools.
sudo xcodebuild -license
xcode-select --install

# Name machine after god of fire and craftsmanship.
sudo scutil --set HostName vulcan

# Get the things to make us go.
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
curl -L http://install.ohmyz.sh | sh
brew install git
brew install mysql
brew install tmux
brew install wget
brew install node
brew install heroku-toolbelt
brew install qt --HEAD
brew install wkhtmltopdf
brew install ssh-copy-id
gem install jekyll bundler
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew tap homebrew/binary
brew install packer
brew install php56
brew tap phinze/cask
brew install brew-cask
brew cask install google-chrome
brew cask install alfred
brew cask install iterm2
brew cask install hipchat
brew cask install vagrant
brew cask install virtualbox
brew cask install sequel-pro
brew cask install mou
brew cask install openoffice
brew cask install dropbox
brew cask install flux
brew cask install evernote
brew cask install jing
brew cask install caffeine
brew cask install sublime-text
brew cask install sketch
brew cask install phpstorm



# mysql should start on launch
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents

# Setup Apache
./apache.sh "$username"

# Use my bash profile.
cd ~/ && { curl -fsSLO https://raw.githubusercontent.com/aczietlow/nix-dev-configuration/master/mac/conf/.bash_profile ; cd -; }

# Link mysql socket file to someplace accessible by PHP.
cd /var/
sudo mkdir mysql
sudo chmod -R 775 mysql/
cd mysql/
sudo ln -s /tmp/mysql.sock mysql.sock
mysql.server restart

# Reminder of what's left to be done.
echo "Now that that's done I need you to:
1. Add your ssh keys."
pause 'Press [Enter] when you have added your ssh key.'
