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

brew_install() {
  if ! brew ls --versions $1 > /dev/null; then
    brew install $1
  fi
}

echo 'installing brew packages ...'
brew_install ack
brew_install ctags
brew_install reattach-to-user-namespace
brew_install git
brew_install bash-completion

echo 'installing vcprompt ... '
mkdir ~/bin
curl -sL https://github.com/djl/vcprompt/raw/master/bin/vcprompt > ~/bin/vcprompt
chmod 755 ~/bin/vcprompt

timestamp=$(date +%s)
echo 'backing up current config files ...'
mkdir -p ~/settings/backup
cp ~/.bash_profile ~/settings/backup/.bash_profile_$timestamp
cp ~/.tmux.conf ~/settings/backup/.tmux.conf_$timestamp
cp ~/.vimrc ~/settings/backup/.vimrc_$timestamp

echo 'copying config files ...'
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp $DIR/.bash_profile ~/
cp $DIR/.tmux.conf ~/
cp $DIR/.vimrc ~/

echo 'checking vim compatibility ...'

has_vim=$(command -v vim >/dev/null)
if $has_vim; then
  vim_version=$(vim --version | head -1 | cut -d ' ' -f 5)
  has_ruby_support=$(vim --version | grep -c ruby)
  has_clipboard_support=$(vim --version | grep -c +clipboard)

  if [ ! $(echo "$vim_version >= 7.4" | bc -l) ] && [ ! $has_ruby_support ] && [ ! $has_clipboard_support ]; then
    echo "vim version must be at least 7.4"
    echo "must be installed with ruby support"
    echo "must be installed with clipboard support"
    brew install vim --override-system-vim
  else
    echo "vim already installed."
  fi
else
  echo "must have vim installed."
  brew install vim --override-system-vim
fi

echo 'creating necessary vim folders ...'
mkdir ~/.vim/swap
mkdir ~/.vim/undo
mkdir ~/.vim/backup

echo 'installing vim-plug ...'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo 'installing vim plugins ...'
vim +:PlugInstall +qall

echo 'please change Iterm2 config for the Solarized color profile ...'
echo 'https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized'

echo 'installing python envs'
brew_install pyenv
echo 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile

brew_install pyenv-virtualenv
echo 'if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

echo 'done!!'
