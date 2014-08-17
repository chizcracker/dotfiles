#terminal color
#export LC_ALL='ko_KR.UTF-8'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

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

## virtualenv
# projects should be git repositories.
vact(){
  P=$(git rev-parse --show-toplevel)
  echo "applying virtual environment... ($P)"
  cd $P
  source bin/activate
  cd - >/dev/null
}
alias dact='deactivate'

# misc aliases
alias profile='vim ~/.bash_profile'
