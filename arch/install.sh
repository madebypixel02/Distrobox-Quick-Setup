#!/bin/bash

# Set locale
[ "en_US.UTF-8 UTF-8" != "$(head -n 1 /etc/locale.gen)" ] && echo "en_US.UTF-8 UTF-8
es_ES.UTF-8 UTF-8" | sudo tee /etc/locale.gen && echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf && sudo locale-gen

# Copy pacman.conf
sudo cp $HOME/Distrobox-Quick-Setup/Config\ Files/pacman.conf /etc/

# Install base packages
sudo pacman -Syu git base-devel zsh curl wget python python-pip vim neovim man-pages man-db --needed --noconfirm

# Install yay
git clone https://aur.archlinux.org/yay-bin.git $HOME/yay-bin
cd $HOME/yay-bin && makepkg -si --noconfirm && cd ..
rm -rf $HOME/yay-bin

# Uniform QT / GTK look
grep 'QT_QPA_PLATFORMTHEME=\"qt5ct\"' /etc/environment 1>/dev/null; [ "$?" -eq 1 ] && echo "QT_QPA_PLATFORMTHEME=\"qt5ct\"" | sudo tee -a /etc/environment 1>/dev/null

# Install typical packages
yay -S python-pyparsing python-six python-packaging python-pydantic python-typing_extensions python-pygments --needed --noconfirm
yay -S nodejs-lts-gallium --needed --noconfirm
yay -S android-tools gnirehtet zsh neofetch lolcat xiaomitool-v2 noto-fonts-cjk noto-fonts-extra ttf-dejavu gnome-tweaks lxappearance valgrind gnome-shell yarn dex gtk-engine-murrine bat llvm gcc-fortran python-psycopg2 gdal texlive-core scrcpy sndcpy-bin tree libbsd jre-openjdk docker samba nano sysbench geekbench ascii-image-converter btop noto-fonts gnome-keyring libgnome-keyring svp-bin cmatrix xorg-xhost adwaita-qt5 adwaita-qt6 mesa-utils sl browsh-bin elinks cowsay nginx mariadb dnsmasq cmus pandoc xf86-video-intel vulkan-intel vulkan-tools lib32-vulkan-intel python-numpy tk xorg-xinput asciiquarium wine winetricks vlc qt5ct wireshark-qt python-pywal epiphany qt5ct adwaita-qt5 adwaita-qt6 autofirma-bin libpkcs11-dnie mpv-full noto-fonts noto-fonts-emoji ttf-linux-libertine ttf-dejavu noto-fonts-cjk --needed --noconfirm
sudo pip install -U youtube-dl suntime norminette future pyxel==1.7.2
sudo pip install https://codeload.github.com/spotDL/spotify-downloader/zip/master
sudo pip uninstall -y numpy beautifulsoup4 soupsieve

# Configure Packages
#JAVA_HOME=/usr/lib/jvm/default sudo pip install -r $HOME/Uc3m/Machine\ Learning\ I/Machine-Learning-Pacman/requirements.txt
sudo usermod -aG dnsmasq $USER
sudo systemctl enable --now libvirtd
sudo usermod -aG wireshark $USER
sudo chmod +x /usr/bin/dumpcap
sudo usermod -aG libvirt $USER
[ ! "grep \"remember_owner = 0\" /etc/libvirt/qemu.conf" ] && echo "remember_owner = 0 " | sudo tee -a /etc/libvirt/qemu.conf
sudo chmod a+w /usr/lib/vlc/plugins/video_filter/
sudo chmod a+w /usr/lib/vlc/plugins/video_filter/*

# Configure gnome terminal shortcuts
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Primary>Tab'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Primary><Shift>Tab'

# Configure git credential manager
sudo make -C /usr/share/git/credential/libsecret
git config --global credential.helper /usr/share/git/credential/libsecret/git-credential-libsecret

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

# Install Uc3m ABE-Scalability Dependencies

# pbc
#wget https://crypto.stanford.edu/pbc/files/pbc-0.5.14.tar.gz
#tar zxvf pbc-0.5.14.tar.gz; cd pbc-0.5.14
#autoconf
#./configure
#make
#sudo make install
#cd ..
#
## libbswabe
#wget http://acsc.cs.utexas.edu/cpabe/libbswabe-0.9.tar.gz
#tar zxvf libbswabe-0.9.tar.gz; cd libbswabe-0.9
#./configure
#make
#sudo make install
#cd ..
#
## cpabe
#wget http://acsc.cs.utexas.edu/cpabe/cpabe-0.11.tar.gz
#tar zxvf cpabe-0.11.tar.gz; cd cpabe-0.11
#./configure --with-pbc-include=/usr/local/include/pbc --with-pbc-lib=/usr/local/lib
#sed -e '67 s/\$1/\$1;/' policy_lang.y > temp
#mv temp policy_lang.y
#sed -e '89 s/help2man/help2man --no-discard-stderr/' Makefile > temp
#mv temp Makefile
#make LDFLAGS="-lgmp -lpbc -lcrypto -L/usr/lib/x86_64-linux-gnu -lglib-2.0 -lbswabe -lgmp"
#sudo make LDFLAGS="-lgmp -lpbc -lcrypto -L/usr/lib/x86_64-linux-gnu -lglib-2.0 -lbswabe -lgmp" install
#cd ..
#
## Cleanup
#rm -rf cpabe-* libbswabe-* pbc-*
