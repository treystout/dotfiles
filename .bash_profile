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
alias vi=vim
alias iv=vim
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
  ps1="$ps1 ${GREEN}$prompt_char${NORMAL} " # prompt
  export PS1=$ps1
}

if [ -f ~/.agent.env ] ; then
  . ~/.agent.env > /dev/null
if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
  echo "Stale agent file found. Starting new agent"
  eval `ssh-agent | tee ~/.agent.env`
  ssh-add
fi
else
  echo "starting ssh-agent"
  eval `ssh-agent | tee ~/.agent.env`
fi

export TERM=xterm-256color
export EDITOR=vim
export PROMPT_COMMAND=ps1_set
export GOPATH=$HOME/go
export GOROOT=/usr/local/src/go
export GOAPPENGINEPATH=/usr/local/src/go_appengine
export PATH=/usr/local/git/bin::$GOPATH/bin:$GOROOT/bin:$GOAPPENGINEPATH:$PATH
# don't offer to tab-complete python local packages
export FIGNORE=egg-info

