echo "Updating System"
pacman -Sqyu --noconfirm --noprogressbar

echo "Installing and Upgrading git"
pacman -Sq --needed --noconfirm --noprogressbar git base-devel

echo "Downloading yay"
SCRIPT_DIR=$PWD
cd /tmp
rm -rf yay-bin
sudo -u $SUDO_USER git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
sudo -u $SUDO_USER makepkg -si --noconfirm --noprogressbar
cd $SCRIPT_DIR

echo "Checking yay install"
sudo -u $SUDO_USER yay -Y --gendb --noconfirm --noprogressbar
sudo -u $SUDO_USER yay -Syu --noconfirm --noprogressbar

echo "Installing Graphics Drivers"
mhwd -i pci video-nvidia

echo "System Upgrade Compelted. Installing Packages now"
while read -r line
do
	echo "Installing" $line
	sudo -u $SUDO_USER yay -Sq --noconfirm --noprogressbar --sudoloop $line
done < packages.txt
