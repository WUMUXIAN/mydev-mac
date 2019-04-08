#!/bin/bash

## install kernel headers and download cuda installers.
sudo apt-get install linux-headers-$(uname -r) -y
wget https://developer.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.105_418.39_linux.run
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda_8.0.61.2_linux-run

# sudo update-initramfs -u
sudo sh -c 'echo "blacklist nouveau\noptions nouveau modeset=0" > /etc/modprobe.d/blacklist-nouveau.conf'
sudo update-initramfs -u

#### Please note that after this step we need to restart the machine.
#### If might not be able to boot, we need to move into terminal mode by ctrl+alt+F2.
#### In terminal mode, run the following:

sudo sh cuda_10.1.105_418.39_linux-run --silent --driver --toolkit --toolkitpath=/usr/local/cuda-10.0
sudo sh cuda_8.0.61_375.26_linux-run --silent --toolkit --toolkitpath=/usr/local/cuda-8.0
sudo sh cuda_8.0.61.2_linux-run

export PATH=$PATH:/usr/local/cuda/bin
