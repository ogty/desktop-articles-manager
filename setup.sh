#!/bin/sh

currentDirectory=$(cd $(dirname $0);pwd)
echo 'export PATH="$PATH:'$currentDirectory\" >> ~/.zshrc
source ~/.zshrc
sudo chmod 755 $currentDirectory/artima

npm install --global md-to-pdf @marp-team/marp-cli
