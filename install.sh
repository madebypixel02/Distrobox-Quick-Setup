#!/bin/bash

USER=$(whoami)

# Create/Remove Some directories
mkdir -p ~/Documents
mkdir -p ~/Desktop
mkdir -p ~/Pictures
mkdir -p ~/Audiobooks
mkdir -p ~/.local/share/icons
mkdir -p ~/.local/share/applications
mkdir -p ~/.config/systemd/user/

# Add symbolic links
[ ! -f ~/Pictures/Useful\ Photos ] && ln -s /run/media/pixel/Pixel\ SD/Useful\ Photos/ ~/Pictures
[ ! -f ~/Pictures/Public\ Transportation ] && ln -s /run/media/pixel/Pixel\ SD/Public\ Transportation/ ~/Pictures
[ ! -f ~/Music ] && ln -s /run/media/pixel/Pixel\ SD/NewMusic ~/Music
[ ! -f ~/Videos ] && ln -s /run/media/pixel/Pixel\ SD/Videos ~/Videos
[ ! -f ~/Removable\ Devices ] && ln -s /run/media/pixel ~/Removable\ Devices
[ ! -f ~/Playlists ] && ln -s ~/Removable\ Devices/Pixel\ SD/Linux\ Playlists ~/Playlists
cp -r ~/Distrobox-Quick-Setup/Config\ Files/Mi\ Band/ ~/Documents

# Copy vimrc, zshrc, bashrc, etc
cp ~/Distrobox-Quick-Setup/Config\ Files/vimrc ~/.vimrc
cp ~/Distrobox-Quick-Setup/Config\ Files/zshrc ~/.zshrc
cp ~/Distrobox-Quick-Setup/Config\ Files/bashrc ~/.bashrc
cp ~/Distrobox-Quick-Setup/Config\ Files/mygreeting ~/.mygreeting
cp ~/Distrobox-Quick-Setup/Config\ Files/mygreeting_uc3m ~/.mygreeting_uc3m
cp ~/Distrobox-Quick-Setup/Config\ Files/mygreeting42 ~/.mygreeting42
cp ~/Distrobox-Quick-Setup/Config\ Files/p10k.zsh ~/.p10k.zsh

# Set locale
echo "en_US.UTF-8 UTF-8
es_ES.UTF-8 UTF-8" | sudo tee /etc/locale.gen
echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf
sudo locale-gen

# Set custom rules in sudoers file
sudo mkdir -p /var/log/sudo/
sudo touch /var/log/sudo/sudo.log
echo "Defaults        badpass_message=\"Whoops, wrong password!\"
Defaults        logfile=\"/var/log/sudo/sudo.log\"" | sudo tee -a /etc/sudoers

# Copy neovim config file
mkdir -p ~/.config
cp -r ~/Distrobox-Quick-Setup/Config\ Files/nvim ~/.config/

# Configure cmus
mkdir -p /home/$USER/.config/cmus
cp ~/Distrobox-Quick-Setup/Config\ Files/cmus/autosave /home/$USER/.config/cmus/autosave

# Configure browsh
cp -r ~/Distrobox-Quick-Setup/Config\ Files/browsh ~/.config/

# Configure mpv
mkdir -p ~/.config/mpv
echo "vo=gpu
hwdec=auto" > ~/.config/mpv/mpv.conf

# Fzf installation
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install Google Sans Fonts
cd Config\ Files/
mkdir -p /home/$USER/.local/share/fonts/TTF
unzip Google\ Sans.zip -d /home/$USER/.local/share/fonts/TTF
cd ..

# Install xcursor-chromeos
cd Config\ Files/ && unzip xcursor-chromeos.zip -d /home/$USER/.local/share/icons/ && cd ..

# Set xcursor-chromeos as default
mkdir -p ~/.icons/default
#echo "[Icon Theme]
#Inherits=xcursor-chromeos" > ~/.icons/default/index.theme
#ln -s /home/$USER/.local/share/icons/xcursor-chromeos/cursors ~/.icons/default/cursors

# Install adw-gtk3
cd Config\ Files/
tar -xvf adw-gtk3v3-0.tar.xz
cp -r adw-gtk3 ~/.local/share/themes/ && rm -rf adw-gtk3
cp -r adw-gtk3-dark ~/.local/share/themes/ && rm -rf adw-gtk3-dark
cp -r adw-gtk2-dark ~/.local/share/themes/adw-gtk3/gtk-2.0
cp -r adw-gtk2-dark ~/.local/share/themes/adw-gtk3-dark/gtk-2.0
cd ..

# Configure Auto-Theme
cp ~/Distrobox-Quick-Setup/Config\ Files/Auto\ Theme/Systemd/* ~/.config/systemd/user/
cp -r ~/Distrobox-Quick-Setup/Config\ Files/Auto\ Theme/.autotheme ~/

# Copy gnome podcasts backup
cp ~/Distrobox-Quick-Setup/Config\ Files/podcasts_opml.xml /home/$USER

# Configure gnome terminal shortcuts
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Primary>Tab'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Primary><Shift>Tab'

# Configure default folders
echo "XDG_DESKTOP_DIR=\"$HOME/Desktop\"
XDG_DOCUMENTS_DIR=\"$HOME/Documents\"
XDG_DOWNLOAD_DIR=\"$HOME/Downloads\"
XDG_MUSIC_DIR=\"$HOME/Music\"
XDG_PICTURES_DIR=\"$HOME/Pictures\"
XDG_PUBLICSHARE_DIR=\"$HOME/Public\"
XDG_TEMPLATES_DIR=\"$HOME/Templates\"
XDG_VIDEOS_DIR=\"$HOME/Videos\"" > ~/.config/user-dirs.dirs
echo "enabled=False" > ~/.config/user-dirs.conf

# 42 Header
mkdir -p ~/.vim/plugin/
cp ~/Distrobox-Quick-Setup/42\ Madrid/Header/stdheader.vim ~/.vim/plugin/
cp ~/Distrobox-Quick-Setup/42\ Madrid/Header/customheader.vim ~/.vim/plugin/

# Clone Useful Repos
git clone https://github.com/madebypixel02/Simple-Python-Time-Converter.git ~/Simple-Python-Time-Converter

# Clone 42 Madrid Projects
mkdir -p ~/42\ Madrid/GitHub/42\ Cursus
cd ~/42\ Madrid/GitHub/42\ Cursus
git clone https://github.com/madebypixel02/libft.git
git clone https://github.com/madebypixel02/ft_printf.git && cd ft_printf && ln -s ../libft . && cd ..
git clone https://github.com/madebypixel02/get_next_line.git
git clone https://github.com/madebypixel02/born2beroot.git
git clone https://github.com/madebypixel02/so_long.git && cd so_long && ln -s ../libft . && ln -s ../get_next_line . && cd ..
git clone https://github.com/madebypixel02/push_swap.git && cd push_swap && ln -s ../libft . && cd ..
git clone https://github.com/madebypixel02/pipex.git
git clone https://github.com/madebypixel02/philosophers.git
git clone https://github.com/madebypixel02/minishell.git && cd minishell && ln -s ../libft . && cd ..
git clone https://github.com/madebypixel02/cub3d.git && cd cub3d && ln -s ../libft . && cd ..
git clone https://github.com/madebypixel02/CPP-Modules.git
git clone https://github.com/madebypixel02/CPP-Module-00.git
git clone https://github.com/madebypixel02/CPP-Module-01.git
git clone https://github.com/madebypixel02/CPP-Module-02.git
git clone https://github.com/madebypixel02/CPP-Module-03.git
git clone https://github.com/madebypixel02/CPP-Module-04.git
git clone https://github.com/madebypixel02/CPP-Module-05.git
git clone https://github.com/madebypixel02/CPP-Module-06.git
git clone https://github.com/madebypixel02/CPP-Module-07.git
git clone https://github.com/madebypixel02/CPP-Module-08.git

# Clone College Stuff
mkdir -p ~/College/Programming\ I
mkdir -p ~/College/Machine\ Learning\ I
mkdir -p ~/College/Statistical\ Learning
mkdir -p ~/College/Data\ Protection\ \&\ Cybersecurity/
cd ~/College/Programming\ I/ && git clone https://github.com/madebypixel02/Basic-OOP-Donkey-Kong-in-Python.git && cd ~/
cd ~/College/Machine\ Learning\ I/ && git clone https://github.com/madebypixel02/Machine-Learning-Pacman && cd ~/
cd ~/College/Statistical\ Learning/ && git clone https://github.com/madebypixel02/Statistial-Learning-Practices-2021.git && cd ~/
cd ~/College/Data\ Protection\ \&\ Cybersecurity/ && git clone https://github.com/madebypixel02/ABE-Scalability.git && cd ~/
cd ~/College/Data\ Protection\ \&\ Cybersecurity/ && git clone https://github.com/madebypixel02/Openssl-Practices-2022.git && cd ~/
cd ~/College && git clone https://github.com/madebypixel02/Uc3m-Projects && cd ~/

cd ~/Distrobox-Quick-Setup

# Call Installer based on Distro
if LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Arch Linux\"" ; then
	clear
	echo "Calling installer for archlinux..."
	sleep 2
	cd arch && ./install.sh
fi

if LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Debian GNU/Linux\"" ; then
	clear
	echo "Calling installer for debian..."
	sleep 2
	cd debian && ./install.sh
fi

if LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Fedora Linux\"" ; then
	clear
	echo "Calling installer for fedora..."
	sleep 2
	cd fedora && ./install.sh
fi
