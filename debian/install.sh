#!/bin/bash

HOME=$(echo ~)

# Set locale
echo "en_US.UTF-8 UTF-8
es_ES.UTF-8 UTF-8" | sudo tee /etc/locale.gen
echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf
sudo locale-gen

# Install base packages
sudo apt install -y git base zsh curl wget vim neovim python3 python3-pip build-essential ninja-build meson

# install aptitude
sudo apt install aptitude -y

# Uniform QT / GTK look
echo "export QT_QPA_PLATFORMTHEME=gtk3" >> $HOME/.profile

# Copy desktop files
cp -r $HOME/Distrobox-Quick-Setup/debian/Apps/* $HOME/.local/share/applications

# Install typical packages
sudo pip3 install -U youtube-dl suntime norminette future
sudo pip install https://codeload.github.com/spotDL/spotify-downloader/zip/master
sudo dpkg --add-architecture i386
sudo add-apt-repository non-free
wget -qO- https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update
sudo apt install -y apt-utils apt-transport-https software-properties-common
sudo aptitude install -y gdebi adb fastboot pciutils libreadline-dev libsdl2-image-dev libsdl2-dev npm nodejs mesa-utils libglib2.0-dev libsquashfuse0 squashfuse fuse snapd zsh neovim neofetch lolcat nemo wine gedit python3-pip r-base r-base-dev libnss3 gnome-tweaks lxappearance valgrind gnome-shell yarn dex gtk2-engines-murrine vim bat llvm fortran-compiler python3-psycopg2 gdal-bin texlive-base scrcpy kid3-qt tree libbsd-dev default-jre docker fonts-symbola samba nano sysbench asciiart gnome-keyring libsecret-1-0 libsecret-1-dev gnome-session mesa-vulkan-drivers vulkan-tools sl elinks cowsay dnsmasq cmus pandoc rustc sqlite3 libsqlite3-dev libgdk-pixbuf2.0-dev xinput qt5-style-plugins

# Configure Packages
JAVA_HOME=/usr/lib/jvm/default-java sudo pip install -r $HOME/College/Machine\ Learning\ I/Machine-Learning-Pacman/requirements.txt
#sudo systemctl enable --now libvirtd
sudo usermod -aG wireshark $USER
sudo chmod +x /usr/bin/dumpcap
sudo usermod -aG libvirt $USER
echo "remember_owner = 0 " | sudo tee -a /etc/libvirt/qemu.conf

# Build foliate
#sudo apt install -y appstream build-essential debhelper meson gettext webkit2gtk-driver
#git clone https://github.com/johnfactotum/foliate.git
#cd foliate
#meson build --prefix=/usr
#ninja -C build
#sudo ninja -C build install
#dpkg-buildpackage -us -uc -nc

# Set up gnirehtet
[ ! -L /bin/gnirehtet ] && wget https://github.com/Genymobile/gnirehtet/releases/download/v2.5/gnirehtet-rust-linux64-v2.5.zip && \
	unzip gnirehtet-* -d $HOME && sudo ln -s $HOME/gnirehtet-rust-linux64/gnirehtet /bin
rm -f gnirehtet-rust-linux64-v2.5.zip

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

# Install College Stuff Dependencies
sudo apt -y install make gcc g++ autoconf libc6 libpcre3 flex bison libgmp-dev libssl-dev libglib2.0-dev help2man

# pbc
wget https://crypto.stanford.edu/pbc/files/pbc-0.5.14.tar.gz
tar zxvf pbc-0.5.14.tar.gz; cd pbc-0.5.14
autoconf
./configure
make
sudo make install
cd ..

# libbswabe
wget http://acsc.cs.utexas.edu/cpabe/libbswabe-0.9.tar.gz
tar zxvf libbswabe-0.9.tar.gz; cd libbswabe-0.9
./configure
make
sudo make install
cd ..

# cpabe
wget http://acsc.cs.utexas.edu/cpabe/cpabe-0.11.tar.gz
tar zxvf cpabe-0.11.tar.gz; cd cpabe-0.11
./configure --with-pbc-include=/usr/local/include/pbc --with-pbc-lib=/usr/local/lib
sed -e '67 s/\$1/\$1;/' policy_lang.y > temp
mv temp policy_lang.y
sed -e '89 s/help2man/help2man --no-discard-stderr/' Makefile > temp
mv temp Makefile
make LDFLAGS="-lgmp -lpbc -lcrypto -L/usr/lib/x86_64-linux-gnu -lglib-2.0 -lbswabe -lgmp"
sudo make LDFLAGS="-lgmp -lpbc -lcrypto -L/usr/lib/x86_64-linux-gnu -lglib-2.0 -lbswabe -lgmp" install
cd ..
