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
#    .zshrc                                           FqM            MMMM      #
#                                                   __| `.        |\dS'qML     #
#    By: madebypixel02 <madebypixel02@proton.me>    |    `.       | `' \Zq     #
#                                                   _)      .___.,|     .'     #
#    Created: 2022/06/25 20:30:55 by madebypixel02  \___   )MMMMMP|   .'       #
#    Updated: 2024/04/15 13:39:20 by madebypixel02      `-'       `--'         #
#                                                                              #
# **************************************************************************** #

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH_DISABLE_COMPFIX=true

HOME=$(echo ~)

export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
bindkey '^P' fzf-file-widget
# User configuration

#fpath+=$HOME/.zsh/pure
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate $HOME/.zshrc"
# alias ohmyzsh="mate $HOME/.oh-my-zsh"
# .zshrc

typeset -A crostini=(
	red	"#F28B82"
	green	"#87FFC5"
	yellow	"#FDD663"
	blue	"#8BB5F8"
	magenta	"#F4B5FB"
	cyan	"#80F9F9"
)

## My own Stuff ##

# Load wallpaer-based color scheme
#[ ! -f ~/.cache/wal/sequences ] && (wal -i "$(gsettings get org.gnome.desktop.background picture-uri | sed -e "s/file:\/\///g" -e "s/%20/\ /" -e "s/-l.jpg/-d.jpg/" -e "s/-l.png/-d.png/" -e "s/-l.svg/-d.svg/" | tr -d \')" 1>/dev/null)
#(cat ~/.cache/wal/sequences &)
#source ~/.cache/wal/colors-tty.sh

setopt HIST_IGNORE_SPACE

# Custom 42 greeting
#[ -L $HOME/.mygreeting_42 ] && zsh $HOME/.mygreeting_42
[ -L $HOME/.mygreeting_tux ] && zsh $HOME/.mygreeting_tux

# ADB devices
GINKGO=2760c408
EMULATOR=emulator-5554

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

# Basic Aliases and Exports
export CFLAGS="-Wall -Wextra -Werror"
export MAIL="aperez-b@student.42.fr"
alias downs="cd $HOME/Descargas/"
alias clear_downs="rm -rf $HOME/Descargas/*"
alias docs="cd $HOME/Documentos/"
alias music="cd $HOME/Música/"
alias x="clear && ls -a"
alias desktop="cd $HOME/Escritorio/"
alias r="clear && source $HOME/.zshrc && builtin cd"
alias q="exit"
alias apps="builtin cd /usr/share/applications && ls /usr/share/applications"
alias appicons="builtin cd /usr/share/icons && ls /usr/share/icons"
alias localapps="builtin cd $HOME/.local/share/applications && ls $HOME/.local/share/applications"
alias h="cd $HOME/"
alias bashrc="nvim $HOME/.bashrc"
alias zshrc="nvim $HOME/.zshrc"
alias vimrc="nvim $HOME/.vimrc"
alias removable="cd $HOME/Removable\ Devices"
alias ext="cd $HOME/Removable\ Devices"
alias v="neofetch | lolcat"
alias l="echo -e '\n\e[1;33mThis directory has the following:\e[0m' && tree -L 2 -C --filelimit 100"
alias parrot.live="curl parrot.live"
alias college_uc3m="zsh -c $HOME/.mygreeting_uc3m && cd $HOME/Uc3m/"
alias college_uoc="zsh -c $HOME/.mygreeting_uoc && cd $HOME/UOC/"
alias cursus="zsh -c $HOME/.mygreeting_42 && cd $HOME/42\ Madrid/Git/42\ Cursus"
alias tux="zsh -c $HOME/.mygreeting_tux"
alias 42="zsh -c $HOME/.mygreeting_42"
alias telefonica="zsh -c $HOME/.mygreeting_telefonica"
alias google="zsh -c $HOME/.mygreeting_google"
alias uoc="zsh -c $HOME/.mygreeting_uoc"
alias uc3m="zsh -c $HOME/.mygreeting_uc3m"
alias mg="git add . && git commit && git push"
alias bashrc_update="builtin cd $HOME/Distrobox-Quick-Setup/Config\ Files && git add .bashrc && git commit -m \"Edited bashrc\" && git push && builtin cd $HOME/"
alias zshrc_update="builtin cd $HOME/Distrobox-Quick-Setup/Config\ Files && git add .zshrc && git commit -m \"Edited zshrc\" && git push && builtin cd $HOME/"
alias vimrc_update="builtin cd $HOME/Distrobox-Quick-Setup/Config\ Files && git add .vimrc && git commit -m \"Edited vimrc\" && git push && builtin cd $HOME/"
alias p10k_update="builtin cd $HOME/Distrobox-Quick-Setup/Config\ Files && git add .p10k.zsh && git commit -m \"Edited p10k.zsh\" && git push && builtin cd $HOME/"

# Aliases for MacOS
if [ -f /usr/bin/sw_vers ]; then
	export PATH=$HOME/.brew/Cellar/llvm/12.0.1/bin/:$PATH:$HOME/nvim-macos/bin
	export PATH=$HOME/.brew/bin:$PATH:$HOME/nvim-osx64/bin
	[ -d $HOME/42\ Madrid/Git/42\ Cursus ] && export PATH=$PATH:$(find $HOME/42\ Madrid/Git/42\ Cursus -type d -name bin | head -c $(($(find $HOME/42\ Madrid/Git/42\ Cursus -type d -name bin | wc -c) - 1)) 2>/dev/null | tr "\n" ":") && echo -n
	alias clear="clear && printf '\e[3J'"
	alias u="brew update && brew upgrade"
	alias timeconvert="python3 -u '$HOME/Simple-Python-Time-Converter/timeconverter.py'"
	export FZF_DEFAULT_COMMAND="bash -c \"set -o pipefail; command find -L . -mindepth 1 \( -path '*/\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \) -prune -o -type f -print -o -type l -print 2> /dev/null | cut -b3-\""
	git config --global credential.helper osxkeychain
	osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/aperez-b/Distrobox-Quick-Setup/Config Files/Element/Wind-d.jpg"'
	osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
	defaults -currentHost write -g com.apple.swipescrolldirection -bool FALSE
	defaults -currentHost write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
	defaults -currentHost write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)
else
	eval "$(dircolors -p | \
		sed 's/ 4[0-9];/ 01;/; s/;4[0-9];/;01;/g; s/;4[0-9] /;01 /' | \
	 	dircolors /dev/stdin)"
	alias ls='ls --color=auto'
	
	zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
	autoload -Uz compinit
	compinit
	export FZF_DEFAULT_COMMAND="find -L"
	[ -d $HOME/42\ Madrid/Git/42\ Cursus ] && export PATH=$PATH:$(find $HOME/42\ Madrid/Git/42\ Cursus -type d -name bin | head --bytes -1 | tr "\n" ":") && echo -n
	export PATH="$PATH:$HOME/.local/bin:/opt/google-cloud-cli/bin"
	alias leaks="valgrind --leak-check=full --show-leak-kinds=all --track-fds=yes --trace-children=yes -s -q"
	git config --global credential.helper libsecret
fi

# Aliases for Arch Linux
if [ -f /etc/os-release ] && LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Arch Linux\"" ; then
	export LD_LIBRARY_PATH=/usr/local/lib
	# Other Aliases
	alias scc="yay -Scc"
	alias u="yay -Syu --noconfirm"
	alias tether="gnirehtet run"
	alias unwine="wine uninstaller"
	alias yoump3="youtube-dl -x --audio-format mp3"
	alias pipupdate="sudo pip install -U"
	alias yan="yay --noconfirm --needed"
	alias checktheme="systemctl --user status auto-theme.service"
	alias checktheme-now="python -u '$HOME/.autotheme/timecheck-now.py'"
	alias donkeykong="python -u '$HOME/Uc3m/Basic-OOP-Donkey-Kong-in-Python/mario_barrel.py'"
	alias pac-man="make play -C $HOME/42\ Madrid/Git/42\ Cursus/so_long"
	alias timeconvert="python -u '$HOME/Simple-Python-Time-Converter/timeconverter.py'"
	alias sp_update="sudo pip install https://codeload.github.com/spotDL/spotify-downloader/zip/master"
fi

# Aliases for VanillaOS
if [ -f /etc/os-release ] && LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"VanillaOS\"" ; then
	git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
fi

# Aliases for Debian
if [ -f /etc/os-release ] && LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Debian GNU/Linux\"" ; then
	export LD_LIBRARY_PATH=/usr/local/lib
	git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
	[ -f /etc/localtime ] && sudo umount -l /etc/localtime
	# Other Aliases
	alias u="sudo apt -y update && sudo apt -y upgrade"
	alias python="python3"
	alias pip="pip3"
	alias tether="gnirehtet run"
	alias unwine="wine uninstaller"
	alias yoump3="youtube-dl -x --audio-format mp3"
	alias pipupdate="sudo pip3 install -U"
	alias yan="yay --noconfirm --needed"
	alias checktheme="systemctl --user status auto-theme.service"
	alias checktheme-now="python3 -u '$HOME/.autotheme/timecheck-now.py'"
	alias pac-man="make play -C $HOME/42\ Madrid/Git/42\ Cursus/so_long"
	alias timeconvert="python3 -u '$HOME/Simple-Python-Time-Converter/timeconverter.py'"
	alias sp_update="sudo pip3 install https://codeload.github.com/spotDL/spotify-downloader/zip/master"
fi

# Aliases for Fedora
if [ -f /etc/os-release ] && LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Fedora Linux\"" ; then
	export LD_LIBRARY_PATH=/usr/local/lib
	# Other Aliases
	alias checktheme="systemctl --user status auto-theme.service"
	alias checktheme-now="python -u '$HOME/.autotheme/timecheck-now.py'"
	# Aliases for container
	if LANG=C grep '^VARIANT' /etc/os-release | grep -q "VARIANT=\"Container Image\"" ; then
		alias u="sudo dnf -y update --skip-broken --nobest --allowerasing"
		alias tether="gnirehtet run"
		alias unwine="wine uninstaller"
		alias yoump3="youtube-dl -x --audio-format mp3"
		alias pipupdate="sudo pip install -U"
		alias yan="yay --noconfirm --needed"
		alias donkeykong="python -u '$HOME/Uc3m/Basic-OOP-Donkey-Kong-in-Python/mario_barrel.py'"
		alias pac-man="make play -C $HOME/42\ Madrid/Git/42\ Cursus/so_long"
		alias timeconvert="python -u '$HOME/Simple-Python-Time-Converter/timeconverter.py'"
		alias sp_update="sudo pip install https://codeload.github.com/spotDL/spotify-downloader/zip/master"
	fi
	# Aliases for Silverblue
	if LANG=C grep '^VARIANT_ID' /etc/os-release | grep -q "VARIANT_ID=silverblue" ; then
		alias u="rpm-ostree update"
	fi
fi

# Custom Functions
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
	ls "${new_directory}" && builtin cd "${new_directory}"
}

function mkcdir() {
	mkdir -p -- "$1" &&
	cd "$1"
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:/snap/bin:$HOME/.rvm/bin"

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
source $HOME/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit $HOME/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source Nix
[ -f $HOME/.nix-profile/etc/profile.d/nix.sh ] && source $HOME/.nix-profile/etc/profile.d/nix.sh

if [ -e /home/pixel/.nix-profile/etc/profile.d/nix.sh ]; then . /home/pixel/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

if [ -e /var/home/aperez-b/.nix-profile/etc/profile.d/nix.sh ]; then . /var/home/aperez-b/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
