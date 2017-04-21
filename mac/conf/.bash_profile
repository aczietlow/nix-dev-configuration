#   ---------------------------
#   NETWORKING
#   ---------------------------

alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

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
#   GIT
#   ---------------------------------------

#GIT PS1 promt

#https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
source ~/.git-prompt.sh

##PS1='[\h:\W \u\$(__git_ps1 " (%s)")]\$ '
GIT_PS1_SHOWUPSTREAM='verbose'
export PS1="[\u@\h:\W]\`__git_ps1\` \$ "

#   ---------------------------------------
#   MISC ALIASES
#   ---------------------------------------

alias cl='clear'
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias ll='ls -lhA'
alias fuckit='sudo "$BASH" -c "$(history -p !!)"'
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

#   ---------------------------------------
#   System Specific
#   ---------------------------------------

# mysql
export PATH="$PATH:/usr/local/mysql/bin/mysql"
alias mysql='/usr/local/mysql/bin/mysql'
alias mysqldump='/usr/local/mysql/bin/mysqldump'
alias mysqladmin='/usr/local/mysql/bin/mysqladmin'

# Apache
alias apacheEdit='sudo vim /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
alias herr='tail /var/log/httpd/error_log'              # herr:             Tails HTTP error logs
alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:   Shows apache error logs

# Vagrant
export PATH=$PATH:/Applications/VirtualBox.app/Contents/MacOS/
alias vb-restart="sudo /Library/Application\ Support/VirtualBox/LaunchDaemons/VirtualBoxStartup.sh restart"

# Composer executables
export PATH="$PATH:~/.composer/vendor/bin/"
