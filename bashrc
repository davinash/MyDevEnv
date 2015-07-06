# .bashrc

# User specific aliases and functions

# Source global definitions
[ -r /etc/bashrc ] && . /etc/bashrc

os=`uname -s`

if [ "${os}" = "Linux" ]; then
  trap "sudo -K" 0 1 3 15
  #ulimit -n 262144
elif [ "${os}" = "SunOS" ]; then
  JAVA_HOME="/export/gcm/where/jdk/1.6.0_26/sparc.Solaris"
  JAVA_ROOT="${JAVA_HOME}"
  JAVA_BINDIR="${JAVA_HOME}/bin"
  PATH="${HOME}/bin:${PATH}:/usr/ucb:/usr/sbin:/opt/SUNWspro/bin:/opt/sfw/bin:/usr/sfw/bin:/opt/SUNWspro/contrib/vim/bin:/usr/dt/bin"
  if [ -z "${LD_LIBRARY_PATH}" ]; then
    LD_LIBRARY_PATH="${HOME}/lib:/opt/SUNWspro/lib:/opt/sfw/lib:/usr/sfw/lib:/usr/dt/lib"
  else
    LD_LIBRARY_PATH="${HOME}/lib:${LD_LIBRARY_PATH}:/opt/SUNWspro/lib:/opt/sfw/lib:/usr/sfw/lib:/usr/dt/lib"
  fi
  if [ -z "${MANPATH}" ]; then
    MANPATH="/usr/man:/opt/SUNWspro/man:/opt/sfw/man:/usr/sfw/man:/opt/SUNWspro/contrib/vim/man:/usr/dt/man"
  else
    MANPATH="${MANPATH}:/usr/man:/opt/SUNWspro/man:/opt/sfw/man:/usr/sfw/man:/opt/SUNWspro/contrib/vim/man:/usr/dt/man"
  fi
  export JAVA_HOME JAVA_ROOT JAVA_BINDIR PATH LD_LIBRARY_PATH MANPATH

  if [ "${TERM}" = "cygwin" ]; then
    TERM=vt220
  fi
  export TERM
fi

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

## don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups
## ... and ignore same sucessive entries.
#export HISTCONTROL=ignoreboth

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-*color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" -a "${os}" = "Linux" ]; then
    eval "`dircolors -b`"
#alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
alias listpackages='dpkg --get-selections | grep -v deinstall'


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

JAVA_HOME=/adongre1/sandbox/localgcm/where/jdk/1.6.0_26/x86.linux

[ -r "${HOME}/.alias" ] && . "${HOME}/.alias"

case $TERM in
  screen*)
    SCREENTITLE='\[\ek\e\\\]\[\ek\h \W\e\\\]'
    ;;
  *)
    SCREENTITLE=''
    ;;
esac

if [ "${PS1}" ]; then
#export PS1='\u@\h:\w> '
  export PS1="${SCREENTITLE}[\u@\h \w]\$ "
fi


export PAGER=less

# proxy settings for command-line clients
ALL_PROXY=socks://proxy-blr.eng.vmware.com:3128
FTP_PROXY=http://proxy-blr.eng.vmware.com:3128
HTTPS_PROXY=http://proxy-blr.eng.vmware.com:3128
HTTP_PROXY=http://proxy-blr.eng.vmware.com:3128
NO_PROXY='localhost,127.0.0.0/8,*.local,*.vmware.com,svn.gemstone.com,wiki.gemstone.com,www.gemstone.com,community.gemstone.com,forums.gemstone.com'
all_proxy=socks://proxy-blr.eng.vmware.com:3128
ftp_proxy=http://proxy-blr.eng.vmware.com:3128
http_proxy=http://proxy-blr.eng.vmware.com:3128
https_proxy=http://proxy-blr.eng.vmware.com:3128
no_proxy='localhost,127.0.0.0/8,*.local,*.vmware.com,svn.gemstone.com,wiki.gemstone.com,www.gemstone.com,community.gemstone.com,forums.gemstone.com'
export ALL_PROXY FTP_PROXY HTTP_PROXY HTTPS_PROXY NO_PROXY
export all_proxy ftp_proxy http_proxy https_proxy no_proxy


# colours for less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export SVN_EDITOR=vim
export PATH=/adongre1/work/scala/lang/scala-2.10.3/bin:/adongre1/work/scala/tools/sbt.0.13.0/bin:$PATH
alias clj='java -cp  /adongre1/sandbox.open.source/clojure/target/clojure-1.7.0-master-SNAPSHOT.jar  clojure.main'

# Need to check the following
# some more ls aliases
alias ll='ls -alh'
alias la='ls -A'
alias l='ls -CFlh'
alias woo='fortune'
alias lsd="ls -alF | grep /$"

# This is GOLD for finding out what is taking so much space on your drives!
alias diskspace="du -S | sort -n -r |more"

# Command line mplayer movie watching for the win.
alias mp="mplayer -fs"

# Show me the size (sorted) of only the folders in this directory
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"

# This will keep you sane when you're about to smash the keyboard again.
alias frak="fortune"

