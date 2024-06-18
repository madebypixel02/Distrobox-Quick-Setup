# **************************************************************************** #
#                                                                              #
#                                                           _nnnn_             #
#                                                          dGGGGMMb            #
#                                                         @p~qp~~qMb           #
#                                                         M|@||@) M|           #
#                                                         @,----.JM|           #
#                                                        JS^\__/  qKL          #
#                                                       dZP        qKRb        #
#                                                      dZP          qKKb       #
#                                                     fZP            SMMb      #
#                                                     HZM            MMMM      #
#    .bashrc                                          FqM            MMMM      #
#                                                   __| `.        |\dS'qML     #
#    By: madebypixel02 <madebypixel02@proton.me>    |    `.       | `' \Zq     #
#                                                   _)      .___.,|     .'     #
#    Created: 2022/06/25 20:31:10 by madebypixel02  \___   )MMMMMP|   .'       #
#    Updated: 2024/06/18 15:06:29 by madebypixel02      `-'       `--'         #
#                                                                              #
# **************************************************************************** #

#
# ~/.bashrc
#

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Put your fun stuff here

# Load wallpaer-based color scheme
#(wal -i "$(gsettings get org.gnome.desktop.background picture-uri | sed -e "s/file:\/\///g" -e "s/%20/\ /" -e "s/-l.jpg/-d.jpg/" -e "s/-l.png/-d.png/" -e "s/-l.svg/-d.svg/" | tr -d \')" 1>/dev/null)
#(cat ~/.cache/wal/sequences &)
#source ~/.cache/wal/colors-tty.sh

export LD_LIBRARY_PATH=/usr/local/lib

HOME=$(echo ~)

# 42 Madrid Stuff

alias old_norminette="$HOME/.norminette/norminette.rb"
CFLAGS="-Wall -Wextra -Werror"
#USER="aperez-b"
MAIL="marvin@42.fr"

# Custom Google greeting
# bash $HOME/.mygreeting

# Custom 42 greeting
#bash $HOME/.mygreeting_42
bash $HOME/.mygreeting_tux

# Color Aliases
export DEFAULT="\\e[39m"
export GRAY="\\e[90m"
export RED="\\e[91m"
export GREEN="\\e[92m"
export YELLOW="\\e[93m"
export BLUE="\\e[94m"
export MAGENTA="\\e[95m"
export CYAN="\\e[96m"
export WHITE="\\e[97m"

# Other Aliases
alias python="python3"
alias pip="pip3"
alias downs="cd $HOME/Downloads"
alias clear_downs="rm -rf $HOME/Downloads/*"
alias docs="cd $HOME/Documents"
alias music="cd $HOME/Music"
alias x="clear && ls -a"
alias gdrive="cd $HOME/Google\ Drive"
alias desktop="cd $HOME/Desktop"
alias r="clear && source $HOME/.zshrc && builtin cd"
alias q="exit"
alias u="sudo aptitude update && sudo aptitude -y upgrade"
alias tether="gnirehtet run"
alias unwine="wine uninstaller"
alias apps="cd /usr/share/applications"
alias appicons="cd /usr/share/icons"
alias localapps="cd $HOME/.local/share/applications"
alias h="cd $HOME/"
alias bashrc="vim $HOME/.bashrc"
alias bashrc_update="cp $HOME/.bashrc $HOME/Distrobox-Quick-Setup/Config\ Files/bashrc && builtin cd $HOME/Distrobox-Quick-Setup/Config\ Files && git add bashrc && git commit -m \"Edited bashrc\" && git push && builtin cd $HOME/"
alias zshrc="vim $HOME/.zshrc"
alias zshrc_update="cp $HOME/.zshrc $HOME/Distrobox-Quick-Setup/Config\ Files/zshrc && builtin cd $HOME/Distrobox-Quick-Setup/Config\ Files && git add zshrc && git commit -m \"Edited zshrc\" && git push && builtin cd $HOME/"
alias vimrc="vim $HOME/.vimrc"
alias vimrc_update="cp $HOME/.vimrc $HOME/Distrobox-Quick-Setup/Config\ Files/vimrc && builtin cd $HOME/Distrobox-Quick-Setup/Config\ Files && git add vimrc && git commit -m \"Edited vimrc\" && git push && builtin cd $HOME/"
alias p10k_update="cp $HOME/.p10k.zsh $HOME/Distrobox-Quick-Setup/Config\ Files/p10k.zsh && builtin cd $HOME/Distrobox-Quick-Setup/Config\ Files && git add p10k.zsh && git commit -m \"Edited p10k.zsh\" && git push && builtin cd $HOME/"
alias removable="cd $HOME/Removable\ Devices"
alias ext="cd $HOME/Removable\ Devices"
alias v="neofetch | lolcat"
alias l="echo -e '\n\e[1;33mThis directory has the following:\e[0m' && tree -L 2 -C --filelimit 100"
alias yoump3="youtube-dl -x --audio-format mp3"
alias pipupdate="sudo pip install -U"
alias checktheme="systemctl --user status auto-theme.service"
alias checktheme-now="python -u '$HOME/.autotheme/timecheck-now.py'"
alias donkeykong="python -u '$HOME/College/Programming I/Basic-OOP-Donkey-Kong-in-Python/mario_barrel.py'"
alias pac-man="/usr/bin/sommelier -X --scale=0.7 2>/dev/null make play -C $HOME/42\ Madrid/GitHub/42\ Cursus/so_long"
alias vbmeta="fastboot --disable-verity --disable-verification flash vbmeta $HOME/.vbmeta/vbmeta.img && fastboot reboot"
alias timeconvert="python -u '$HOME/Simple-Python-Time-Converter/timeconverter.py'"
alias sp_update="sudo pip install https://codeload.github.com/spotDL/spotify-downloader/zip/master"
alias parrot.live="curl parrot.live"
alias college_uc3m="cd $HOME/Uc3m/"
alias college_uoc="cd $HOME/UOC/"
alias uc3m="zsh -c $HOME/.mygreeting_uc3m"
alias mg="git add . && git commit && git push"

# Functions (custom)
function b() {
  if [ $# -eq 0 ]; then
    count=1
  else
    count="$1"
  fi

  i=0
  while [ $i -lt $count ]; do
    builtin cd '..'
    i=$((i+1))
  done
  l
}

function up() {
  if [ $# -eq 0 ]; then
    count=1
  else
    count="$1"
  fi

  i=0
  while [ $i -lt $count ]; do
    builtin cd '..'
    i=$((i+1))
  done
  l
}

function cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then
        new_directory=${HOME};
    fi;
    l "${new_directory}" && builtin cd "${new_directory}"
}

function mkcdir() {
    mkdir -p -- "$1" &&
    cd "$1"
}

[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Source Nix
[ -f $HOME/.nix-profile/etc/profile.d/nix.sh ] && source $HOME/.nix-profile/etc/profile.d/nix.sh
