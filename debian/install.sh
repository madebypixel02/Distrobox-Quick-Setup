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
sudo pip3 install -U youtube-dl suntime norminette future pyxel==1.7.2 pywal
sudo pip3 install https://codeload.github.com/spotDL/spotify-downloader/zip/master
sudo dpkg --add-architecture i386
sudo add-apt-repository non-free
sudo apt update
sudo apt install -y apt-utils apt-transport-https software-properties-common
sudo aptitude install -y gdebi adb fastboot pciutils libreadline-dev libsdl2-image-dev libsdl2-dev npm nodejs mesa-utils libglib2.0-dev libsquashfuse0 squashfuse fuse snapd zsh neovim neofetch lolcat nemo wine gedit python3-pip r-base r-base-dev libnss3 gnome-tweaks lxappearance valgrind gnome-shell yarn dex gtk2-engines-murrine vim bat llvm fortran-compiler python3-psycopg2 gdal-bin texlive-base scrcpy kid3-qt tree libbsd-dev default-jre docker fonts-symbola fonts-dejavu fonts-noto fonts-noto-cjk-extra fonts-noto-color-emoji samba nano sysbench asciiart gnome-keyring libsecret-1-0 libsecret-1-dev gnome-session mesa-vulkan-drivers vulkan-tools sl elinks cowsay dnsmasq cmus pandoc rustc sqlite3 libsqlite3-dev libgdk-pixbuf2.0-dev xinput qt5-style-plugins qt5ct adwaita-qt tldr

# Configure Packages
#JAVA_HOME=/usr/lib/jvm/default-java sudo pip3 install -r $HOME/Uc3m/Machine\ Learning\ I/Machine-Learning-Pacman/requirements.txt
#sudo systemctl enable --now libvirtd
sudo usermod -aG wireshark $USER
sudo chmod +x /usr/bin/dumpcap
sudo usermod -aG libvirt $USER
[ ! "grep \"remember_owner = 0\" /etc/libvirt/qemu.conf" ] && echo "remember_owner = 0 " | sudo tee -a /etc/libvirt/qemu.conf

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
#sudo apt -y install make gcc g++ autoconf libc6 libpcre3 flex bison libgmp-dev libssl-dev libglib2.0-dev help2man
#
## pbc
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
