#!/usr/bin/env bash

DATE=20200423

# Development Tools
brew install pyenv

# Replace .zshrc with your appropriate shell RC file
# IMPORTANT: Use .bash_profile, not .bashrc for bash

#echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
sudo pyenv install 3.7.3
sudo pyenv global 3.7.3

sudo pip install ansible fabric3 jsonpickle requests PyYAML
vagrant plugin install vagrant-vbguest

# Build/Deploy Tooling

brew install aws-iam-authenticator kubernetes-cli kubernetes-helm terraform
sudo pip install awscli
aws configure
