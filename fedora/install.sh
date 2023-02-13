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

# Load copr repos
sudo dnf copr enable -y zawertun/vapoursynth

# Install typical packages
sudo pip install -U youtube-dl suntime norminette future pyxel==1.7.2 pywal
sudo pip install https://codeload.github.com/spotDL/spotify-downloader/zip/master
sudo dnf install -y android-tools neofetch lolcat gnome-tweaks lxappearance valgrind gnome-shell gnome-terminal npm dex vim bat llvm gdal texlive-scheme-basic tree libbsd java-latest-openjdk docker cronie fedora-packager fedora-review google-android-emoji-fonts google-noto-sans-fonts google-noto-sans-mono-fonts gstreamer-plugins-espeak gstreamer1-libav gstreamer1-plugin-openh264 gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly htop joystick joystick-support langpacks-core-en langpacks-core-es langpacks-en langpacks-es libva-intel-driver lm_sensors samba sysbench gnome-keyring libgnome-keyring cmatrix xhost wine sl elinks cowsay nginx mariadb dnsmasq cmus pandoc vulkan-loader vulkan-tools python-numpy tk xinput mpv libXext-devel libbsd-devel git-credential-libsecret readline readline-devel google-noto-cjk-fonts google-noto-cjk-fonts-common qt5ct adwaita-qt5 adwaita-qt6 tldr

# Configure Packages
#JAVA_HOME=/usr/lib/jvm/default sudo pip install -r $HOME/Uc3m/Machine\ Learning\ I/Machine-Learning-Pacman/requirements.txt
sudo usermod -aG dnsmasq $USER
#sudo systemctl enable --now libvirtd
sudo usermod -aG wireshark $USER
sudo chmod +x /usr/bin/dumpcap
sudo usermod -aG libvirt $USER
[ ! "grep \"remember_owner = 0\" /etc/libvirt/qemu.conf" ] && echo "remember_owner = 0 " | sudo tee -a /etc/libvirt/qemu.conf

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
#sudo gzip /usr/share/man/man3/mlx.3
#sudo gzip /usr/share/man/man3/mlx_new_image.3
#sudo gzip /usr/share/man/man3/mlx_loop.3
#sudo gzip /usr/share/man/man3/mlx_new_window.3
#sudo gzip /usr/share/man/man3/mlx_pixel_put.3
cd ..
rm -rf minilibx-linux

# Install minishell
make -C $HOME/42\ Madrid/GitHub/42\ Cursus/minishell
[ ! -L /bin/minishell ] && cd /bin && sudo ln -s $HOME/42\ Madrid/GitHub/42\ Cursus/minishell/bin/minishell . && cd $HOME/Distrobox-Quick-Setup
