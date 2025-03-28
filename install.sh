#!/bin/bash

# Useful functions

# Asks a yes or no question with a custom prompt and default answer
function read_input () {
	answer="NULL"
	while [ $answer != "Y" ] && [ $answer != "y" ] && [ $answer != "N" ] && [ $answer != "n" ]
	do
		[ $answer != "NULL" ] && echo "Invalid Answer! Please answer (y)es or (n)o, or leave blank to use the default option."
		read -p "$1" answer
		[ -z $answer ] && answer="$2"
	done
}

# Installs latest focalboard-server on Archlinux
function focalboard_install () {
	if [ ! -d /opt/focalboard ]; then
		sudo pacman -Sy postgresql nginx --needed --noconfirm
		echo "initdb -D /var/lib/postgres/data" | sudo -iu postgres
		wget https://github.com/mattermost/focalboard/releases/download/v7.9.2/focalboard-server-linux-amd64.tar.gz && tar -xvzf focalboard-server-linux-amd64.tar.gz
		sudo mv -f focalboard /opt
		rm -rf focalboard*
		mkdir -p $HOME/.config/systemd/user
		sudo systemctl enable --now postgresql
		sudo systemctl enable --now nginx
		echo "echo \"CREATE DATABASE boards;CREATE USER boardsuser WITH PASSWORD 'boardsuser-password';GRANT ALL ON DATABASE boards TO boardsuser;ALTER DATABASE boards OWNER TO boardsuser;GRANT USAGE, CREATE ON SCHEMA PUBLIC TO boardsuser;\" | psql" | sudo --login --user postgres
		sudo mkdir -p /etc/nginx/sites-available/
		sudo mkdir -p /etc/nginx/sites-enabled/
		sudo cp $HOME/Distrobox-Quick-Setup/Config\ Files/Focalboard/focalboard /etc/nginx/sites-available
		sudo cp $HOME/Distrobox-Quick-Setup/Config\ Files/Focalboard/config.json /opt/focalboard
		sudo cp $HOME/Distrobox-Quick-Setup/Config\ Files/Focalboard/focalboard.service /lib/systemd/system/
		sudo ln -s /etc/nginx/sites-available/focalboard /etc/nginx/sites-enabled/focalboard
		sudo nginx -t
		sudo systemctl enable --now focalboard.service
	else
		echo "Focalboard already installed!"
	fi
	echo && echo "Focalboard installation ended with exit number $?."
}

# Create/Remove Some directories
mkdir -p $HOME/Documents
mkdir -p $HOME/Desktop
mkdir -p $HOME/Pictures
mkdir -p $HOME/Audiobooks
[ -f $HOME/.bashrc ] && rm $HOME/.bashrc
[ -f $HOME/.zshrc ] && rm $HOME/.zshrc
[ -f $HOME/.vimrc ] && rm $HOME/.vimrc
[ -f $HOME/.p10k.zsh ] && rm $HOME/.p10k.zsh
[ -f /etc/os-release ] && mkdir -p $HOME/.local/share/icons
[ -f /etc/os-release ] && mkdir -p $HOME/.local/share/applications
[ -f /etc/os-release ] && mkdir -p $HOME/.local/share/fonts
[ -f /etc/os-release ] && mkdir -p $HOME/.local/share/themes
[ -f /etc/os-release ] && mkdir -p $HOME/.config/systemd/user/
[ -f /etc/os-release ] && mkdir -p $HOME/.themes
[ -f /etc/os-release ] && mkdir -p $HOME/.fonts
[ -f /etc/os-release ] && mkdir -p $HOME/.icons
[ -f /etc/os-release ] && mkdir -p $HOME/.local/bin
touch $HOME/.hushlogin

# Link vimrc, zshrc, bashrc, etc
[ ! -L $HOME/.bashrc ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/.bashrc $HOME
[ ! -L $HOME/.zshrc ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/.zshrc $HOME
[ ! -L $HOME/.vimrc ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/.vimrc $HOME
[ ! -L $HOME/.mygreeting_google ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/Greetings/.mygreeting_google $HOME
[ ! -L $HOME/.mygreeting_uc3m ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/Greetings/.mygreeting_uc3m $HOME
[ ! -L $HOME/.mygreeting_uoc ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/Greetings/.mygreeting_uoc $HOME
[ ! -L $HOME/.mygreeting_42 ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/Greetings/.mygreeting_42 $HOME
[ ! -L $HOME/.mygreeting_tux ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/Greetings/.mygreeting_tux $HOME
[ ! -L $HOME/.mygreeting_telefonica ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/Greetings/.mygreeting_telefonica $HOME
[ ! -L $HOME/.p10k.zsh ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/.p10k.zsh $HOME

# Set Up Quarto and nvim configs
mkdir -p $HOME/.config
[ ! -d $HOME/.config/nvim ] && git clone https://github.com/jmbuhr/quarto-nvim-kickstarter.git $HOME/.config/nvim && rm -f $HOME/.config/nvim/init.lua && ln $HOME/Distrobox-Quick-Setup/Config\ Files/nvim/init.lua $HOME/.config/nvim && nvim && CFLAGS="" make -C $HOME/.local/share/nvim/lazy/telescope-fzf-native.nvim

# Setup Vim-Plug
[ ! -f $HOME/.vim/autoload/plug.vim ] && curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Vim Headers
mkdir -p $HOME/.vim/plugin/
[ ! -L $HOME/.vim/plugin/42.vim ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/Headers/42.vim $HOME/.vim/plugin/
[ ! -L $HOME/.vim/plugin/uc3m.vim ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/Headers/uc3m.vim $HOME/.vim/plugin/
[ ! -L $HOME/.vim/plugin/uoc.vim ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/Headers/uoc.vim $HOME/.vim/plugin/
[ ! -L $HOME/.vim/plugin/tux.vim ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/Headers/tux.vim $HOME/.vim/plugin/
[ ! -L $HOME/.vim/plugin/telefonica.vim ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/Headers/telefonica.vim $HOME/.vim/plugin/

# Install some base packages based on distro
[ -f /etc/os-release ] && ([ ! -f /bin/git ] || [ ! -f /bin/unzip ] || [ ! -f /bin/xz ] || [ ! -f /bin/gh ] || [ ! -f /bin/glab ]) && if LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Arch Linux\"" ; then
	sudo pacman -S git unzip xz github-cli glab --needed --noconfirm
fi
[ -f /etc/os-release ] && ([ ! -f /bin/git ] || [ ! -f /bin/unzip ] || [ ! -f /bin/xz ] || [ ! -f /bin/gh ] || [ ! -f /bin/glab ]) && if LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Debian GNU/Linux\"" ; then
	sudo apt install -y git unzip
	# Install gh
	type -p curl >/dev/null || sudo apt install curl -y
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh glab -y
fi
[ -f /etc/os-release ] && ([ ! -f /bin/git ] || [ ! -f /bin/unzip ] || [ ! -f /bin/xz ] || [ ! -f /bin/gh ] || [ ! -f /bin/glab ]) && if LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Fedora Linux\"" ; then
	sudo dnf install -y git unzip xz gh glab
fi

# Fzf installation
[ ! -d $HOME/.fzf ] && git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf && $HOME/.fzf/install

# Set up zsh and oh-my-zsh
[ ! -d $HOME/.oh-my-zsh ] && ZSH= sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
[ ! -d $HOME/powerlevel10k ] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k
[ -L $HOME/.zshrc.pre-oh-my-zsh ] && mv $HOME/.zshrc.pre-oh-my-zsh $HOME/.zshrc

# Install basic MacOS Stuff
if [ -f /usr/bin/sw_vers ]; then
	cd $HOME
	[ ! -d $HOME/.brew ] && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && source $HOME/.zshrc && brew update
	brew install node llvm neofetch lolcat wget gh asciiquarium ltex-ls
	brew tap LouisBrunner/valgrind
	brew install --HEAD LouisBrunner/valgrind/valgrind
	[ ! -d $HOME/nvim-macos ] && wget https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-macos.tar.gz && tar xzvf nvim-macos.tar.gz nvim-macos && rm nvim-macos.tar.gz
fi

# Set Up gh to handle git credentials
gh auth login
gh extension install jongio/gh-setup-git-credential-helper
gh setup-git-credential-helper

# Set up glab to handle git credentials
glab auth login

# Clone Useful Repos
cd $HOME
[ ! -d $HOME/Simple-Python-Time-Converter ] && git clone https://gitlab.com/madebypixel02/Simple-Python-Time-Converter.git
[ ! -d $HOME/madebypixel02 ] && git clone https://gitlab.com/madebypixel02/madebypixel02.git

# Clone GenAI Projects
mkdir -p $HOME/GenAI
cd $HOME/GenAI
[ ! -d genai-tests ] && git clone https://gitlab.com/madebypixel02/genai-tests.git
[ ! -d langchain-tests ] && git clone https://gitlab.com/madebypixel02/langchain-tests.git

# Clone 42 Madrid Projects
mkdir -p $HOME/42\ Madrid/Git/42\ Cursus
cd $HOME/42\ Madrid/Git/42\ Cursus
[ ! -d 42-Madrid-Cursus ] && git clone https://gitlab.com/madebypixel02/42-Madrid-Cursus.git
[ ! -d libft ] && git clone https://gitlab.com/madebypixel02/libft.git
[ ! -d ft_printf ] && git clone https://gitlab.com/madebypixel02/ft_printf.git && cd ft_printf && ln -s ../libft . && cd ..
[ ! -d get_next_line ] && git clone https://gitlab.com/madebypixel02/get_next_line.git
[ ! -d born2beroot ] && git clone https://gitlab.com/madebypixel02/born2beroot.git
[ ! -d so_long ] && git clone https://gitlab.com/madebypixel02/so_long.git && cd so_long && ln -s ../libft . && ln -s ../get_next_line . && cd ..
[ ! -d push_swap ] && git clone https://gitlab.com/madebypixel02/push_swap.git && cd push_swap && ln -s ../libft . && cd ..
[ ! -d pipex ] && git clone https://gitlab.com/madebypixel02/pipex.git
[ ! -d philosophers ] && git clone https://gitlab.com/madebypixel02/philosophers.git
[ ! -d minishell ] && git clone https://gitlab.com/madebypixel02/minishell.git && cd minishell && ln -s ../libft . && cd ..
[ ! -d cub3d ] && git clone https://gitlab.com/madebypixel02/cub3d.git && cd cub3d && ln -s ../libft . && cd ..
[ ! -d CPP-Modules ] && git clone https://gitlab.com/madebypixel02/CPP-Modules.git
[ ! -d CPP-Module-00 ] && git clone https://gitlab.com/madebypixel02/CPP-Module-00.git
[ ! -d CPP-Module-01 ] && git clone https://gitlab.com/madebypixel02/CPP-Module-01.git
[ ! -d CPP-Module-02 ] && git clone https://gitlab.com/madebypixel02/CPP-Module-02.git
[ ! -d CPP-Module-03 ] && git clone https://gitlab.com/madebypixel02/CPP-Module-03.git
[ ! -d CPP-Module-04 ] && git clone https://gitlab.com/madebypixel02/CPP-Module-04.git
[ ! -d CPP-Module-05 ] && git clone https://gitlab.com/madebypixel02/CPP-Module-05.git
[ ! -d CPP-Module-06 ] && git clone https://gitlab.com/madebypixel02/CPP-Module-06.git
[ ! -d CPP-Module-07 ] && git clone https://gitlab.com/madebypixel02/CPP-Module-07.git
[ ! -d CPP-Module-08 ] && git clone https://gitlab.com/madebypixel02/CPP-Module-08.git
[ ! -d NetPractice ] && git clone https://gitlab.com/madebypixel02/NetPractice.git
[ ! -d ft_irc ] && git clone https://github.com/madebypixel02/ft_irc.git

# Clone UOC Stuff
mkdir -p $HOME/UOC && [ ! -d $HOME/UOC/UOC-Projects ] && cd $HOME/UOC && git clone https://gitlab.com/madebypixel02/UOC-Projects.git && cd $HOME
mkdir -p $HOME/UOC/Human-Computer\ Interaction && [ ! -d $HOME/UOC/Human-Computer\ Interaction/HCI-Practices ] && cd $HOME/UOC/Human-Computer\ Interaction && git clone https://gitlab.com/madebypixel02/HCI-Practices.git && cd $HOME
mkdir -p $HOME/UOC/Web\ Standards\ \&\ Languages && [ ! -d $HOME/UOC/Web\ Standards\ \&\ Languages/Web-Standards-and-Languages-Practices ] && cd $HOME/UOC/Web\ Standards\ \&\ Languages && git clone https://gitlab.com/madebypixel02/Web-Standards-and-Languages-Practices.git && cd $HOME
mkdir -p $HOME/UOC/Operating\ Systems && [ ! -d $HOME/UOC/Operating\ Systems/Operating-Systems-Practices ] && cd $HOME/UOC/Operating\ Systems && git clone https://gitlab.com/madebypixel02/Operating-Systems-Practices.git && cd $HOME
mkdir -p $HOME/UOC/Object-Oriented\ Programming && [ ! -d $HOME/UOC/Object-Oriented\ Programming/OOP-Practices ] && cd $HOME/UOC/Object-Oriented\ Programming && git clone https://gitlab.com/madebypixel02/OOP-Practices.git && cd $HOME
mkdir -p $HOME/UOC/Enterpreneurship && [ ! -d $HOME/UOC/Enterpreneurship/Enterpreneurship-Practices ] && cd $HOME/UOC/Enterpreneurship && git clone https://gitlab.com/madebypixel02/Enterpreneurship-Practices.git && cd $HOME
mkdir -p $HOME/UOC/Software\ Design\ Patterns && [ ! -d $HOME/UOC/Software\ Design\ Patterns/Software-Design-Patterns-Practices ] && cd $HOME/UOC/Software\ Design\ Patterns && git clone https://gitlab.com/madebypixel02/Software-Design-Patterns-Practices.git && cd $HOME
mkdir -p $HOME/UOC/Networks\ and\ Internet\ Applications && [ ! -d $HOME/UOC/Networks\ and\ Internet\ Applications/Networks-and-Internet-Applications-Practices ] && cd $HOME/UOC/Networks\ and\ Internet\ Applications && git clone https://gitlab.com/madebypixel02/Networks-and-Internet-Applications-Practices.git && cd $HOME
mkdir -p $HOME/UOC/Mobile\ Application\ Development && [ ! -d $HOME/UOC/Mobile\ Application\ Development/MAD-Practices ] && cd $HOME/UOC/Mobile\ Application\ Development && git clone https://gitlab.com/madebypixel02/MAD-Practices.git && cd $HOME
mkdir -p $HOME/UOC/Cloud\ Computing && [ ! -d $HOME/UOC/Cloud\ Computing/Cloud-Computing-Practices ] && cd $HOME/UOC/Cloud\ Computing && git clone https://gitlab.com/madebypixel02/Cloud-Computing-Practices.git && cd $HOME
mkdir -p $HOME/UOC/Database\ Design && [ ! -d $HOME/UOC/Database\ Design/Database-Design-Practices ] && cd $HOME/UOC/Database\ Design && git clone https://gitlab.com/madebypixel02/Database-Design-Practices.git && cd $HOME
mkdir -p $HOME/UOC/Network\ and\ System\ Administration && [ ! -d $HOME/UOC/Network\ and\ System\ Administration/NSA-Practices ] && cd $HOME/UOC/Network\ and\ System\ Administration && git clone https://gitlab.com/madebypixel02/NSA-Practices.git && cd $HOME
mkdir -p $HOME/UOC/Software\ Engineering && [ ! -d $HOME/UOC/Software\ Engineering/Software-Engineering-Practices ] && cd $HOME/UOC/Software\ Engineering && git clone https://gitlab.com/madebypixel02/Software-Engineering-Practices.git && cd $HOME
mkdir -p $HOME/UOC/Web\ Programming && [ ! -d $HOME/UOC/Web\ Programming/Web-Programming-Practices ] && cd $HOME/UOC/Web\ Programming && git clone https://gitlab.com/madebypixel02/Web-Programming-Practices.git && cd $HOME
mkdir -p $HOME/UOC/E-Commerce && [ ! -d $HOME/UOC/E-Commerce/e-commerce-practices ] && cd $HOME/UOC/E-Commerce && git clone https://gitlab.com/madebypixel02/e-commerce-practices.git && cd $HOME

# Clone Uc3m Stuff
#mkdir -p $HOME/Uc3m/Programming\ I
#mkdir -p $HOME/Uc3m/Machine\ Learning\ I
#mkdir -p $HOME/Uc3m/Statistical\ Learning
#mkdir -p $HOME/Uc3m/Data\ Protection\ \&\ Cybersecurity/
#[ ! -d $HOME/Uc3m/Programming\ I/Basic-OOP-Donkey-Kong-in-Python ] && cd $HOME/Uc3m/Programming\ I/ && git clone https://gitlab.com/madebypixel02/Basic-OOP-Donkey-Kong-in-Python.git && cd $HOME/
#[ ! -d $HOME/Uc3m/Machine\ Learning\ I/Machine-Learning-Pacman ] && cd $HOME/Uc3m/Machine\ Learning\ I/ && git clone https://gitlab.com/madebypixel02/Machine-Learning-Pacman && cd $HOME/
#[ ! -d $HOME/Uc3m/Statistical\ Learning/Statistical-Learning-Practices-2021 ] && cd $HOME/Uc3m/Statistical\ Learning/ && git clone https://gitlab.com/madebypixel02/Statistical-Learning-Practices-2021.git && cd $HOME/
#[ ! -d $HOME/Uc3m/Data\ Protection\ \&\ Cybersecurity/ABE-Scalability ] && cd $HOME/Uc3m/Data\ Protection\ \&\ Cybersecurity/ && git clone https://gitlab.com/madebypixel02/ABE-Scalability.git && cd $HOME/
#[ ! -d $HOME/Uc3m/Data\ Protection\ \&\ Cybersecurity/Openssl-Practices-2022 ] && cd $HOME/Uc3m/Data\ Protection\ \&\ Cybersecurity/ && git clone https://gitlab.com/madebypixel02/Openssl-Practices-2022.git && cd $HOME/
#[ ! -d $HOME/Uc3m/Uc3m-Projects ] && cd $HOME/Uc3m && git clone https://gitlab.com/madebypixel02/Uc3m-Projects && cd $HOME/

# Stop installer on MacOS
[ -f /usr/bin/sw_vers ] && echo && echo "Installation completed with exit number $?. Enjoy your MacOS setup!" && exit

# Configure cmus
mkdir -p $HOME/.config/cmus
[ -f $HOME/.config/cmus/command-history ] && rm $HOME/.config/cmus/command-history
[ ! -L $HOME/.config/cmus/command-history ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/cmus/command-history $HOME/.config/cmus

# Configure browsh
[ ! -L $HOME/.config/browsh ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/browsh $HOME/.config/

# Configure mpv
mkdir -p $HOME/.config/mpv
echo "vo=gpu
hwdec=auto" > $HOME/.config/mpv/mpv.conf

# Copy Element Wallpapers
mkdir -p $HOME/.local/share/backgrounds
mkdir -p $HOME/.local/share/gnome-background-properties
cp -r $HOME/Distrobox-Quick-Setup/Config\ Files/gnome-background-properties/* $HOME/.local/share/gnome-background-properties/
cp -r $HOME/Distrobox-Quick-Setup/Config\ Files/Element/ $HOME/.local/share/backgrounds/

# Set up gnirehtet
[ ! -d $HOME/gnirehtet-rust-linux64 ] && wget https://github.com/Genymobile/gnirehtet/releases/download/v2.5/gnirehtet-rust-linux64-v2.5.zip && unzip gnirehtet-*.zip -d $HOME && rm -f gnirehtet-*.zip
[ ! -L $HOME/.local/bin/gnirehtet ] && ln -s $HOME/gnirehtet-rust-linux64/gnirehtet $HOME/.local/bin

# Install Cascadia Fonts
[ ! -L $HOME/.fonts/ttf/CascadiaCode ] && ln -s $HOME/Distrobox-Quick-Setup/Config\ Files/CascadiaCode/ $HOME/.fonts/ttf/

# Install Google Sans Fonts
cd $HOME/Distrobox-Quick-Setup/Config\ Files/
mkdir -p $HOME/.fonts/TTF
[ ! -f $HOME/.fonts/TTF/GoogleSans-Regular.ttf ] && unzip Google\ Sans.zip -d $HOME/.fonts/TTF
cd ..

# Install Meslo Nerd Fonts (for fallback icons)
cp $HOME/Distrobox-Quick-Setup/Config\ Files/MesloLGS\ NF\ Regular.ttf $HOME/.fonts/TTF

# Install xcursor-chromeos
[ ! -f $HOME/.icons/xcursor-chromeos/cursors/alias ] && cd Config\ Files/ && unzip xcursor-chromeos.zip -d $HOME/.icons/ && cd ..

# Set xcursor-chromeos as default
mkdir -p $HOME/.icons/default
#echo "[Icon Theme]
#Inherits=xcursor-chromeos" > $HOME/.icons/default/index.theme
#ln -s $HOME/.icons/xcursor-chromeos/cursors $HOME/.icons/default/cursors

# Install adw-gtk3
[ ! -d $HOME/.themes/adw-gtk3/gtk-3.0 ] && cd Config\ Files/ && cp -r adw-gtk3 $HOME/.themes/ && cp -r adw-gtk3-dark $HOME/.themes/

# Set Up Nix
#[ ! -d /nix ] && sudo install -d -m755 -o $(id -u) -g $(id -g) /nix && curl -L https://nixos.org/nix/install | sh

# Configure Auto-Theme
cp -r $HOME/Distrobox-Quick-Setup/Config\ Files/Auto\ Theme/Systemd/* $HOME/.config/systemd/user/
cp -r $HOME/Distrobox-Quick-Setup/Config\ Files/Auto\ Theme/.autotheme $HOME/

# Configure gnome terminal shortcuts
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Primary>Tab' 2>/dev/null
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Primary><Shift>Tab' 2>/dev/null

# Configure default folders
echo "XDG_DESKTOP_DIR=\"$HOME/Desktop\"
XDG_DOCUMENTS_DIR=\"$HOME/Documents\"
XDG_DOWNLOAD_DIR=\"$HOME/Downloads\"
XDG_MUSIC_DIR=\"$HOME/Music\"
XDG_PICTURES_DIR=\"$HOME/Pictures\"
XDG_PUBLICSHARE_DIR=\"$HOME/Public\"
XDG_TEMPLATES_DIR=\"$HOME/Templstes\"
XDG_VIDEOS_DIR=\"$HOME/Videos\"" > $HOME/.config/user-dirs.dirs
echo "enabled=False" > $HOME/.config/user-dirs.conf

# Copy icon files
#cp $HOME/Distrobox-Quick-Setup/Config\ Files/Icons/* $HOME/.local/share/icons

cd $HOME/Distrobox-Quick-Setup

# Run Installer based on Distro
if LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Arch Linux\"" ; then
	read_input "Do you want to auto-configure focalboard-server on this install? [y/N] " "N"
	if [ $answer == "y" ] || [ $answer == "Y" ]; then
		focalboard_install
	fi
	read_input "Would you like to install and configure the entire system? [Y/n] " "Y"
	if [ $answer == "y" ] || [ $answer == "Y" ]; then
		echo "Running installer for archlinux..."
		sleep 2
		cd arch && ./install.sh
	fi
	echo && echo "Installation completed with exit number $?. Enjoy your Archlinux setup!"
fi

if LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Debian GNU/Linux\"" ; then
	read_input "Would you like to install and configure the entire system? [Y/n] " "Y"
	if [ $answer == "y" ] || [ $answer == "Y" ]; then
		echo "Running installer for debian..."
		sleep 2
		cd debian && ./install.sh
	fi
	echo && echo "Installation completed with exit number $?. Enjoy your Debian setup!"
fi

if LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Fedora Linux\"" ; then
	read_input "Would you like to install and configure the entire system? [Y/n] " "Y"
	if [ $answer == "y" ] || [ $answer == "Y" ]; then
		echo "Running installer for fedora..."
		sleep 2
		cd fedora && ./install.sh
	fi
	echo && echo "Installation completed with exit number $?. Enjoy your Fedora setup!"
fi
