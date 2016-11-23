# TODO
# Follow http://nicholasglazer.github.io/arch-cheat-sheet, more or less
# For oryx, ensure you add extra boot options, to enable the touchpad 
# to /boot/loaders/entries/arch.conf, add the options i8042.nomux=1 i8042.reset
sudo pacman -Syu

sudo pacman -S zsh openssh expac termite rfkill unzip tree cmake --noconfirm
# Default terminal to termite
echo 'export TERMINAL=termite' | sudo tee /etc/profile.d/termite.sh
pacman -S nvidia nvidia-libgl xf86-input-libinput xorg nvidia-settings

gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 487EACC08557AD082088DABA1EB2638FF56C0C53

mkdir ~/dl
git clone https://aur.archilinux.org/cower.git ~/dl/cower
cd ~/dl/cower && makepkg --syncdeps --install --noconfirm
git clone https://aur.archilinux.org/pacaur.git ~/dl/pacaur
cd ~/dl/pacaur && makepkg --syncdeps --install --noconfirm

# Wifi - connman
pacaur -S connman
sudo systemctl enable connman
sudo systemctl start connman

# TODO
# Instructions for enabling wifi
# Cheat sheet at https://gist.github.com/kylemanna/6930087
# connmanctl enable wifi
# connmanctl
# Now you will be in interactive mode
# connmanctl> scan wifi
# connmanctl> services
# This will give you a list of places to connect to
# connmanctl> agent on
# connmanctl> connect <wifi_foo>

# Sound
sudo pacman -S alsa-lib alsa-utils pulseaudio --noconfirm

# i3
pacaur -S rxvt-unicode dmenu i3lock i3status i3blocks acpi bc playerctl sysstat --noconfirm

# gnome
pacaur -S gnome --noconfirm

# compton
pacaur -S compton --noconfirm

# Image viewer - feh
pacaur -S --noconfirm feh
# better top
pacaur -S --noconfirm htop
# laptop sensors
pacaur -S --noconfirm lm_sensors
# connman for dmenu
pacaur -S --noconfirm connman_dmenu-git
# clipboard cli utility - https://github.com/astrand/xclip
pacaur -S --noconfirm xclip

# zshell
curl -sL zplug.sh/installer | zsh
# Change default shell, this may prompt for a password
chsh -s /bin/zsh
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.6/install.sh | bash
export NVM_DIR=/home/$USER/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# Because we haven't switched over to zsh yet, the install script will put this in .bashrc.
# Add it to .zshrc as well
if grep -q NVM_DIR ~/.zshrc; then
	echo ".zshrc already contains a reference to NVM_DIR, skipping setup..."
else
	touch ~/.zshrc
	echo "export NVM_DIR=/home/$USER/.nvm" >> ~/.zshrc
	echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\"" >> ~/.zshrc
fi
nvm install node

## Go ##
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source ~/.gvm/scripts/gvm
# 1.4 branch is needed to bootstrap later
gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.7
gvm use go1.7 --default
# Go REPL (Gore)
go get -u github.com/motemen/gore

mkdir -p ~/bin
LOCAL_FONT_DIR=~/.local/share/fonts
mkdir -p $LOCAL_FONT_DIR
### FONTS ###
copy_fonts () {
	local src_dir=$1
	find_command="find \"$src_dir\" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0"
	echo "Copying fonts..."
	eval $find_command | xargs -0 -I % cp "%" "$LOCAL_FONT_DIR/"
}

# realtime font preview
pacaur -S grip-git --noconfirm
## Powerline ##
git clone --depth=1 https://github.com/powerline/fonts ~/dl/fonts
copy_fonts ~/dl/fonts
git clone --depth=1 https://github.com/ryanoasis/nerd-fonts ~/dl/nerd-fonts
copy_fonts ~/dl/nerd-fonts
echo "Resetting font cache, this may take a moment..."
fc-cache -f ~/.config/fonts

# diff-so-fancy - nicer diffs
npm install -g diff-so-fancy
# node repl
npm install -g nesh

pacaur -S python-neovim python2-neovim xsel neovim --noconfirm

# peco is like less with interactive filtering - https://github.com/peco/peco
pacaur -S peco --noconfirm

# a faster dmenu
pacaur -S j4-dmenu-desktop --noconfirm

# notification daemon
pacaur -S dunst --noconfirm

# lightdm
pacaur -S lightdm lightdm-gtk-greeter --noconfirm
sudo systemctl enable lightdm
# TODO: make lightdm.conf a dotfile, and also theme lightdm-gtk-greeter

# gtk theme
pacaur -S gtk-theme-arc --noconfirm
# TODO: Setup Arc according to https://github.com/horst3180/arc-theme

# numix git icons
pacaur -S numix-icon-theme-git --noconfirm

# Logitech tools
pacaur -S solaar --noconfirm
sudo gpasswd -a $USER plugdev

# nitrogen
pacaur -S nitrogen --noconfirm

# light for laptopt backlight control
pacaur -S light-git --noconfirm

# ranger for file management, rest for previewing
pacaur -S w3m ranger highlight atool elinks poppler transmission-cli mediainfo perl-image-exiftool --noconfirm

# a couple more archiving tools
pacaur -S lzop p7zip unace unrar zip --noconfirm

pacaur -S slack-desktop --noconfirm

pacaur -S ffmpeg spotify --noconfirm

pacaur -S imagemagick --noconfirm

pacaur -S vagrant --noconfirm

pacaur -S virtualbox net-tools vde2 virtualbox-guest-iso --noconfirm

# Fuzzy finder, used with enhancd
pacaur -S fzy --noconfirm

# N1 install didn't want to work using nvm, so just making a note of it here.
pacaur -S alsa-lib desktop-file-utils gtk2 gconf libgnome-keyring libnotify libxtst nss python2
# git clone https://github.com/nylas/N1 && cd N1 && node script/bootstrap && npm run build 
npm install -g typescript

# ag - a better ack/ack-grep/grep
pacaur -S the_silver_searcher
