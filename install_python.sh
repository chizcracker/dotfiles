#!/bin/bash


brew_install pyenv
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile

brew_install pyenv-virtualenv
echo -e 'if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi' >> ~/.bash_profile

source ~/.bash_profile

# pyenv install 2.7.16
# pyenv install 3.7.4
