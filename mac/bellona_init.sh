#!/usr/bin/env bash

## Rebuild local machine.
##
## Usage: bellona.sh $username

# Abort if anything fails
set -e

username=$1

# Console colors
red='\033[0;31m'
green='\033[0;32m'
green_bg='\033[42m'
yellow='\033[1;33m'
NC='\033[0m'

if [ -z "$username" ]; then
    echo "Must provide username as 1st argument."
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

# Name machine after Roman god of fire and craftsmanship.
sudo scutil --set HostName vulcan

# Get the things to make us go.
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
curl -L http://install.ohmyz.sh | sh
brew install git
brew install mysql
brew install node
brew install ssh-copy-id
brew install tmux
brew install pv #pipeviewer
brew install wget
gem install jekyll bundler
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew tap homebrew/binary
brew install packer
brew install php56
brew tap phinze/cask
brew install brew-cask
brew cask install alfred
brew cask install caffeine
brew cask install dropbox
brew cask install evernote
brew cask install google-chrome
brew cask install iterm2
brew cask install jing
brew cask install openoffice
brew cask install phpstorm
brew cask install sketch
brew cask install slack
brew cask install sublime-text
brew cask install vagrant
brew cask install virtualbox

# mysql should start on launch
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents

# Setup Apache
./apache.sh "$username"

# Pull in my bash profile.
if [[ ! -f ~/.composer/composer.json ]]
then
  cd ~/
  wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
  mv git-prompt.sh .git-prompt.sh
  cd ~/ && { curl -fsSLO https://raw.githubusercontent.com/aczietlow/nix-dev-configuration/master/mac/conf/.bash_profile ; cd -; }
  source ~/.bash_profile
fi


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

git config --global user.name "Chris Zietlow"
git config --global user.email aczietlow@gmail.com

# Adding composer, and all of the composer things.
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

if [[ ! -f ~/.composer/composer.json ]]
then
  echo -en "${green_bg} Fetching dependencies via composer. ${NC}"
  cd ~/.composer/
  curl -fsSLO https://raw.githubusercontent.com/aczietlow/nix-dev-configuration/master/mac/conf/composer.json
  composer global install
  cgr pantheon-systems/terminus
fi

if [[ ! -f ~/Sites/coder ]]
then
  echo -en "${green_bg} Setting coding standards ${NC}"
  drush dl coder-8.x-2.x-dev --package-handler=git_drupalorg
  cd ~/Sites/coder/
  wget https://www.drupal.org/files/issues/coder-phpcs3-support-2863898-6.patch
  git apply coder-phpcs3-support-2863898-6.patch
fi

# Install docker and docksal
curl -fsSL get.docksal.io | sh
fin vm start

# Add code_sniffer configuration.
cd ~/Sites
# Like this, only for drupal instead of cake.
# ~/.composer/vendor/bin/phpcs --config-set installed_paths ~/.composer/vendor/cakephp/cakephp-codesniffer
