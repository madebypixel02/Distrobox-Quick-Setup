# **************************************************************************** #
#                                                                              #
#                                                           _nnnn_             #
#                                                          dGGGGMMb            #
#                                                         @p~qp~~qMb           #
#                                                         M|@||@) M|           #
#                                                         @,----.JM|           #
#                                                        JS^\__/  qKL          #
#                                                       dZP        qKRb        #
#                                                      dZP          qKKb       #
#                                                     fZP            SMMb      #
#                                                     HZM            MMMM      #
#    install.sh                                       FqM            MMMM      #
#                                                   __| `.        |\dS'qML     #
#    By: madebypixel02 <madebypixel02@proton.me>    |    `.       | `' \Zq     #
#                                                   _)      .___.,|     .'     #
#    Created: 2022/06/25 20:29:15 by madebypixel02  \___   )MMMMMP|   .'       #
#    Updated: 2022/06/25 20:29:19 by madebypixel02      `-'       `--'         #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

HOME=$(echo ~)

# Set locale
echo "en_US.UTF-8 UTF-8
es_ES.UTF-8 UTF-8" | sudo tee /etc/locale.gen
echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf
sudo locale-gen

# Copy pacman.conf
sudo cp $HOME/Distrobox-Quick-Setup/Config\ Files/pacman.conf /etc/

# Install base packages
sudo pacman -Syu git base-devel zsh curl wget python python-pip vim neovim man-pages man-db --needed --noconfirm

# Install yay
git clone https://aur.archlinux.org/yay-bin.git $HOME/yay-bin
cd $HOME/yay-bin && makepkg -si --noconfirm && cd ..

# Uniform QT / GTK look
echo "export QT_QPA_PLATFORMTHEME=\"qt5ct\"" >> $HOME/.profile
echo "export QT_QPA_PLATFORMTHEME=\"qt5ct\"" | sudo tee -a /etc/profile

# Copy desktop files
cp -r $HOME/Distrobox-Quick-Setup/arch/Apps/* $HOME/.local/share/applications

# Install typical packages
sudo pip install -U youtube-dl suntime norminette future pyxel
sudo pip install https://codeload.github.com/spotDL/spotify-downloader/zip/master
sudo pip uninstall -y numpy beautifulsoup4 soupsieve
yay -S nodejs-lts-gallium --needed --noconfirm
yay -S android-tools gnirehtet zsh neofetch lolcat xiaomitool-v2 visual-studio-code-bin rstudio-desktop-bin gnome-tweaks lxappearance valgrind gnome-shell yarn dex gtk-engine-murrine bat llvm gcc-fortran python-psycopg2 gdal texlive-core scrcpy sndcpy-bin tree libbsd jre-openjdk docker ttf-symbola samba nano sysbench geekbench ascii-image-converter btop noto-fonts gnome-keyring libgnome-keyring svp-bin cmatrix xorg-xhost qt5-styleplugins mesa-utils sl browsh-bin elinks cowsay nginx mariadb dnsmasq cmus pandoc libshumate-git xf86-video-intel vulkan-intel vulkan-tools lib32-vulkan-intel python-numpy tk xorg-xinput asciiquarium wine winetricks tabby-bin vlc qt5ct --needed --noconfirm

# Configure Packages
JAVA_HOME=/usr/lib/jvm/default sudo pip install -r $HOME/College/Machine\ Learning\ I/Machine-Learning-Pacman/requirements.txt
sudo usermod -aG dnsmasq $USER
#sudo systemctl enable --now libvirtd
sudo usermod -aG wireshark $USER
sudo chmod +x /usr/bin/dumpcap
sudo usermod -aG libvirt $USER
echo "remember_owner = 0 " | sudo tee -a /etc/libvirt/qemu.conf
xhost +si:localuser:root && sudo SVPManager

# Install mpv
yay -S qt5-base qt5-declarative qt5-svg libmediainfo lsof vapoursynth rsound spirv-cross mpv-vapoursynth mkvtoolnix-cli avahi --needed --noconfirm

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

# Install College Stuff Dependencies

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

# Cleanup
rm -rf cpabe-* libbswabe-* pbc-*
rm -rf $HOME/Distrobox-Quick-Setup/arch/yay-bin
