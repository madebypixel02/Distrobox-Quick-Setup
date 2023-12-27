#!/bin/bash

# Enable some extra repos
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf group install -y core

# Install base packages
sudo dnf install -y git curl wget neofetch python python-pip vim neovim zsh dnf-plugins-core sqlite
sudo dnf group install -y "C Development Tools and Libraries" "Development Tools"

# Uniform QT / GTK look
grep 'QT_QPA_PLATFORMTHEME=\"qt5ct\"' /etc/environment 1>/dev/null; [ "$?" -eq 1 ] && echo "QT_QPA_PLATFORMTHEME=\"qt5ct\"" | sudo tee -a /etc/environment 1>/dev/null

# Copy dnf.conf
sudo cp $HOME/Distrobox-Quick-Setup/Config\ Files/dnf.conf /etc/dnf/dnf.conf

# Install typical packages
sudo dnf install -y android-tools neofetch lolcat gnome-tweaks lxappearance valgrind gnome-shell gnome-terminal npm vim bat llvm gdal texlive-scheme-basic tree libbsd java-latest-openjdk google-android-emoji-fonts google-noto-sans-fonts google-noto-sans-mono-fonts gstreamer-plugins-espeak gstreamer1-libav gstreamer1-plugin-openh264 gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly htop joystick joystick-support langpacks-core-en langpacks-core-es langpacks-en langpacks-es libva-intel-driver lm_sensors samba sysbench gnome-keyring libgnome-keyring cmatrix xhost wine sl elinks cowsay nginx mariadb dnsmasq pandoc vulkan-loader vulkan-tools python-numpy tk xinput mpv libXext-devel libX11-devel libbsd-devel git-credential-libsecret readline readline-devel google-noto-cjk-fonts google-noto-cjk-fonts-common qt5ct adwaita-qt5 adwaita-qt6 tldr nodejs

# Install yarn
sudo npm install yarn -g

# Configure gnome terminal shortcuts
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Primary>Tab'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Primary><Shift>Tab'

# Configure git credential manager
git config --global credential.helper libsecret

# Start Auto-Theme
#systemctl --user enable --now auto-theme.service
#systemctl --user enable --now auto-theme.timer

# Minilibx
git clone https://github.com/42Paris/minilibx-linux.git
cd minilibx-linux/
make
sudo cp mlx.h /usr/include
sudo cp libmlx.a /usr/lib
sudo cp man/man3/* /usr/share/man/man3/
cd ..
rm -rf minilibx-linux

# Install minishell
make -C $HOME/42\ Madrid/Git/42\ Cursus/minishell
[ ! -L /bin/minishell ] && cd /bin && sudo ln -s $HOME/42\ Madrid/Git/42\ Cursus/minishell/bin/minishell . && cd $HOME/Distrobox-Quick-Setup
