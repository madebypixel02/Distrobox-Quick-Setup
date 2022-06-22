#!/bin/bash

USER=$(whoami)

# Enable some extra repos
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf group install -y core

# Install base packages
sudo dnf install -y git curl wget neofetch python python-pip vim neovim zsh dnf-plugins-core

# Setup Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Uniform QT / GTK look
echo "export QT_QPA_PLATFORMTHEME=gtk3" >> ~/.profile

# Copy desktop files and icons
cp ~/Distrobox-Quick-Setup/Apps/Icons/*.png /home/$USER/.local/share/icons
#cp -r ~/Distrobox-Quick-Setup/Apps/Files/* ~/.local/share/applications

# Set up zsh and oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
mv -f ~/.zshrc.pre-oh-my-zsh ~/.zshrc

# Load copr repos
sudo dnf copr enable -y zawertun/vapoursynth

# Install typical packages
sudo pip install -U youtube-dl suntime norminette future
sudo pip install https://codeload.github.com/spotDL/spotify-downloader/zip/master
sudo dnf install -y lollypop android-tools neofetch lolcat nemo nemo-preview gnome-boxes vlc gnome-tweaks lxappearance valgrind gnome-shell gnome-control-center gnome-terminal nautilus eog npm dex vim bat llvm gdal texlive-scheme-full tree libbsd java-latest-openjdk docker gnome-system-monitor cronie distrobox fedora-packager fedora-review gnome-console gnome-tweaks google-android-emoji-fonts google-noto-sans-fonts google-noto-sans-mono-fonts gstreamer-plugins-espeak gstreamer1-libav gstreamer1-plugin-openh264 gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly htop joystick joystick-support langpacks-core-en langpacks-core-es langpacks-en langpacks-es libva-intel-driver lm_sensors samba nano sysbench gnome-keyring libgnome-keyring cmatrix xhost seahorse nemo-fileroller wine sl gnome-console elinks cowsay nginx mariadb virt-manager dnsmasq cmus pandoc epiphany vulkan-loader vulkan-tools python-numpy tk xinput mpv

# Configure Packages
JAVA_HOME=/usr/lib/jvm/default sudo pip install -r ~/College/Machine\ Learning\ I/Machine-Learning-Pacman/requirements.txt
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
xhost +si:localuser:root && sudo /home/$USER/SVP\ 4/SVPManager

# Install yarn
sudo npm install yarn -g

# Set up gnirehtet
wget https://github.com/Genymobile/gnirehtet/releases/download/v2.5/gnirehtet-rust-linux64-v2.5.zip
unzip gnirehtet-* -d /home/$USER
sudo ln -s /home/$USER/gnirehtet-rust-linux64/gnirehtet /bin
rm -f gnirehtet-rust-linux64-v2.5.zip

# Configure gnome terminal shortcuts
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Primary>Tab'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Primary><Shift>Tab'

# Configure git
sudo make -C /usr/share/git/credential/libsecret
git config --global credential.helper /usr/share/git/credential/libsecret/git-credential-libsecret
git config --global user.name "madebypixel02"
git config --global user.email "madebypixel02@proton.me"
git config --global core.editor nvim
git config --global pull.rebase false
git config --global init.defaultBranch main

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
make -C ~/42\ Madrid/GitHub/42\ Cursus/minishell
cd /bin && sudo ln -s ~/42\ Madrid/GitHub/42\ Cursus/minishell/bin/minishell . && cd ~/Distrobox-Quick-Setup
