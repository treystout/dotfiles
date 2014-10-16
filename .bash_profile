alias l='ls --color=auto -aF'
alias ll='ls --color=auto -alF'
alias lll='ls --color=auto -alF | less'
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
alias bp='vim ~/.bash_profile'
alias ..='source ~/.bash_profile'
alias f='grep -rI --include=*.py --include=*.ini --include=*.yaml --include=*.sh --include=*.conf --include=*.wsgi --include=*.js --include=*.j2 --exclude-dir=bootstrap* --exclude-dir=thirdparty --exclude-dir=site-packages'

# setup solarized dircolors (make sure you symlink ~/.dircolors to the one from dotfiles
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi  
UNDL="\\[$(tput sgr 0 1)\\]"
BOLD="\\[$(tput bold)\\]"
NORMAL="\\[$(tput sgr0)\\]"

BGRED="\\[$(tput setab 1)\\]"
BGGREEN="\\[$(tput setab 2)\\]"
BGBLUE="\\[$(tput setab 4)\\]"
BGWHITE="\\[$(tput setab 7)\\]"

BLACK="\\[$(tput setaf 0)\\]"
RED="\\[$(tput setaf 1)\\]"
GREEN="\\[$(tput setaf 2)\\]"
YELLOW="\\[$(tput setaf 3)\\]"
BLUE="\\[$(tput setaf 4)\\]"
PURPLE="\\[$(tput setaf 5)\\]"
CYAN="\\[$(tput setaf 6)\\]"
WHITE="\\[$(tput setaf 7)\\]"

SYM_RADIOACTIVE=""
SYM_BRANCH="λ"

git_info() {
  # we're inside a git repo, check the status and branch name
  # then show the branch name in different colors depending on
  # our local status
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"
  local unstaged="Changes not staged"
  local ahead="Your branch is ahead"
  local nothing="nothing added to commit"
  local git_status="$(git status -u no 2>/dev/null)"
  local out=""

  if [[ $git_status =~ $unstaged ]]; then
    out+="$YELLOW"
  elif [[ $git_status =~ $ahead ]]; then
    out+="$RED"
  elif [[ $git_status =~ $nothing ]]; then
    out+="$GREEN"
  else
    out+="$NORMAL"
  fi

  if [[ $git_status =~ $on_branch ]]; then
    out+="$SYM_BRANCH ${BASH_REMATCH[1]}"
  elif [[ $git_status =~ $on_commit ]]; then
    out+="${BASH_REMATCH[1]}"
  fi
  echo -e $out;
}

ps1_set() {
  local ps1=""
  local prompt_char="▼"
  local user_color=$BLUE

  if [[ $UID -eq 0 ]] ; then
    prompt_char='#'
    user_color=$RED
  fi

  ps1+="$NORMAL\!" # history counter
  ps1+=" $WHITE\t" # time of day
  #ps1+=" $user_color\u" # username
  #ps1+="${NORMAL}@" # separator
  #ps1+="${YELLOW}\h" # hostname
  ps1+="$NORMAL [$BLUE\w$NORMAL]" # working directory
  ps1+=" J:$PURPLE\j" # job count
  if [ -n "$VIRTUAL_ENV" ]; then
    ps1+=" $GREEN$(basename $VIRTUAL_ENV)$NORMAL "
  else
    ps1+=" $BGRED$WHITE"
    ps1+="!$NORMAL "
  fi
  if [ -d .git ]; then
    ps1+="$(git_info)$NORMAL"
  fi
  ps1+=" $YELLOW$prompt_char$NORMAL " # prompt
  PS1=$ps1
}

#if [ -f ~/.agent.env ] ; then
#  . ~/.agent.env > /dev/null
#if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
#  echo "Stale agent file found. Starting new agent"
#  eval `ssh-agent | tee ~/.agent.env`
#  ssh-add
#fi
#else
#  echo "starting ssh-agent"
#  eval `ssh-agent | tee ~/.agent.env`
#fi

export TERM=xterm-256color
export EDITOR=vim
export PROMPT_COMMAND=ps1_set
export PATH=$PATH:/usr/local/git/bin
# don't offer to tab-complete python local packages
export FIGNORE=egg-info
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

