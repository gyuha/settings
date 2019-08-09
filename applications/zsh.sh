#!/bin/bash
sudo apt-get install -f zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s `which zsh`

./zsh_setup.sh
