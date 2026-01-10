#!/bin/bash

# install mise
# curl https://get.volta.sh | bash
curl https://mise.run/zsh | sh

echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc1
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc

# install Node
mise use --global node@24
mise use --global bun

# start using Node
node
