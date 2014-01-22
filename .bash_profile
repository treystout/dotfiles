alias l='ls -aF'
alias ll='ls -alF'
alias lll='ls -alF | less'
alias cp='cp -i'
alias rm='rm -i'
alias cls='clear'
alias p='ps fxa'
alias u='cd $OLDPWD'
alias grep='grep --colour=auto'
alias s='git status'
alias d='git diff'
alias tree='tree -AC'
alias f='grep -rI --include=*.py --include=*.ini --include=*.yaml --include=*.sh --include=*.conf --include=*.wsgi --include=*.js --include=*.j2'

NORMAL='\[\033[0m\]'
BLUE='\[\033[00;34m\]'
GREY='\[\033[02;37m\]'
YELLOW='\[\033[0;33m\]'
PURPLE='\[\033[0;35m\]'
GREEN='\[\033[00;32m\]'
RED_BOLD='\[\033[01;31m\]'
SYM_RADIOACTIVE='\u2622'
SYM_BRANCH='\u2387'

ps1_set() {
  local ps1=""
  local prompt_char='⎆'
  local user_color=$BLUE

  if [[ $UID -eq 0 ]] ; then
    prompt_char='#'
    user_color=$RED_BOLD
  fi

  ps1="$ps1\! " # history counter
  ps1="$ps1${GREY}\t " # time of day
  ps1="$ps1${user_color}\u" # username
  ps1="$ps1${NORMAL}@" # separator
  ps1="$ps1${YELLOW}\h " # hostname
  ps1="$ps1${NORMAL}[${BLUE}\w${NORMAL}]" # working directory
  ps1="$ps1 J:${PURPLE}\j${NORMAL}" # job count
  if [ -n "$VIRTUAL_ENV" ]; then
    ps1="$ps1 (${GREEN}$(basename $VIRTUAL_ENV)${NORMAL})"
  fi
  if [ -d .git ]; then
    local branch=$(git branch --no-column --no-color 2> /dev/null | grep '^*' | colrm 1 2)
    #echo "branch is >$branch<"
    if [[ $branch != "master" ]]; then
      ps1="$ps1 [${PURPLE}${branch}${NORMAL}]"
    fi
  fi
  if [ -d .hg/store ]; then
    local branch=$(hg branch 2> /dev/null)
    if [ $branch != "default" ]; then
      ps1="$ps1 [${PURPLE}${branch}${NORMAL}]"
    fi
  fi  
  ps1="$ps1 ${GREEN}$prompt_char${NORMAL} " # prompt
  export PS1=$ps1
}

export TERM=xterm-256color
export EDITOR=vim
export PATH=/opt/chef/bin:/usr/local/git/bin:$PATH
export PROMPT_COMMAND=ps1_set
