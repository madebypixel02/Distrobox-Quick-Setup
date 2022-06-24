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

# Setup Vim-Plug
yay -S vim llvm yarn nodejs-lts-gallium --needed --noconfirm
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Uniform QT / GTK look
echo "export QT_QPA_PLATFORMTHEME=\"qt5ct\"" >> $HOME/.profile
echo "export QT_QPA_PLATFORMTHEME=\"qt5ct\"" | sudo tee -a /etc/profile

# Copy desktop files and icons
cp $HOME/Distrobox-Quick-Setup/Apps/Icons/*.png $HOME/.local/share/icons
#cp -r $HOME/Distrobox-Quick-Setup/Apps/Files/* $HOME/.local/share/applications

# Set up zsh and oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k
mv -f $HOME/.zshrc.pre-oh-my-zsh $HOME/.zshrc

# Install typical packages
sudo pip install -U youtube-dl suntime norminette future
sudo pip install https://codeload.github.com/spotDL/spotify-downloader/zip/master
sudo pip uninstall numpy beautifulsoup4 soupsieve
yay -S lollypop android-tools gnirehtet zsh neofetch lolcat nemo nemo-preview xiaomitool-v2 gnome-boxes stremio vlc visual-studio-code-bin rstudio-desktop-bin gnome-tweaks lxappearance valgrind gnome-shell gnome-control-center gnome-terminal nautilus whatsapp-nativefier eog yarn dex gtk-engine-murrine bat llvm gcc-fortran python-psycopg2 gdal texlive-core scrcpy sndcpy-bin tree libbsd jre-openjdk docker gnome-system-monitor ttf-symbola samba nano sysbench geekbench ascii-image-converter btop noto-fonts gnome-keyring libgnome-keyring svp-bin cmatrix brave-bin xorg-xhost qt5-styleplugins seahorse nemo-fileroller mesa-utils wireshark-qt sl gnome-console browsh-bin elinks cowsay nginx mariadb virt-manager dnsmasq cmus pandoc epiphany libshumate-git freetube-bin xf86-video-intel vulkan-intel vulkan-tools lib32-vulkan-intel python-numpy tk xorg-xinput asciiquarium wine winetricks --needed --noconfirm

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
yay -S qt5-base qt5-declarative qt5-svg libmediainfo lsof vapoursynth rsound spirv-cross mpv-vapoursynth mkvtoolnix-cli avahi --needed

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
make -C $HOME/42\ Madrid/GitHub/42\ Cursus/minishell
cd /bin && sudo ln -s $HOME/42\ Madrid/GitHub/42\ Cursus/minishell/bin/minishell . && cd $HOME/Distrobox-Quick-Setup

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
rm -rf $HOME/Distrobox-Quick-Setup/arch/yay-bin
