alias vim="nvim"

export PATH="$HOME/.local/go/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"

# Output env variables needed for brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Composer executables
export PATH="$PATH:~/.composer/vendor/bin/"

#   ---------------------------------------
#   WEB DEVELOPMENT
#   ---------------------------------------

# Composer
alias getcomposer='curl -sS https://getcomposer.org/installer | php' #Get the latest composer version

# Drupal console
source "$HOME/.console/console.rc" 2>/dev/null

# Other
alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page

#   ---------------------------------------
#   MISC ALIASES
#   ---------------------------------------
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias ll='ls -lhA'
alias fuckit='sudo "$BASH" -c "$(history -p !!)"'

# Mac specific
alias showHiddenFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideHiddenFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

#  Extract most know archives with one command
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

