sudo pacman -S zsh
sudo pacman -S zsh
chsh -s /bin/zsh
sudo chsh -s /bin/zsh
git clone https://aur.archlinux.org/yay-bin.git
sudo pacman -S base-devel git curl wget
git clone https://aur.archlinux.org/yay-bin.git
git clone https://github.com/madebypixel02/Distrobox-Quick-Setup.git
cd yay-bin/
makepkg -si
yay plymouth
yay -S neovim vim preload npm python python-pip distrobox podman cronie
cd
sudo nvim /etc/mkinitcpio.
sudo nvim /etc/mkinitcpio.conf 
sudo nvim /etc/mkinitcpio.conf 
sudo mkinitcpio -p linux linux-lts linux-zen linux-hardened
sudo nvim /usr/share/plymouth/themes/bgrt/bgrt.plymouth 
sudo plymouth-set-default-theme -R bgrt
systemctl reboot
read -p
read -p "Hello: " answer
bashrc
while [ $answer != "Y" ] && [ $answer != "y" ] && [ $answer != "N" ] && [ $answer != "N" ]; do     [ $answer != "NULL" ] && echo "Invalid Answer\!";     read -p "Do you want to auto-configure Focalboard-server on this install? " answer;     if [ $answer == "y" ] || [ $answer == "Y" ];     then         echo "you said yes\!";     fi; done
while [ $answer != "Y" ] && [ $answer != "y" ] && [ $answer != "N" ] && [ $answer != "N" ]; do     [ $answer != "NULL" ] && echo "Invalid Answer\!";     read -p "Do you want to auto-configure Focalboard-server on this install? " answer;     if [ $answer == "y" ] || [ $answer == "Y" ];     then         echo "you said yes\!";     fi; done
answer="NULL"
while [ $answer != "Y" ] && [ $answer != "y" ] && [ $answer != "N" ] && [ $answer != "N" ]; do     [ $answer != "NULL" ] && echo "Invalid Answer\!";     read -p "Do you want to auto-configure Focalboard-server on this install? " answer;     if [ $answer == "y" ] || [ $answer == "Y" ];     then         echo "you said yes\!";     fi; done
while [ $answer != "Y" ] && [ $answer != "y" ] && [ $answer != "N" ] && [ $answer != "N" ]; do     [ $answer != "NULL" ] && echo "Invalid Answer\!";     read -p "Do you want to auto-configure Focalboard-server on this install? [Y/n] " answer;     if [ $answer == "y" ] || [ $answer == "Y" ];     then         echo "you said yes\!";     fi; done
while [ $answer != "Y" ] && [ $answer != "y" ] && [ $answer != "N" ] && [ $answer != "N" ]; do     [ $answer != "NULL" ] && echo "Invalid Answer\!";     read -p "Do you want to auto-configure Focalboard-server on this install? [Y/n] " answer;     [ -z $answer ] && answer="N"; if [ $answer == "y" ] || [ $answer == "Y" ];     then         echo "you said yes\!";     fi; done
answer="NULL"
while [ $answer != "Y" ] && [ $answer != "y" ] && [ $answer != "N" ] && [ $answer != "N" ]; do     [ $answer != "NULL" ] && echo "Invalid Answer\!";     read -p "Do you want to auto-configure Focalboard-server on this install? [Y/n] " answer;     [ -z $answer ] && answer="N"; if [ $answer == "y" ] || [ $answer == "Y" ];     then         echo "you said yes\!";     fi; done
answer="N"; while [ $answer != "Y" ] && [ $answer != "y" ] && [ $answer != "N" ] && [ $answer != "N" ]; do     [ $answer != "NULL" ] && echo "Invalid Answer\!";     read -p "Do you want to auto-configure Focalboard-server on this install? [Y/n] " answer;     [ -z $answer ] && answer="N"; if [ $answer == "y" ] || [ $answer == "Y" ];     then         echo "you said yes\!";     fi; done
answer="NULL"; while [ $answer != "Y" ] && [ $answer != "y" ] && [ $answer != "N" ] && [ $answer != "N" ]; do     [ $answer != "NULL" ] && echo "Invalid Answer\!";     read -p "Do you want to auto-configure Focalboard-server on this install? [Y/n] " answer;     [ -z $answer ] && answer="N"; if [ $answer == "y" ] || [ $answer == "Y" ];     then         echo "you said yes\!";     fi; done
answer="NULL"; while [ $answer != "Y" ] && [ $answer != "y" ] && [ $answer != "N" ] && [ $answer != "N" ]; do     [ $answer != "NULL" ] && echo "Invalid Answer\!";     read -p "Do you want to auto-configure Focalboard-server on this install? [Y/n] " answer;     [ -z $answer ] && answer="N"; if [ $answer == "y" ] || [ $answer == "Y" ];     then         echo "you said yes!";     fi; done
answer="NULL"; while [ $answer != "Y" ] && [ $answer != "y" ] && [ $answer != "N" ] && [ $answer != "N" ]; do     [ $answer != "NULL" ] && echo "Invalid Answer\!";     read -p "Do you want to auto-configure Focalboard-server on this install? [y/N] " answer;     [ -z $answer ] && answer="N"; if [ $answer == "y" ] || [ $answer == "Y" ];     then         echo "you said yes!";     fi; done
answer="NULL"; while [ $answer != "Y" ] && [ $answer != "y" ] && [ $answer != "N" ] && [ $answer != "N" ]; do     [ $answer != "NULL" ] && echo "Invalid Answer!";     read -p "Do you want to auto-configure Focalboard-server on this install? [y/N] " answer;     [ -z $answer ] && answer="N"; if [ $answer == "y" ] || [ $answer == "Y" ];     then         echo "you said yes!";     fi; done
[ ! grep "qt5ct" /etc/environment ] && echo
[ $(grep "qt5ct" /etc/environment) -eq 1 ] && echo
[ ! grep "qt5ct" /etc/environment ] && echo
[ ! "grep \"qt5ct" /etc/environment ] && echo
[ ! "grep \"qt5ct\" /etc/environment" ] && echo
[ ! "grep \"qt5ct\" /etc/environment" ] && echo hola
[ "grep \"qt5ct\" /etc/environment" ] && echo hola
[ ! "grep \"qt5ct\" /etc/environment" ] && echo hola
sudo nvim /etc/environment 
[ ! "grep \"QT_QPA_PLATFORMTHEME=\"qt5ct\""\" /etc/environment" ] && echo hola
[ ! "grep \"QT_QPA_PLATFORMTHEME=\"qt5ct\"\" /etc/environment" ] && echo hola
[ "grep \"QT_QPA_PLATFORMTHEME=\"qt5ct\"\" /etc/environment" ] && echo hola
[ ! "grep \"remember_owner = 0\" /etc/libvirt/qemu.conf" ] && echo hola
[ "grep \"remember_owner = 0\" /etc/libvirt/qemu.conf" ] && echo hola
zshrc
bashrc
zshrc
bashrc
cd ~/Distrobox-Quick-Setup/
./install.sh 
[ "en_US.UTF-8 UTF-8" == "$(head -n 1 /etc/locale.gen)" ] && echo hola
[ "en_US.UTF-8 UTF-8" != "$(head -n 1 /etc/locale.gen)" ] && echo hola
export PATH=$PATH:$(find $HOME/42\ Madrid/GitHub/42\ Cursus -type d -name bin | head -c $(($(find $HOME/42\ Madrid/GitHub/42\ Cursus -type d -name bin | wc -c) - 1)) | tr "\n" ":")
echo $(find $HOME/42\ Madrid/GitHub/42\ Cursus -type d -name bin | head -c $(($(find $HOME/42\ Madrid/GitHub/42\ Cursus -type d -name bin | wc -c) - 1)) | tr "\n" ":")
echo $(find $HOME/42\ Madrid/GitHub/42\ Cursus -type d -name bin | head -c $(($(find $HOME/42\ Madrid/GitHub/42\ Cursus -type d -name bin | wc -c))) | tr "\n" ":")
$(1 * 1)
$((1 * 1);2C)
eccho $((1 * 1);2C)
echo $((1 * 1);2C)
echo $((1 * 1))
mv -f ~/.zshrc.pre-oh-my-zsh ~/.zshrc
chsh -s /bin/zsh
[ ! "osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)' | grep \"Yellows-d\"" ] && echo hola
[ ! "grep \"QT_QPA_PLATFORMTHEME=\"qt5ct\"\" /etc/environment" ] && echo
[ ! "osascript -e 'tell app \"finder\" to get posix path of (get desktop picture as alias)' | grep \"Yellows-d\"" ] && echo hola
[ ! "osascript -e \'tell app \"finder\" to get posix path of (get desktop picture as alias)\' | grep \"Yellows-d\"" ] && echo hola
osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)' | grep \"Yellows-d\""
osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)' | grep \"Yellows-d\""'
osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)' | grep \"Yellows-d\"'
osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)' | grep "Yellows-d"
osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)' | grep \"Yellows-d\"
echo $?
osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)' | grep Yellows-d
[ ! "osascript -e 'tell app "\finder\" to get posix path of (get desktop picture as alias)' | grep Yellows-d" ] && echo hola
[ ! "osascript -e 'tell app "\finder\" to get posix path of \(get desktop picture as alias\)' | grep Yellows-d" ] && echo hola
[ ! "osascript -e 'tell app \"finder\" to get posix path of (get desktop picture as alias)' | grep Yellows-d" ] && echo hola
[ "osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)' | grep Yellows-d" ] && echo hola
[ ! "osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)' | grep Yellows-d" ] && echo hola
[ "osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)' | grep Yellows-d" ] && echo hola
echo -nn hola
git clone https://github.com/madebypixel02/Distrobox-Quick-Setup.git
cd Distrobox-Quick-Setup/
./install.sh 
sudo dnf install dnf preload
sudo dnf copr enable elxreno/preload -y && sudo dnf install preload -y
sudo dnf install dnf
sudo dnf install zsh
sudo usermod -s /bin/zsh pixel
sudo passwd
sudo usermod -s /bin/zsh root
sudo systemctl disable --now power-profiles-daemon
sudo systemctl mask power-profiles-daemon
sudo dnf install distrobox
systemctl reboot
[ ! "grep \"QT_QPA_PLATFORMTHEME=\"qt5ct\"\" /etc/environment" ] && echo
[ ! "grep \"QT_QPA_PLATFORMTHEME=\"qt5ct\"\" /etc/environment" ] && echo hola
[ ! grep 'QT_QPA_PLATFORMTHEME=\"qt5ct\"' /etc/environment ] && echo hola
[ ! (grep 'QT_QPA_PLATFORMTHEME=\"qt5ct\"' /etc/environment) ] && echo hola
[ ! "grep 'QT_QPA_PLATFORMTHEME=\"qt5ct\"' /etc/environment" ] && echo hola
echo $?
[ ! "grep 'QT_QPA_PLATFORMTHEME=\"qt5ct\"' /etc/environment" ] && echo hola
[ "grep 'QT_QPA_PLATFORMTHEME=\"qt5ct\"' /etc/environment" ] && echo hola
grep 'QT_QPA_PLATFORMTHEME=\"qt5ct\"' /etc/environment
grep 'QT_QPA_PLATFORMTHEME=qt5ct' /etc/environment
[ "grep 'QT_QPA_PLATFORMTHEME=qt5ct' /etc/environment" ] && echo hola
[ "! grep 'QT_QPA_PLATFORMTHEME=qt5ct' /etc/environment" ] && echo hola
[ "! grep 'QT_QPA_PLATFORMTHEME=qt5ct' /etc/environment" ] && echo 'QT_QPA_PLATFORMTHEME=qt5ct' | sudo tee -a /etc/environment
sudo rn /etc/environmentecho 
sudo rm /etc/environmentecho 
sudo nvim /etc/environment
grep 'QT_QPA_PLATFORMTHEME=\"qt5ct\"' /etc/environment; [ "$?" -eq 1 ] && echo "QT_QPA_PLATFORMTHEME=\"qt5ct\"" | sudo tee -a /etc/environment
sudo nvim /etc/environment
grep 'QT_QPA_PLATFORMTHEME=\"qt5ct\"' /etc/environment; [ "$?" -eq 1 ] && echo "QT_QPA_PLATFORMTHEME=\"qt5ct\"" | sudo tee -a /etc/environment
sudo nvim /etc/environment
grep 'QT_QPA_PLATFORMTHEME=\"qt5ct\"' /etc/environment 1>/dev/null; [ "$?" -eq 1 ] && echo "QT_QPA_PLATFORMTHEME=\"qt5ct\"" | sudo tee -a /etc/environment
sudo nvim /etc/environment
grep 'QT_QPA_PLATFORMTHEME=\"qt5ct\"' /etc/environment 1>/dev/null; [ "$?" -eq 1 ] && echo "QT_QPA_PLATFORMTHEME=\"qt5ct\"" | sudo tee -a /etc/environment 1>/dev/null
sudo nvim /etc/environment
[ ! "grep \"remember_owner = 0\" /etc/libvirt/qemu.conf" ] && echo hola
[ "grep \"remember_owner = 0\" /etc/libvirt/qemu.conf" ] && echo hola
./args a1 a2 | wc
grep processor /proc/cpuinfo
./launch.sh 1
zsh
rm ~/.zsh_history 
ln -s ~/Distrobox-Quick-Setup/Config\ Files/.zsh_history ~/
man exit
./a.out 
gcc execw_.c
gcc exitw_.c 
./a.out 
gcc exitw_.c && ./a.out 
gcc exitwe.c && ./a.out 
echo $?
