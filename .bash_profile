#terminal color
export LC_ALL='ko_KR.UTF-8'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

[[ -r ~/.bashrc ]] && . ~/.bashrc
export PATH=$HOME/bin:$PATH

#vcprompt
#export PS1='\[\e[0;32m\]\u@\h \[\e[0;37m\]\W\[\e[0;31m\] $(vcprompt -f '[%b@%r%m%u%a]')\[\033[00m\]$ '
make_prompt() {
  local color_green='\[\e[0;32m\]'
  local color_undblu='\[\e[4;34m\]'
  local color_undylw='\[\e[4;33m\]'
  local color_red='\[\e[01;31m\]'
  local color_white='\[\e[0;37m\]'

  local PRMPT_TIME="$color_green[\t]"
  local PRMPT_STAT="\`if [ \$? = 0 ]; then echo -e '$color_undblu(°))<<'; else echo -e '$color_undylw(⁎˃ᆺ˂)'; fi\`"

  local PRMPT_CDIR="$color_white\W"
  local PRMPT_VC=$color_red'$(vcprompt -f '[%b@%r%m%u%a]')\[\033[00m\]$ '
  echo $PRMT_TIME $PRMT_STAT $PRMT_CDIR $PRMT_VC ''
}
export PS1=$(make_prompt)
unset -f make_prompt

# git bash-complete
# brew install bash-completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# tmux
alias tmux_attach='tmux attach -t'

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
