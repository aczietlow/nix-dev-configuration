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

# Setup ssh and git  
echo "Now that that's done I need you to:
1. Generate and add ssh keys to github
ssh-keygen -t ed25519 -C \"aczietlow@gmail.com\""
pause 'Press [Enter] when you have added your ssh key.'

git config --global user.name "Chris Zietlow"
git config --global user.email aczietlow@gmail.com
git config --global pull.rebase true

# Name machine after Roman god of fire and craftsmanship.
# sudo scutil --set HostName vulcan

# Get the things to make us go.
## A proper package manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> /Users/czietlow/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/czietlow/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

## A proper terminal
brew install --cask iterm2
brew install zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## A real IDE
brew install go
brew install ripgrep tmux neovim
git clone git@github.com:aczietlow/nvimrc.git ~/.config/nvim

## Regularly used apps
brew install mysql
brew install node
brew install ssh-copy-id
brew install pv #pipeviewer
brew install wget
brew install --cask alfred
brew install --cask caffeine
brew install --cask evernote
brew install --cask google-chrome
brew install --cask phpstorm
brew install --cask sketch
brew install --cask slack
brew install --cask virtualbox
brew install --cask obsidian
brew install --cask miro

# mysql should start on launch
# ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents

# Setup Apache
#./apache.sh "$username # Is part of xcode"

# Add Local Docs
git clone git@github.com:aczietlow/research-notes.git ~/Documents/research-notes
git clone git@github.com:aczietlow/rh-notes-obsidian.git ~/Documents/rh-notes

# Pull in my bash profile.
if [[ ! -f ~/.composer/composer.json ]]
then
  cd ~/
  wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
  mv git-prompt.sh .git-prompt.sh
  cd ~/ && { curl -fsSLO https://raw.githubusercontent.com/aczietlow/nix-dev-configuration/master/mac/conf/.bash_profile ; cd -; }
  source ~/.bash_profile
fi

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
