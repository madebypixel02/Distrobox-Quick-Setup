#!/bin/bash

# Add symbolic links
ln -s /mnt/chromeos/removable/Pixel\ SD/NewMusic ~/Music
ln -s /mnt/chromeos/MyFiles/Downloads ~/Downloads
ln -s /mnt/chromeos/MyFiles/Documents ~/Documents
ln -s /mnt/chromeos/removable ~/Removable\ Devices
ln -s /mnt/chromeos/GoogleDrive/MyDrive ~/Google\ Drive

# Install base packages
sudo pacman -Syy git base-devel curl wget --needed --noconfirm

# Clone & install yay
git clone https://aur.archlinux.org/yay-bin.git ~/yay-bin
cd ~/yay-bin && makepkg -si --noconfirm && cd ~/ && rm -rf ~/yay-bin

# Setup Vim-Plug
yay -S vim llvm yarn nodejs --needed --noconfirm
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Copy vimrc, zshrc, bashrc, etc
cp Config\ Files/vimrc ~/.vimrc
cp Config\ Files/zshrc ~/.zshrc
cp Config\ Files/bashrc ~/.bashrc
cp Config\ Files/mygreeting ~/.mygreeting
cp Config\ Files/p10k.zsh ~/.p10k.zsh

# Copy desktop files and icons
mkdir -p ~/.local/share/applications
sudo cp Apps/Icons/*.png /usr/share/icons
cp -r Apps/Files/* ~/.local/share/applications

# Set up zsh and oh-my-zsh
yay -S zsh --needed --noconfirm
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# Fzf installation
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install typical packages
yay -S orchis-theme-git vimix-icon-theme lollypop android-tools gnirehtet shortwave gnome-sudoku gnome-nibbles extremetuxracer supertux supertuxkart gnome-chess gnuchess google-chrome firefox zsh neovim neofetch lolcat nemo nemo-preview seahorse wine gedit microsoft-edge-beta-bin xiaomitool-v2 gnome-boxes ttf-google-sans shortwave python-pip stremio discord vlc telegram-desktop slack-desktop steam pingus mgba-qt libreoffice zotero cura gimp blender kdenlive shortwave visual-studio-code-bin rstudio-desktop-bin gnome-tweaks lxappearance transmission-gtk shotcut valgrind gnome-shell gnome-control-center gnome-calculator gnome-terminal nautilus whatsapp-nativefier gnome-mines gnome-chess gnuchess cheese eog yarn python-pip dex gnome-maps gnome-photos totem gnome-calendar gnome-weather gnome-books gnome-clocks gnome-contacts xcursor-chromeos gtk-engine-murrine vim bat llvm gcc-fortran python-psycopg2 gdal texlive-core scrcpy sndcpy-bin --needed --noconfirm

# Install typical pip packages
sudo pip install -U youtube-dl suntime
sudo pip install https://codeload.github.com/spotDL/spotify-downloader/zip/master

# Configure default folders
echo "XDG_DESKTOP_DIR=\"$HOME/Desktop\"
XDG_DOCUMENTS_DIR=\"$HOME/Documents\"
XDG_DOWNLOAD_DIR=\"$HOME/Downloads\"
XDG_MUSIC_DIR=\"$HOME/Music\"
XDG_PICTURES_DIR=\"$HOME/Pictures\"
XDG_PUBLICSHARE_DIR=\"$HOME/Public\"
XDG_TEMPLATES_DIR=\"$HOME/Templates\"
XDG_VIDEOS_DIR=\"$HOME/Videos\"" > ~/.config/user-dirs.dirs

# Set xcursor-chromeos as default
mkdir -p ~/.icons/default
echo "[Icon Theme]
Inherits=xcursor-chromeos" > ~/.icons/default/index.theme
ln -s /usr/share/icons/xcursor-chromeos/cursors ~/.icons/default/cursors

# Setup systemd service to delete adwaita cursors
cp Extras/Del\ Adwaita/del-adwaita.service ~/.config/systemd/user
cp Extras/Del\ Adwaita/del-adwaita.timer ~/.config/systemd/user
systemctl --user enable del-adwaita.service
systemctl --user enable del-adwaita.timer
systemctl --user start del-adwaita.service
systemctl --user start del-adwaita.timer

# Configure git
sudo make -C /usr/share/git/credential/libsecret
git config --global credential.helper /usr/share/git/credential/libsecret/git-credential-libsecret
git config --global user.name "madebypixel02"
git config --global user.email "madebypixel02@gmail.com"
git config --global core.editor vim
git config pull.rebase false

# Create folders for systemd unit files
mkdir -p ~/.config/systemd/user/

# Copy unit files
yay -S python python-pip --needed --noconfirm
sudo pip install -U suntime
cp Extras/Auto\ Theme/Systemd/* ~/.config/systemd/user/
cp -r Extras/Auto\ Theme/.autotheme ~/
systemctl --user enable auto-theme.service
systemctl --user enable auto-theme.timer
systemctl --user start auto-theme.service
systemctl --user start auto-theme.timer

# Clone Useful Repos
git clone https://github.com/madebypixel02/Simple-Python-Time-Converter.git ~/Simple-Python-Time-Converter
git clone https://github.com/argrento/huami-token.git ~/huami-token

# Norminette
sudo pip install -U norminette

# 42 Header
mkdir -p ~/.vim/plugin/
cp 42\ Madrid/Header/stdheader.vim ~/.vim/plugin/

# Minilibx
git clone https://github.com/42Paris/minilibx-linux.git
cd minilibx-linux/
make
sudo cp mlx.h /usr/include
sudo cp libmlx.a /usr/lib
sudo cp man/man3/* /usr/share/man/man3/
sudo gzip /usr/share/man/man3/mlx.3
sudo gzip /usr/share/man/man3/mlx_new_image.3
sudo gzip /usr/share/man/man3/mlx_loop.3
sudo gzip /usr/share/man/man3/mlx_new_window.3
sudo gzip /usr/share/man/man3/mlx_pixel_put.3
cd ..
rm -rf minilibx-linux

# Clone 42 Madrid Projects
mkdir -p ~/42\ Madrid/GitHub/42\ Cursus
cd ~/42\ Madrid/GitHub/42\ Cursus
git clone https://github.com/madebypixel02/libft.git
git clone https://github.com/madebypixel02/ft_printf.git
cd ft_printf && ln -s ../libft libft && cd ..
git clone https://github.com/madebypixel02/get_next_line.git
git clone https://github.com/madebypixel02/born2beroot.git
git clone https://github.com/madebypixel02/so_long.git
cd so_long && ln -s ../libft libft && ln -s ../get_next_line get_next_line && cd ..
git clone https://github.com/madebypixel02/push_swap.git
cd push_swap && ln -s ../libft libft && cd ..
git clone https://github.com/madebypixel02/pipex.git

# Clone College Stuff
sudo pip install -U pyxel future
mkdir -p ~/College/Programming\ I
mkdir -p ~/College/Machine\ Learning\ I
cd ~/College/Programming\ I/ && git clone https://github.com/madebypixel02/Basic-OOP-Donkey-Kong-in-Python.git && cd ~/
cd ~/College/Machine\ Learning\ I/ && git clone https://github.com/madebypixel02/Machine-Learning-Pacman && cd ~/
