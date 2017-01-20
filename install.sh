#!/bin/bash

echo 'checking homebrew ...'
which -s brew
if [[ $? != 0 ]] ; then
  # Install Homebrew
  echo 'installing homebrew ...'
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo 'updating homebrew ...'
  brew update
fi

echo 'installing brew packages ...'
brew install ack
brew install ctags
brew install reattach-to-user-namespace
brew install tmux

echo 'installing vcprompt ... '
curl -sL https://github.com/djl/vcprompt/raw/master/bin/vcprompt > ~/bin/vcprompt
chmod 755 ~/bin/vcprompt

echo 'backing up current config files ...'
mkdir -p ~/settings/backup
cp ~/.bash_profile ~/settings/backup/
cp ~/.tmux.conf ~/settings/backup/
cp ~/.vimrc ~/settings/backup/

echo 'copying config files ...'
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp $DIR/.bash_profile ~/
cp $DIR/.tmux.conf ~/
cp $DIR/.vimrc ~/

echo 'checking vim compatibility ...'

install_vim() {
  brew install vim
  echo "alias vim='/usr/local/bin/vim'" >>~/.bash_profile
}

has_vim=$(command -v vim >/dev/null)
if $has_vim; then
  vim_version=$(vim --version | head -1 | cut -d ' ' -f 5)
  has_ruby_support=$(vim --version | grep -c ruby)

  if [ ! $(echo "$vim_version >= 7.4" | bc -l) ] && [ ! $has_ruby_support ]; then
    echo "vim version must be at least 7.4 and must be installed with ruby support"
    install_vim
  else
    echo "vim already installed."
  fi
else
  echo "must have vim installed."
  install_vim
fi

source ~/.bash_profile
