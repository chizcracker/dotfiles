#terminal color
export LC_ALL='ko_KR.UTF-8'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

[[ -r ~/.bashrc ]] && . ~/.bashrc
export PATH=$HOME/bin:$PATH

#vcprompt
#export PS1='\[\e[0;32m\]\u@\h \[\e[0;37m\]\W\[\e[0;31m\] $(vcprompt -f '[%b@%r%m%u%a]')\[\033[00m\]$ '
make_prompt() {
  color_green='\[\e[0;32m\]'
  color_undblu='\[\e[4;34m\]'
  color_undylw='\[\e[4;33m\]'
  color_red='\[\e[01;31m\]'
  color_white='\[\e[0;37m\]'

  PRMT_TIME="$color_green[\t]"
  PRMT_STAT="\`if [ \$? = 0 ]; then echo -e '$color_undblu(°))<<'; else echo -e '$color_undylw(⁎˃ᆺ˂)'; fi\`"
  PRMT_CDIR="$color_white\W"
  PRMT_VC=$color_red'$(vcprompt -f '[%b@%r%m%u%a]')\[\033[00m\]$ '
  echo $PRMT_TIME $PRMT_STAT $PRMT_CDIR $PRMT_VC ''
}
export PS1=$(make_prompt)
unset -f make_prompt

# git bash-complete
# brew install bash-completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# tmux
alias tmux_attach='tmux attach -t'

## virtual environment
# projects should be git repositories.
vact(){
  P=$(git rev-parse --show-toplevel)
  echo "applying virtual environment... ($P)"
  cd $P

  if [ $1 = "python" ]
  then
    source bin/activate
    cd - >/dev/null
    alias dact='deactivate'
  elif [ $1 = "node" ]
  then
    source env/bin/activate
    export PATH=$NPM_CONFIG_PREFIX/../node_modules/.bin:$PATH
    cd - >/dev/null
    alias dact='deactivate_node'
  fi
}

# ctags
git-files() {
  git ls-tree --full-tree -r --name-only HEAD
}

re-ctags() {
  if [ -f .tags ] ; then
    rm .tags
  fi
  #ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./.tags $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))")
  ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./.tags ./
}
