#!/bin/bash

HOME=$(echo ~)

# Create/Remove Some directories
rm -rf $HOME/Music
rm -rf $HOME/Videos
mkdir -p $HOME/Documents
mkdir -p $HOME/Desktop
mkdir -p $HOME/Pictures
mkdir -p $HOME/Audiobooks
mkdir -p $HOME/.local/share/icons
mkdir -p $HOME/.local/share/applications
mkdir -p $HOME/.local/share/fonts
mkdir -p $HOME/.local/share/themes
mkdir -p $HOME/.config/systemd/user/
mkdir -p $HOME/.themes
mkdir -p $HOME/.fonts
mkdir -p $HOME/.icons
mkdir -p $HOME/.local/bin

# Add symbolic links
[ ! -L $HOME/Pictures/Useful\ Photos ] && ln -s /run/media/pixel/Pixel\ SD/Useful\ Photos/ $HOME/Pictures
[ ! -L $HOME/Pictures/Public\ Transportation ] && ln -s /run/media/pixel/Pixel\ SD/Public\ Transportation/ $HOME/Pictures
[ ! -L $HOME/Music ] && ln -s /run/media/pixel/Pixel\ SD/NewMusic $HOME/Music
[ ! -L $HOME/Videos ] && ln -s /run/media/pixel/Pixel\ SD/Videos $HOME/Videos
[ ! -L $HOME/Removable\ Devices ] && ln -s /run/media/pixel $HOME/Removable\ Devices
[ ! -L $HOME/Playlists ] && ln -s $HOME/Removable\ Devices/Pixel\ SD/Linux\ Playlists $HOME/Playlists
cp -r $HOME/Distrobox-Quick-Setup/Config\ Files/Mi\ Band/ $HOME/Documents

# Set custom rules in sudoers file
sudo mkdir -p /var/log/sudo/
sudo touch /var/log/sudo/sudo.log
echo "Defaults        badpass_message=\"Whoops, wrong password!\"
Defaults        logfile=\"/var/log/sudo/sudo.log\"" | sudo tee -a /etc/sudoers

# Copy neovim config file
mkdir -p $HOME/.config
cp -r $HOME/Distrobox-Quick-Setup/Config\ Files/nvim $HOME/.config/

# Configure cmus
mkdir -p $HOME/.config/cmus
cp $HOME/Distrobox-Quick-Setup/Config\ Files/cmus/autosave $HOME/.config/cmus/autosave

# Configure browsh
cp -r $HOME/Distrobox-Quick-Setup/Config\ Files/browsh $HOME/.config/

# Configure mpv
mkdir -p $HOME/.config/mpv
echo "vo=gpu
hwdec=auto" > $HOME/.config/mpv/mpv.conf

# Install unzip and git based on distro
if LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Arch Linux\"" ; then
	sudo pacman -S git unzip xz --needed --noconfirm
fi
if LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Debian GNU/Linux\"" ; then
	sudo apt install -y git unzip
fi
if LANG=C grep '^NAME' /etc/os-release | grep -q "NAME=\"Fedora Linux\"" ; then
	sudo dnf install -y git unzip xz
fi

# Setup Vim-Plug
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Set up zsh and oh-my-zsh
ZSH= sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k

# Fzf installation
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf && $HOME/.fzf/install

# Install Cascadia Fonts
[ ! -f $HOME/.fonts/ttf/CascadiaCodeItalic.ttf ] && wget https://github.com/microsoft/cascadia-code/releases/download/v2111.01/CascadiaCode-2111.01.zip -O cascadia-fonts.zip && \
	unzip cascadia-fonts.zip -d $HOME/.fonts/
rm -f cascadia-fonts.zip

# Install Google Sans Fonts
cd Config\ Files/
mkdir -p $HOME/.fonts/TTF
[ ! -f $HOME/.fonts/TTF/GoogleSans-Regular.ttf ] && unzip Google\ Sans.zip -d $HOME/.fonts/TTF
cd ..

# Install xcursor-chromeos
[ ! -f $HOME/.icons/xcursor-chromeos/cursors/alias ] && cd Config\ Files/ && unzip xcursor-chromeos.zip -d $HOME/.icons/ && cd ..

# Set xcursor-chromeos as default
mkdir -p $HOME/.icons/default
#echo "[Icon Theme]
#Inherits=xcursor-chromeos" > $HOME/.icons/default/index.theme
#ln -s $HOME/.icons/xcursor-chromeos/cursors $HOME/.icons/default/cursors

# Install adw-gtk3
[ ! -f $HOME/.themes/adw-gtk3/gtk-2.0 ] && cd Config\ Files/ && tar -xvf adw-gtk3v3-0.tar.xz && cp -r adw-gtk3 $HOME/.themes/ && rm -rf adw-gtk3 && \
	cp -r adw-gtk3-dark $HOME/.themes/ && rm -rf adw-gtk3-dark && cp -r adw-gtk2 $HOME/.themes/adw-gtk3/gtk-2.0 && \
	cp -r adw-gtk2-dark $HOME/.themes/adw-gtk3-dark/gtk-2.0 && cd ..

# Configure Auto-Theme
cp $HOME/Distrobox-Quick-Setup/Config\ Files/Auto\ Theme/Systemd/* $HOME/.config/systemd/user/
cp -r $HOME/Distrobox-Quick-Setup/Config\ Files/Auto\ Theme/.autotheme $HOME/

# Copy gnome podcasts backup
cp $HOME/Distrobox-Quick-Setup/Config\ Files/podcasts_opml.xml $HOME

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
XDG_VIDEOS_DIR=\"$HOME/Videos\"" > $HOME/.config/user-dirs.dirs
echo "enabled=False" > $HOME/.config/user-dirs.conf

# Copy vimrc, zshrc, bashrc, etc
cp $HOME/Distrobox-Quick-Setup/Config\ Files/vimrc $HOME/.vimrc
cp $HOME/Distrobox-Quick-Setup/Config\ Files/zshrc $HOME/.zshrc
cp $HOME/Distrobox-Quick-Setup/Config\ Files/bashrc $HOME/.bashrc
cp $HOME/Distrobox-Quick-Setup/Config\ Files/Greetings/mygreeting $HOME/.mygreeting
cp $HOME/Distrobox-Quick-Setup/Config\ Files/Greetings/mygreeting_uc3m $HOME/.mygreeting_uc3m
cp $HOME/Distrobox-Quick-Setup/Config\ Files/Greetings/mygreeting_42 $HOME/.mygreeting_42
cp $HOME/Distrobox-Quick-Setup/Config\ Files/Greetings/mygreeting_tux $HOME/.mygreeting_tux
cp $HOME/Distrobox-Quick-Setup/Config\ Files/p10k.zsh $HOME/.p10k.zsh

# Copy icon files
cp $HOME/Distrobox-Quick-Setup/Config\ Files/Icons/* $HOME/.local/share/icons

# 42 Header
mkdir -p $HOME/.vim/plugin/
cp $HOME/Distrobox-Quick-Setup/Config\ Files/Headers/42.vim $HOME/.vim/plugin/
cp $HOME/Distrobox-Quick-Setup/Config\ Files/Headers/uc3m.vim $HOME/.vim/plugin/
cp $HOME/Distrobox-Quick-Setup/Config\ Files/Headers/tux.vim $HOME/.vim/plugin/

# Configure git
git config --global user.name "madebypixel02"
git config --global user.email "madebypixel02@proton.me"
git config --global core.editor nvim
git config --global pull.rebase false
git config --global init.defaultBranch main

# Clone Useful Repos
git clone https://github.com/madebypixel02/Simple-Python-Time-Converter.git $HOME/Simple-Python-Time-Converter

# Clone 42 Madrid Projects
mkdir -p $HOME/42\ Madrid/GitHub/42\ Cursus
cd $HOME/42\ Madrid/GitHub/42\ Cursus
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
mkdir -p $HOME/College/Programming\ I
mkdir -p $HOME/College/Machine\ Learning\ I
mkdir -p $HOME/College/Statistical\ Learning
mkdir -p $HOME/College/Data\ Protection\ \&\ Cybersecurity/
cd $HOME/College/Programming\ I/ && git clone https://github.com/madebypixel02/Basic-OOP-Donkey-Kong-in-Python.git && cd $HOME/
cd $HOME/College/Machine\ Learning\ I/ && git clone https://github.com/madebypixel02/Machine-Learning-Pacman && cd $HOME/
cd $HOME/College/Statistical\ Learning/ && git clone https://github.com/madebypixel02/Statistial-Learning-Practices-2021.git && cd $HOME/
cd $HOME/College/Data\ Protection\ \&\ Cybersecurity/ && git clone https://github.com/madebypixel02/ABE-Scalability.git && cd $HOME/
cd $HOME/College/Data\ Protection\ \&\ Cybersecurity/ && git clone https://github.com/madebypixel02/Openssl-Practices-2022.git && cd $HOME/
cd $HOME/College && git clone https://github.com/madebypixel02/Uc3m-Projects && cd $HOME/

cd $HOME/Distrobox-Quick-Setup

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
