# WARNING: This provisioner uses curl download & execute commands.
# Only proceed if you too, like to live dangerously.
# 
# This provisioner is designed to setup a desktop machine. 
# It should be run as root, but will setup certain things for the user.
# It will prompt for the user name to use if DEFAULT_USER hasn't been set.
if [[ -z $GIT_REPO_PREFIX ]]; then
	GIT_REPO_PREFIX="https://github.com"
fi

if [[ -z $GIT_REPO_SSH_PREFIX ]]; then
	GIT_REPO_SSH_PREFIX="git+ssh://git@github.com"
fi

if [[ -z $GIT_SSH_KEY_PATH ]]; then
	read -p "Enter the path to your github ssh key, or hit enter to skip: " key_in
	if [[ ! -z $key_in ]]; then
		GIT_SSH_KEY_PATH=$key_in
		GIT_PREFIX=$GIT_REPO_SSH_PREFIX
	else
		GIT_PREFIX=$GIT_REPO_PREFIX
	fi
fi

if [[ -z $DOTFILES_REPO ]]; then
	DOTFILES_GUESS=$USER/dotfiles
	read -p "No DOTFILES_REPO found. Enter username, or press enter to use ($DOTFILES_GUESS): " dot_in
	if [[ -z $dot_in ]]; then
		dot_in=$DOTFILES_GUESS
	fi
	DOTFILES_REPO=dot_in
fi

### Initial apt update and generic installs ###

sudo apt update
sudo apt upgrade
sudo apt -y install build-essential software-properties-common git-core

# Setup SSH git key
if [[ ! -z $IGT_SSH_KEY_PATH ]]; then
	# Must have restrictive permissions or ssh will block you
	sudo chmod 600 $GIT_SSH_KEY_PATH
	# Add to ssh-agent, this will prompt for a passcode
	ssh-add $GIT_SSH_KEY_PATH
	# Disable (yes/no) confirmation when connecting to github for the first time
	ssh -i $GIT_SSH_KEY_PATH -o StrictHostKeyChecking=no git@github.com || true
fi

### Dotfiles ###
DOTFILES_TARGET_PATH=~/dotfiles
if [[ ! -e $DOTFILES_TARGET_PATH ]]; then
	GIT_SEP=/
	if [[ ! -z $GIT_SSH_KEY_PATH ]]; then
		GIT_SEP=:
	fi
	DOTFILES_TARGET_REPO="$GIT_PREFIX$GIT_SEP$DOTFILES_REPO"
	git clone $DOTFILES_TARGET_REPO $DOTFILES_TARGET_PATH
	. ~/dotfiles/install
fi

### Shell ###
# zplug (zsh)
sudo apt install zsh zsh-doc
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
# Change default shell, this may prompt for a password
chsh -s /bin/zsh
# zplug update --self
# Ubuntu doesn't set XDG_CONFIG_HOME by default
echo 'export XDG_CONFIG_HOME="$HOME/.config"' | sudo tee /etc/profile.d/xdg.sh
### Languages ###
## Node ##
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


## LLVM/Clang ##

## Rust ##

## Go ##
sudo apt -y install curl git mercurial make binutils bison gcc build-essential
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
## OCaml ##

## Java ##

## Racket ##

## Ruby ##


### PREP ###
mkdir -p ~/bin
mkdir -p ~/dl
LOCAL_FONT_DIR=~/.fonts
mkdir -p $LOCAL_FONT_DIR
ln -s ~/.local/share/fonts $LOCAL_FONT_DIR
### FONTS ###
copy_fonts () {
	local src_dir=$1
	find_command="find \"$src_dir\" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0"
	echo "Copying fonts..."
	eval $find_command | xargs -0 -I % cp "%" "$LOCAL_FONT_DIR/"
}
## Google Noto ##
sudo apt -y install fonts-noto-mono
## Powerline ##
git clone --depth=1 https://github.com/powerline/fonts ~/dl/fonts
copy_fonts ~/dl/fonts
git clone --depth=1 https://github.com/ryanoasis/nerd-fonts ~/dl/nerd-fonts
copy_fonts ~/dl/nerd-fonts

# Refresh font cache
echo "Resetting font cache, this may take a moment..."
fc-cache -f ~/.fonts

### APPLICATIONS ###
# More general dependencies (for termite, but useful to have up here)
sudo apt -y install g++ libgtk-3-dev gtk-doc-tools gnutls-bin valac
sudo apt -y install libglib3.0-cil-dev libgnutls28-dev libgirepository1.0-dev
sudo apt -y install libxml2-utils gperf

# Git tweaks
# diff-so-fancy - nicer diffs
npm install -g diff-so-fancy
# node repl
npm install -g nesh
# Neovim - Editor
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
# Install Python 2 and 3 versions, xsel is needed for clipboard integration.
sudo apt -y install xsel python-dev python-pip python3-dev python3-pip neovim
pip install --upgrade pip
pip install neovim
pip3 install neovim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# bspwm - tiled window manager
sudo apt -y install xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev
git clone https://github.com/baskerville/bspwm.git ~/dl/bspwm && cd ~/dl/bspwm && make && sudo make install
git clone https://github.com/baskerville/sxhkd.git ~/dl/sxhkd && cd ~/dl/sxhkd && make && sudo make install
sudo cp ~/dl/bspwm/contrib/freedesktop/bspwm.desktop /usr/share/xsessions
# Just a reminder, ubuntu uses lightdm, sudo service lightdm
# lightdm will run .xprofile before starting, so in our dotfiles that's where we'll keep bspwm pre-launch configuration

# lighthouse - application launcher popover things
# https://github.com/emgram769/lighthouse

# peco is like less with interactive filtering - https://github.com/peco/peco

PECO_LATEST_URL=$(curl -s https://api.github.com/repos/peco/peco/releases | grep browser_download_url | grep 'linux_amd64' | head -n 1 | cut -d '"' -f 4)
wget -O ~/dl/peco.tar.gz $PECO_LATEST_URL
mkdir -p ~/dl/peco && tar xf ~/dl/peco.tar.gz -C ~/dl/peco --strip-components=1
sudo cp ~/dl/peco/peco /usr/local/bin

# feh - image viewer
sudo -y apt install feh

# font manager - gui for viewing fonts
# sudo apt -y install font-manager

# termite
git clone --depth=1 --recursive https://github.com/thestinger/termite.git ~/dl/termite
git clone --depth=1 https://github.com/thestinger/vte-ng.git ~/dl/vte-ng
cd ~/dl/vte-ng && ./autogen.sh && make && sudo make install
cd ~/dl/termite && make && sudo make install
sudo cp /usr/local/lib/libvte-*.a /usr/local/lib/libvte-*.la \
/usr/local/lib/libvte-*.so /usr/local/lib/libvte-*.so.* /usr/lib
sudo mkdir -p /lib/terminfo/x; sudo ln -s \
/usr/local/share/terminfo/x/xterm-termite \
/lib/terminfo/x/xterm-termite
echo 'export TERMINAL=termite' | sudo tee /etc/profile.d/termite.sh

# ag - text search tool
sudo apt -y install silversearcher-ag
# httpie - curl alternative
sudo apt -y install httpie

# tldr gives quick examples for common command line tool use cases, e.g. tldr wget
npm install -g tldr
# Will prompt, select nvim
update-alternatives --config vi
update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
# Will prompt, select nvim
update-alternatives --config vim
update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
# Will prompt, select nvim
update-alternatives --config editor

# wingo
go get github.com/BurntSushi/wingo
go get github.com/BurntSushi/wingo/wingo-cmd

# lighthouse
sudo apt install libpango1.0-dev libpth-dev libx11-dev libx11-xcb-dev libcairo2-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev
git clone https://github.com/emgram769/lighthouse ~/dl/lighthouse
# NOTE: I have an issue open about this, but we actually have to patch the makefile, and it's not done in the provisioner yet (hoping it'll be fixed in origin by the time I have to use this script again)
# To Makefile, add:
# CFLAGS+=`pkg-config --cflags pangocairo`
# LDFLAGS+=`pkg-config --libs pangocairo`
cd ~/dl/lighthouse && make && sudo make install

# playerctl
git clone https://github.com/acrisci/playerctl ~/dl/playerctl
cd ~/dl/playerctl ./autogen.sh && make && sudo make install

# lm-sensors
sudo apt -y install lm-sensors

# i3
sudo apt -y install i3 i3blocks

# i3 gaps
sudo apt -y install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev xutils-dev
git clone https://github.com/Airblader/xcb-util-xrm ~/dl/xcb-util-xrm
cd ~/dl/xcb-util-xrm && git submodule update --init && ./autogen.sh --prefix=/usr
make && sudo make install
git clone https://github.com/Airblader/i3 ~/dl/i3-gaps
cd ~/dl/i3-gaps && make && sudo make install


# Setup LightDM
sudo ln -s $DOTFILES_TARGET_PATH/provisioner/sysfiles/lightdm/60-custom.conf /usr/share/lightdm/lightdm.conf.d/60-custom.conf
# sudo ln -s $DOTFILES_TARGET_PATH/provisioner/sysfiles/xsessions/wingo.desktop /usr/share/xsessions/wingo.desktop
# sudo ln -s ~/.gvm/pkgsets/go1.7/global/bin/wingo /usr/local/bin/wingo

# Google Chrome notes
# Right now Google Chrome is in beta, so I don't want to add the deb file manually yet. To get screen tearing to stop, I had to go to chrome://flags and manually disable Smooth Scrolling

# Unifying Receiver for Logitech Mouse (will show up in systray)
sudo apt -y install solaar
sudo gpasswd -a $USER plugdev

# j4-dmenu-desktop
sudo apt -y install j4-dmenu-desktop

# Compton - compositing
sudo apt-add-repository -y ppa:richardgv/compton
sudo apt update
sudo apt -y install compton

# Nitrogen - wallpaper
# I'm not including the wallpaper I use in dotfiles, you'll have to set nitrogen up once manually. Just run nitrogen for the gui.
sudo apt -y install nitrogen

# brightness control
sudo apt -y install xbacklight

# Firmware Test Suite
sudo apt -y install fwts
