#!/bin/bash

NVIM_VERSION=0.9.4
NODE_MAJOR=20
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
SHURETECH_NERDFONT_VERSION=3.0.2

sudo apt update
sudo apt upgrade -y
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update

sudo apt install wget curl git ripgrep xclip python3 python3-venv nodejs -y

wget https://github.com/neovim/neovim/releases/download/v$NVIM_VERSION/nvim.appimage
mkdir -p ~/Apps
mv nvim.appimage ~/Apps
chmod +x ~/Apps/nvim.appimage
echo 'alias vim="~/Apps/nvim.appimage"' >> ~/.bashrc

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v$SHURETECH_NERDFONT_VERSION/ShareTechMono.zip
mkdir -p ~/.fonts
unzip ShareTechMono.zip
rm -f OFL.txt
rm -f readme.md
mv *.ttf ~/.fonts/
rm -f ShareTechMono.zip
fc-cache -fv

mkdir -p ~/.config/alacritty
cp alacritty.yml ~/.config/alacritty/

mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -f lazygit.tar.gz
rm -f lazygit

mkdir -p ~/.config/nvim/lua/plugins
cp community.lua ~/.config/nvim/lua/plugins/

pkill -9 alacritty
