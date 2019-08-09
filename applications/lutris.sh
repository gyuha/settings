#!/bin/bash

echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_9.0/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_9.0/Release.key -O- | sudo apt-key add -

sudo apt-get update
sudo apt-get install lutris
