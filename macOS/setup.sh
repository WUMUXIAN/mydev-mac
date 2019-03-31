#!/usr/bin/ bash

setup_homebrew() {
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

setup_homebrew_packages() {
    brew install python
    brew install wget
    brew install go
	brew install glide
    brew install cmake
    brew install youtube-dl
    brew install jenv 
    brew install ansible
	brew install git
	brew install git-flow
}

setup_python_packages() {
    sudo easy_install pip
    sudo pip install -U pip
    sudo pip install boto
}

setup() {
    setup_homebrew
    setup_homebrew_packages
    setup_python_packages
	setup_glide
}

setup
