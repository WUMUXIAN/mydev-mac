#!/bin/bash

##### Install necessary softwares via apt-get
sudo apt-get update -y &&
sudo apt-get install -y git \
	terminator \
  zsh \
	curl \
  htop \
  telnet

##### Install oh-my-zsh
sudo sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


##### Install atom
curl -L -o atom.deb https://atom.io/download/deb
sudo dpkg -i atom.deb
sudo apt-get install -f -y
rm -rf atom.deb

##### Install chrome
sudo sh -c 'echo -n "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list'
wget https://dl.google.com/linux/linux_signing_key.pub
sudo apt-key add linux_signing_key.pub
sudo apt update && sudo apt install google-chrome-stable -y
rm -rf linux_signing_key.pub

##### Install pinyin input.
sudo apt-get install fcitx-googlepinyin -y
curl -L -o sogoupinyin.deb "http://cdn2.ime.sogou.com/dl/index/1524572264/sogoupinyin_2.2.0.0108_amd64.deb?st=A-_gH35zt4U3DM5oQz3ezA&e=1554019966&fn=sogoupinyin_2.2.0.0108_amd64.deb"
sudo dpkg -i sogoupinyin.deb
sudo apt-get install -f -y
rm -rf sogoupinyin.deb
## you have to set the Keyboard input method to fcitx and then select sogoupinyin in the configuration.


##### Install snap softwares
sudo apt-get install snapd snapd-xdg-open -y
sudo snap install vlc
sudo snap install postman
sudo snap install electronic-wechat

##### Install docker and nvidia-docker
sudo apt-get update && sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker $USER

If you have nvidia-docker 1.0 installed: we need to remove it and all existing GPU containers
sudo docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
sudo apt-get purge -y nvidia-docker

# Add the package repositories
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update

# Install nvidia-docker2 and reload the Docker daemon configuration
sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd

# Test nvidia-smi with the latest official CUDA image
sudo docker run --runtime=nvidia --rm nvidia/cuda:9.0-base nvidia-smi

## install golang and dep
wget https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.12.1.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.zshrc
echo "export GOPATH=$HOME/GoSpace" >> ~/.zshrc
echo "export GOBIN=$HOME/GoSpace/bin" >> ~/.zshrc
echo "export PATH=$PATH:$HOME/GoSpace/bin" >> ~/.zshrc
rm -rf go1.12.1.linux-amd64.tar.gz

# do it here.
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/GoSpace
export GOBIN=$HOME/GoSpace/bin
export PATH=$PATH:$HOME/GoSpace/bin

curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

#### install java.
sudo add-apt-repository ppa:webupd8team/java
sudo apt update && sudo apt install oracle-java8-installer -y
sudo apt install oracle-java8-set-default -y
