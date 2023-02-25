#!/bin/bash

###################################################
# Prezto — Instantly Awesome Zsh
#   - 앞으로는 prezto를 사용해 보려고 한다.
###################################################
sudo apt-get install -y -f zsh
sudo apt-get install -y -f zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s `which zsh`

./zsh_setup.sh
