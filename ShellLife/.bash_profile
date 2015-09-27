export _WDR1_BASH_PROFILE=1

#=== start of automatically maintained lines (do not delete)===
# .bashrc, sourced by interactive non-login shells (also called by .bash_profile)
export PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin
umask 022
export CVSROOT=vault.yahoo.com:/CVSROOT
export CVS_RSH=/usr/local/bin/ssh
if [ "$PS1" != "" ]
then
	PS1="\h \t \w \$ "
	  setenv ()  { export $1="$2"; }
	unsetenv ()  { unset $*; }
fi
#===   end of automatically maintained lines (do not delete)===
# per-user custom comands go here...


## Check window size & reset LINES & COLUMNS if need be, automaticly
shopt -s checkwinsize

## Misc
PAGER="less"
EDITOR="emacs -nw"
VISUAL="emacs -nw"
AUTOLOGOUT=99999
export PAGER EDITOR VISUAL AUTOLOGOUT

## Basicly disable EOF from exiting the shell

## ooohhhh... Pretty Pretty Colors
if [ -f /etc/profile.d/color_ls.sh ]; then
    . /etc/profile.d/color_ls.sh 
fi

## Tell us when stuff is done
set -b 
set -o notify
set -o ignoreeof

## Don't check for mail, it's annoying
unset MAILCHECK

## The prompt
PS1="\[\033]0;\u@\h  \w\007\]\[\033[7m\][\t] \h:\W \!%\[\033[0m\] "

##############################################################################
## Default stuff
BASH_ENV=$HOME/.bashrc
USERNAME=""
export USERNAME BASH_ENV PATH HISTIGNORE


[ -n $DISPLAY ] && {
	[ -f /etc/profile.d/color_ls.sh ] && source /etc/profile.d/color_ls.sh
	 export XAUTHORITY=$HOME/.Xauthority
}

##############################################################################
## Paths & such
export PATH=$HOME/emacs-local/bin:/home/y/bin:/home/y/sbin:$HOME/bin:/bin:/usr/local/bin:/sbin:/usr/bin:/usr/ucb:/usr/X11R6/bin:/usr/lang:/usr/openwin/bin:/usr/sbin:/usr/ccs/bin:/usr/games:/usr/5bin:/usr/local/jdk/bin:/usr/local/mysql/bin:/usr/local/gvd/bin:$PATH:$HOME/dev/yahoo/my/scripts:/home/yahoo/bin:/home/wdr1/bin/mozilla:.

export MANPATH=/usr/man:/usr/local/man:/usr/local/X11R6/man:/usr/local/X/man:/usr/local/gnu/man:/usr/local/lang/man:/usr/lang/man:/usr/share/man:/usr/open/win/share/man:/usr/dt/man:/usr/share/man:$HOME/man:/home/y/man

export LD_LIBRARY_PATH=$HOME/lib

export PRINTER=a4-north

export LYNX_CFG=$HOME/.lynx.cfg

##############################################################################
## CVS Settings
export CVSROOT=vault.yahoo.com:/CVSROOT
export CVS_RSH=/usr/local/bin/ssh
export CVSEDITOR="emacs -nw"

##############################################################################
## History
export HISTIGNORE="&:bg:fg"
export HISTIGNORE="&:bg:fg"
export HISTSIZE="1000"
export HISTFILE="$/.bash_history"
export HISTFILESIZE="5000"
#export HISTCONTROL="igoredups"
export HISTCONTROL=
shopt -s histappend


##############################################################################
## Misc

## Core files can be useful when coding
ulimit -c unlimited

## Allow aliases in non-interactive shells
shopt -s expand_aliases

# Read first /etc/inputrc if the variable is not defined, and after 
# the /etc/inputrc include the ~/.inputrc
[ -z $INPUTRC ] && export INPUTRC=/etc/inputrc

##############################################################################
## Programmable Completion
complete -A command nohup exec eval trace gdb
complete -A command command type which 
complete -u finger su usermod userdel passwd
complete -f -X '!*.ps'  gs ghostview gv
complete -f -X '!*.pdf' acroread
complete -d cd
complete -c which
complete -f more less 
complete -F foob clock
COMPGEN_SSH_USERS=(breardon wdr1 devtemp jobu)
COMPGEN_SSH_HOSTS=(amusive.com barney.petsmart.com petsun.pasa.petsmart.com spot.pasa.petsmart.com jolly.pasa.petsmart.com gargoyle.cs.uchicago.edu localhost fermi.pasa.petsmart.com pandora.pasa.petsmart.com)
#complete -F compgen_ssh ssh
complete -F compgen_ssh ssh

##############################################################################
## Env Vars w/ machine lists
if [ -d /net/produce/yahoo/mirrors/ ]
then
  export YDFS_LIST=`cat /net/produce/yahoo/mirrors/ydfs | perl -pe 's/\n/ /; s/\.yahoo\.com//g;'`;
  export MY_LIST=`cat /net/produce/yahoo/mirrors/my-yahoo-only | grep -v ^oa[0-9]| perl -pe 's/\n/ /; s/\.yahoo\.com//g;'`;
  export MYDCX_LIST=`cat /net/produce/yahoo/mirrors/my.dcx | grep -v ^oa[0-9]| perl -pe 's/\n/ /; s/\.yahoo\.com//g;'`;
  export MYSECURE_LIST=`cat /net/produce/yahoo/mirrors/my-yahoo-paranoid | grep -v ^oa[0-9]| perl -pe 's/\n/ /; s/\.yahoo\.com//g;'`
  export MY="$MY_LIST $MYDCX_LIST";
  export INCOMING="incoming1.my incoming2.my"
fi



##############################################################################
## Load aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

## Load functions
if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi



if [ -z $_WDR1_BASHRC ] && [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

##############################################################################
## Load machine specifc settings
if [ -f "${HOME}/.bash_${HOST}_mrc" ]; then
    . "${HOME}/.bash_${HOST}_mrc"
fi
if [ -f "${HOME}/.bash_${HOSTNAME}_mrc" ]; then
    . "${HOME}/.bash_${HOSTNAME}_mrc"
fi

