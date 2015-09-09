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

#Composer
alias getcomposer='curl -sS https://getcomposer.org/installer | php' #Get the latest composer version

#Other
alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page


#   ---------------------------------------
#   MISC ALIASES
#   ---------------------------------------

alias cl='clear'

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
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

###########################################
#   System Specific
###########################################

#mysql
export PATH="$PATH:/usr/local/mysql/bin/mysql"
alias mysql='/usr/local/mysql/bin/mysql'
alias mysqldump='/usr/local/mysql/bin/mysqldump'
alias mysqladmin='/usr/local/mysql/bin/mysqladmin'

#Apache
alias apacheEdit='sudo vim /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
alias herr='tail /var/log/httpd/error_log'              # herr:             Tails HTTP error logs
alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:   Shows apache error logs

#Vagrant
export PATH=$PATH:/Applications/VirtualBox.app/Contents/MacOS/
alias vb-restart="sudo /Library/Application\ Support/VirtualBox/LaunchDaemons/VirtualBoxStartup.sh restart"

#BASH
alias ll='ls -lhA'
alias fuckit='sudo "$BASH" -c "$(history -p !!)"'
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"

#Drupal
# Drupal module in one command.
makeDrupalModule() {
  mkdir $1
  cd $1
  echo -e "name = $1" > $1.info
  echo -e "core = 7.x" >> $1.info
  echo -e "files[] =" >> $1.info
  echo -e "<?php" > $1.module
  echo -e "/**" >> $1.module
  echo -e " * @file" >> $1.module
  echo -e " * @copyright (C) Copyright 2014 tbd" >> $1.module
  echo -e " */" >> $1.module
  echo -e "function $1_() {" >> $1.module
  echo -e "}" >> $1.module
}

# Make my life easier
alias zietlow.drupal=makeDrupalModule

# Composer executables
export PATH="$PATH:~/.composer/vendor/bin/"

