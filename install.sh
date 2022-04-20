#!/bin/bash

# Add symbolic links
mkdir -p ~/Documents
mkdir -p ~/Desktop
mkdir -p ~/Pictures
ln -s /mnt/chromeos/removable/Pixel\ SD/Useful\ Photos/ ~/Pictures
ln -s /mnt/chromeos/removable/Pixel\ SD/Public\ Transportation/ ~/Pictures
ln -s /mnt/chromeos/removable/Pixel\ SD/NewMusic ~/Music
ln -s /mnt/chromeos/removable/Pixel\ SD/Videos ~/Videos
ln -s /mnt/chromeos/MyFiles/Downloads ~/Downloads
ln -s /mnt/chromeos/MyFiles/Documents ~/Documents/Cros-Documents
ln -s /mnt/chromeos/removable ~/Removable\ Devices
ln -s ~/Removable\ Devices/Pixel\ SD/Linux\ Playlists ~/Playlists
ln -s /mnt/chromeos/GoogleDrive/MyDrive ~/Google\ Drive
cp -r ~/Google\ Drive/ReadEra/Books ~/Documents
cp -r ~/Arch-Crostini-Quick-Setup/Extras/Mi\ Band/ ~/Documents

# Install base packages
sudo pacman -Syu git base-devel curl wget --needed --noconfirm

# Clone & install yay
rm -rf /home/pixel/cros-container-guest-tools-git
git clone https://aur.archlinux.org/yay-bin.git ~/yay-bin
cd ~/yay-bin && makepkg -si --noconfirm && cd ..

# Setup Vim-Plug
yay -Rdd --noconfirm gvim
yay -S vim llvm yarn nodejs --needed --noconfirm
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Uniform QT / GTK look
echo "export QT_QPA_PLATFORMTHEME=gtk3" >> ~/.profile

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

# Copy vimrc, zshrc, bashrc, etc
cp ~/Arch-Crostini-Quick-Setup/Config\ Files/vimrc ~/.vimrc
cp ~/Arch-Crostini-Quick-Setup/Config\ Files/zshrc ~/.zshrc
cp ~/Arch-Crostini-Quick-Setup/Config\ Files/bashrc ~/.bashrc
cp ~/Arch-Crostini-Quick-Setup/Config\ Files/mygreeting ~/.mygreeting
cp ~/Arch-Crostini-Quick-Setup/Config\ Files/mygreeting_uc3m ~/.mygreeting_uc3m
cp ~/Arch-Crostini-Quick-Setup/Config\ Files/mygreeting42 ~/.mygreeting42
cp ~/Arch-Crostini-Quick-Setup/Config\ Files/p10k.zsh ~/.p10k.zsh

# Copy neovim config file
mkdir -p ~/.config
cp -r ~/Arch-Crostini-Quick-Setup/Extras/nvim ~/.config/

# Copy desktop files and icons
mkdir -p ~/.local/share/applications
sudo cp ~/Arch-Crostini-Quick-Setup/Apps/Icons/*.png /usr/share/icons
cp -r ~/Arch-Crostini-Quick-Setup/Apps/Files/* ~/.local/share/applications

# Set up zsh and oh-my-zsh
yay -S zsh python python-pip --needed --noconfirm
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
mv -f ~/.zshrc.pre-oh-my-zsh ~/.zshrc

# Fzf installation
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install vulkan stuff
yay -S mesa-git lib32-mesa-git vulkan-tools libshumate-git --needed
echo "VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/virtio_icd.i686.json:/usr/share/vulkan/icd.d/virtio_icd.x86_64.json" | sudo tee -a /etc/environment

# Install typical packages
sudo pip uninstall numpy beautifulsoup4 soupsieve
yay -S adw-gtk3 orchis-theme-git vimix-icon-theme lollypop android-tools gnirehtet gnome-sudoku gnome-nibbles extremetuxracer supertux supertuxkart gnome-chess gnuchess google-chrome firefox zsh neovim neofetch lolcat nemo nemo-preview wine gedit microsoft-edge-stable-bin xiaomitool-v2 gnome-boxes ttf-google-sans python-pip stremio vlc steam pingus mgba-qt libreoffice zotero-bin cura gimp blender kdenlive visual-studio-code-bin rstudio-desktop-bin gnome-tweaks lxappearance transmission-gtk shotcut valgrind gnome-shell gnome-control-center gnome-calculator gnome-terminal nautilus whatsapp-nativefier gnome-mines gnome-chess gnuchess cheese eog yarn python-pip dex gnome-maps gnome-photos totem gnome-calendar gnome-weather gnome-books gnome-clocks gnome-contacts xcursor-chromeos gtk-engine-murrine vim bat llvm gcc-fortran python-psycopg2 gdal texlive-core scrcpy sndcpy-bin ttf-cascadia-code xournalpp mplayer kid3-qt tree libbsd jre-openjdk docker gnome-sound-recorder gnome-music gnome-system-monitor gnome-2048 ttf-symbola fcron samba nano sysbench geekbench ascii-image-converter btop noto-fonts gnome-keyring libgnome-keyring quickgui-bin quickemu gnome-podcasts svp cmatrix wine-mono wine-gecko winetricks brave-bin xorg-xhost qt5-styleplugins foliate seahorse nemo-fileroller mesa-utils lib32-mesa-utils wireshark-qt sl gnome-console browsh-bin elinks tabby-terminal cowsay nginx mariadb virt-manager --needed --noconfirm
sudo systemctl enable --now libvirtd
sudo usermod -aG wireshark pixel
sudo chmod +x /usr/bin/dumpcap
sudo usermod -aG libvirt pixel
echo "remember_owner = 0 " | sudo tee -a /etc/libvirt/qemu.conf
xhost +si:localuser:root && sudo SVPManager

# Set Up mpv
yay -S qt5-base qt5-declarative qt5-svg libmediainfo lsof vapoursynth rsound spirv-cross mpv-full mkvtoolnix-cli avahi
sudo systemctl enable --now avahi-daemon.service
mkdir -p ~/Pictures
mkdir -p ~/.config/mpv
echo "vo=gpu
ao=alsa" > ~/.config/mpv/mpv.conf

# Build shortwave
git clone https://gitlab.gnome.org/World/Shortwave.git
cd Shortwave
meson --prefix=/usr build
ninja -C build
sudo ninja -C build install

# Install focalboard-server
wget https://github.com/mattermost/focalboard/releases/download/v0.15.0/focalboard-server-linux-amd64.tar.gz
tar -xvzf focalboard-server-linux-amd64.tar.gz
sudo mv focalboard /opt
mkdir -p ~/.config/systemd/user
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable --now mariadb
sudo systemctl enable --now nginx
sudo mkdir /etc/nginx/sites-available/
sudo mkdir /etc/nginx/sites-enabled/
sudo cp ~/Arch-Crostini-Quick-Setup/Extras/Focalboard/focalboard /etc/nginx/sites-available
sudo cp ~/Arch-Crostini-Quick-Setup/Extras/Focalboard/config.json /opt/focalboard
sudo cp ~/Arch-Crostini-Quick-Setup/Extras/Focalboard/focalboard.service /lib/systemd/system/
sudo ln -s /etc/nginx/sites-available/focalboard /etc/nginx/sites-enabled/focalboard
sudo nginx -t
sudo systemctl enable --now focalboard.service

# Configure fcron
sudo systemctl enable --now fcron
sudo mkdir -p /var/spool/fcron
sudo cp ~/Arch-Crostini-Quick-Setup/Extras/Crontab/root /var/spool/fcron
sudo chown root:root /var/spool/fcron/root
sudo cp ~/Arch-Crostini-Quick-Setup/Extras/Crontab/root.orig /var/spool/fcron
sudo chown root:root /var/spool/fcron/root.orig

# Copy gnome podcasts backup
cp ~/Arch-Crostini-Quick-Setup/Extras/gnome-podcasts-exported-shows.opml /home/pixel

# Install typical pip packages
sudo pip install -U youtube-dl suntime
sudo pip install https://codeload.github.com/spotDL/spotify-downloader/zip/master

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

# Set xcursor-chromeos as default
mkdir -p ~/.icons/default
echo "[Icon Theme]
Inherits=xcursor-chromeos" > ~/.icons/default/index.theme
ln -s /usr/share/icons/xcursor-chromeos/cursors ~/.icons/default/cursors

# Configure git
sudo make -C /usr/share/git/credential/libsecret
git config --global credential.helper /usr/share/git/credential/libsecret/git-credential-libsecret
git config --global user.name "madebypixel02"
git config --global user.email "madebypixel02@gmail.com"
git config --global core.editor nvim
git config --global pull.rebase false
git config --global init.defaultBranch main

# Create folders for systemd unit files
mkdir -p ~/.config/systemd/user/

# Copy unit files
sudo pip install -U suntime
mkdir -p /home/pixel/.config/systemd/user/sommelier-x@0.service.d/
cp ~/Arch-Crostini-Quick-Setup/Extras/Auto\ Theme/Systemd/* ~/.config/systemd/user/
cp -r ~/Arch-Crostini-Quick-Setup/Extras/Auto\ Theme/.autotheme ~/
systemctl --user enable --now auto-theme.service
systemctl --user enable --now auto-theme.timer

# Clone Useful Repos
git clone https://github.com/madebypixel02/Simple-Python-Time-Converter.git ~/Simple-Python-Time-Converter
git clone https://github.com/argrento/huami-token.git ~/huami-token

# Norminette
sudo pip install -U norminette

# 42 Header
mkdir -p ~/.vim/plugin/
cp ~/Arch-Crostini-Quick-Setup/42\ Madrid/Header/stdheader.vim ~/.vim/plugin/
cp ~/Arch-Crostini-Quick-Setup/Extras/customheader.vim ~/.vim/plugin/

# Minilibx
git clone https://github.com/42Paris/minilibx-linux.git
cd minilibx-linux/
make
sudo cp mlx.h /usr/include
sudo cp libmlx.a /usr/lib
sudo cp man/man3/* /usr/share/man/man3/
#sudo gzip /usr/share/man/man3/mlx.3
#sudo gzip /usr/share/man/man3/mlx_new_image.3
#sudo gzip /usr/share/man/man3/mlx_loop.3
#sudo gzip /usr/share/man/man3/mlx_new_window.3
#sudo gzip /usr/share/man/man3/mlx_pixel_put.3
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
git clone https://github.com/madebypixel02/philosophers.git
git clone https://github.com/madebypixel02/minishell.git
cd minishell && ln -s ../libft libft && cd ..
git clone https://github.com/madebypixel02/cub3d.git
cd cub3d && ln -s ../libft libft && cd ..
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

# Install minishell
make -C ~/42\ Madrid/GitHub/42\ Cursus/minishell
cd /bin && sudo ln -s ~/42\ Madrid/GitHub/42\ Cursus/minishell/bin/minishell . && cd ~/Arch-Crostini-Quick-Setup

# Clone College Stuff
sudo pip install -U pyxel future
mkdir -p ~/College/Programming\ I
mkdir -p ~/College/Machine\ Learning\ I
mkdir -p ~/College/Statistical\ Learning
cd ~/College/Programming\ I/ && git clone https://github.com/madebypixel02/Basic-OOP-Donkey-Kong-in-Python.git && cd ~/
cd ~/College/Machine\ Learning\ I/ && git clone https://github.com/madebypixel02/Machine-Learning-Pacman && cd ~/
cd ~/College/Statistical\ Learning/ && git clone https://github.com/madebypixel02/Statistial-Learning-Practices-2021.git && cd ~/
cd ~/College && git clone https://github.com/madebypixel02/Uc3m-Projects && cd ~/
cd ~/College && git clone https://github.com/madebypixel02/Openssl-Practices-2022 && cd ~/
