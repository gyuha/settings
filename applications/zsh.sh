#!/bin/bash
sudo apt-get install -f zsh
sudo apt-get install -f zsh-syntax-highlighting
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
./prezto.sh
chsh -s `which zsh`

./zsh_setup.sh
