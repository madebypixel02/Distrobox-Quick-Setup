#!/bin/bash

HOME=$(echo ~)

# Enable some extra repos
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf group install -y core

# Install base packages
sudo dnf install -y git curl wget neofetch python python-pip vim neovim zsh dnf-plugins-core
sudo dnf group install -y "C Development Tools and Libraries" "Development Tools"

# Uniform QT / GTK look
echo "export QT_QPA_PLATFORMTHEME=gtk3" >> $HOME/.profile

# Copy desktop files and icons
cp $HOME/Distrobox-Quick-Setup/Apps/Icons/*.png $HOME/.local/share/icons
#cp -r $HOME/Distrobox-Quick-Setup/Apps/Files/* $HOME/.local/share/applications

# Load copr repos
sudo dnf copr enable -y zawertun/vapoursynth

# Install typical packages
sudo pip install -U youtube-dl suntime norminette future
sudo pip install https://codeload.github.com/spotDL/spotify-downloader/zip/master
sudo dnf install -y lollypop android-tools neofetch lolcat nemo nemo-preview gnome-boxes vlc gnome-tweaks lxappearance valgrind gnome-shell gnome-control-center gnome-terminal nautilus eog npm dex vim bat llvm gdal texlive-scheme-full tree libbsd java-latest-openjdk docker gnome-system-monitor cronie distrobox fedora-packager fedora-review gnome-console gnome-tweaks google-android-emoji-fonts google-noto-sans-fonts google-noto-sans-mono-fonts gstreamer-plugins-espeak gstreamer1-libav gstreamer1-plugin-openh264 gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly htop joystick joystick-support langpacks-core-en langpacks-core-es langpacks-en langpacks-es libva-intel-driver lm_sensors samba nano sysbench gnome-keyring libgnome-keyring cmatrix xhost seahorse nemo-fileroller wine sl gnome-console elinks cowsay nginx mariadb virt-manager dnsmasq cmus pandoc epiphany vulkan-loader vulkan-tools python-numpy tk xinput mpv libXext-devel libbsd-devel git-credential-libsecret

# Configure Packages
JAVA_HOME=/usr/lib/jvm/default sudo pip install -r $HOME/College/Machine\ Learning\ I/Machine-Learning-Pacman/requirements.txt
sudo usermod -aG dnsmasq $USER
#sudo systemctl enable --now libvirtd
sudo usermod -aG wireshark $USER
sudo chmod +x /usr/bin/dumpcap
sudo usermod -aG libvirt $USER
echo "remember_owner = 0 " | sudo tee -a /etc/libvirt/qemu.conf
wget https://www.svp-team.com/files/svp4-latest.php?linux -O svp.tar.bz2
tar -xvf svp.tar.bz2
./$(find . -name svp4-linux-64.run)
rm -rf svp.tar.bz2 svp
find . -name svp4-linux-64.run -delete
xhost +si:localuser:root && sudo $HOME/SVP\ 4/SVPManager

# Install yarn
sudo npm install yarn -g

# Set up gnirehtet
wget https://github.com/Genymobile/gnirehtet/releases/download/v2.5/gnirehtet-rust-linux64-v2.5.zip
unzip gnirehtet-* -d $HOME
sudo ln -s $HOME/gnirehtet-rust-linux64/gnirehtet /bin
rm -f gnirehtet-rust-linux64-v2.5.zip

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
#sudo gzip /usr/share/man/man3/mlx.3
#sudo gzip /usr/share/man/man3/mlx_new_image.3
#sudo gzip /usr/share/man/man3/mlx_loop.3
#sudo gzip /usr/share/man/man3/mlx_new_window.3
#sudo gzip /usr/share/man/man3/mlx_pixel_put.3
cd ..
rm -rf minilibx-linux

# Install minishell
make -C $HOME/42\ Madrid/GitHub/42\ Cursus/minishell
cd /bin && sudo ln -s $HOME/42\ Madrid/GitHub/42\ Cursus/minishell/bin/minishell . && cd $HOME/Distrobox-Quick-Setup
