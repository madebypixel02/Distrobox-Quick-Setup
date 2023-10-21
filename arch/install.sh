#!/bin/bash

# Set locale
[ "en_US.UTF-8 UTF-8" != "$(head -n 1 /etc/locale.gen)" ] && echo "en_US.UTF-8 UTF-8
es_ES.UTF-8 UTF-8" | sudo tee /etc/locale.gen && echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf && sudo locale-gen

# Copy pacman.conf
sudo cp $HOME/Distrobox-Quick-Setup/Config\ Files/pacman.conf /etc/

# Install base packages
sudo pacman -Syu git base-devel zsh curl wget python python-pip vim neovim man-pages man-db --needed --noconfirm

# Install yay
[ ! -f /bin/yay ] && git clone https://aur.archlinux.org/yay-bin.git $HOME/yay-bin && cd $HOME/yay-bin && makepkg -si --noconfirm && cd .. && rm -rf $HOME/yay-bin

# Uniform QT / GTK look
grep 'QT_QPA_PLATFORMTHEME=\"qt5ct\"' /etc/environment 1>/dev/null; [ "$?" -eq 1 ] && echo "QT_QPA_PLATFORMTHEME=\"qt5ct\"" | sudo tee -a /etc/environment 1>/dev/null

# Install typical packages
yay -Sy android-tools gnirehtet zsh neofetch lolcat noto-fonts-cjk noto-fonts-extra ttf-dejavu gnome-tweaks lxappearance valgrind yarn dex gtk-engine-murrine bat gdal texlive-core scrcpy tree libbsd jre-openjdk nano sysbench geekbench ascii-image-converter btop noto-fonts gnome-keyring libgnome-keyring svp-bin cmatrix xorg-xhost adwaita-qt5 adwaita-qt6 mesa-utils sl browsh-bin elinks cowsay nginx dnsmasq cmus pandoc xf86-video-intel vulkan-intel vulkan-tools lib32-vulkan-intel tk xorg-xinput asciiquarium wine winetricks vlc qt5ct wireshark-qt epiphany autofirma-bin libpkcs11-dnie ca-certificates-fnmt configuradorfnmt noto-fonts noto-fonts-emoji ttf-linux-libertine ttf-dejavu noto-fonts-cjk tldr universal-android-debloater-bin npm yt-dlp python-spotdl quarto-cli-bin --needed --noconfirm

# Set Up Quarto
# Language Servers
yay -Sy bash-language-server vscode-html-languageserver lua-language-server marksman ripgrep --needed --noconfirm
# Other dependencies
yay -Sy python-plotly python-pandas python-matplotlib ripgrep jupyter-nbconvert jupyter-server jupyter-nbclient jupyter-notebook python-jupyter-core python-jupyter-client python-jupyter-events texlive-latexextra neovim-nvim-treesitter --needed --noconfirm

# Minilibx
cd ~/ && git clone https://github.com/42Paris/minilibx-linux.git $HOME/minilibx-linux
cd $HOME/minilibx-linux/
make
sudo cp mlx.h /usr/include
sudo cp libmlx.a /usr/lib
sudo cp man/man3/* /usr/share/man/man3/
rm -rf $HOME/minilibx-linux

# Configure Packages
sudo chmod a+w /usr/lib/vlc/plugins/video_filter/
sudo chmod a+w /usr/lib/vlc/plugins/video_filter/*

# Configure gnome terminal shortcuts
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Primary>Tab'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Primary><Shift>Tab'

# Configure git credential manager
sudo make -C /usr/share/git/credential/libsecret
git config --global credential.helper /usr/share/git/credential/libsecret/git-credential-libsecret

# Install minishell
make -C $HOME/42\ Madrid/Git/42\ Cursus/minishell
[ ! -L /bin/minishell ] && cd /bin && sudo ln -s $HOME/42\ Madrid/Git/42\ Cursus/minishell/bin/minishell . && cd $HOME/Distrobox-Quick-Setup
