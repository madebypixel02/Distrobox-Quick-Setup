#!/bin/bash

# Install locale tools
sudo apt -y install locales

# Set locale
[ "en_US.UTF-8 UTF-8" != "$(head -n 1 /etc/locale.gen)" ] && echo "en_US.UTF-8 UTF-8
es_ES.UTF-8 UTF-8" | sudo tee /etc/locale.gen && echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf && sudo locale-gen

# Install base packages
sudo apt install -y git base zsh curl wget vim neovim python3 python3-pip build-essential ninja-build meson

# install aptitude
sudo apt install aptitude -y

# Uniform QT / GTK look
grep 'QT_QPA_PLATFORMTHEME=\"qt5ct\"' /etc/environment 1>/dev/null; [ "$?" -eq 1 ] && echo "QT_QPA_PLATFORMTHEME=\"qt5ct\"" | sudo tee -a /etc/environment 1>/dev/null

# Install typical packages
sudo dpkg --add-architecture i386
sudo add-apt-repository non-free
sudo apt update
sudo apt install -y apt-utils apt-transport-https software-properties-common
sudo aptitude install -y gdebi adb fastboot pciutils libreadline-dev libsdl2-image-dev libsdl2-dev npm nodejs mesa-utils libglib2.0-dev libsquashfuse0 squashfuse fuse zsh neovim neofetch lolcat nemo wine gedit python3-pip gnome-tweaks lxappearance valgrind gnome-shell yarn dex gtk2-engines-murrine vim bat llvm fortran-compiler texlive-base scrcpy tree libbsd-dev default-jre fonts-symbola fonts-dejavu fonts-noto fonts-noto-cjk-extra fonts-noto-color-emoji samba nano sysbench asciiart gnome-keyring libsecret-1-0 libsecret-1-dev gnome-session mesa-vulkan-drivers vulkan-tools sl elinks cowsay dnsmasq cmus pandoc rustc sqlite3 libsqlite3-dev libgdk-pixbuf2.0-dev xinput qt5ct adwaita-qt tldr libgtk2.0-dev

# Configure gnome terminal shortcuts
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Primary>Tab'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Primary><Shift>Tab'

# Configure git credential manager
sudo make -C /usr/share/doc/git/contrib/credential/libsecret/
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

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
