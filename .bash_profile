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
alias bp='mvim -v ~/.bash_profile'
alias vi='mvim -v'
alias vim='mvim -v'
alias iv='mvim -v'
alias ..='source ~/.bash_profile'
alias f='grep -rI --include=*.py --include=*.ini --include=*.yaml --include=*.sh --include=*.conf --include=*.wsgi --include=*.js --include=*.j2 --exclude-dir=bootstrap* --exclude-dir=thirdparty --exclude-dir=site-packages --exclude-dir=node_modules'
alias dc='docker-compose'
alias ngrok_up='/Applications/ngrok http -subdomain=trey 5000'

# setup solarized dircolors (make sure you symlink ~/.dircolors to the one from dotfiles
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi  
UNDL="\\[$(tput sgr 0 1)\\]"
BOLD="\\[$(tput bold)\\]"
printf -v NORMAL "\x1B[0m"
printf -v RED "\x1B[31m"

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
#SYM_BRANCH="λ"
SYM_BRANCH="⏚"


git_info() {
  # we're inside a git repo, check the status and branch name
  # then show the branch name in different colors depending on
  # our local status
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"
  local unstaged="Changes not staged"
  local ahead="Your branch is ahead"
  local nothing="nothing added to commit"
  local git_status="$(git status 2>/dev/null)"
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
  #local prompt_char="▼"
  local prompt_char="➤"

  ps1+="$NORMAL\!" # history counter
  ps1+=" $WHITE\t" # time of day
  ps1+=" $NORMAL[$BLUE\w$NORMAL]" # working directory
  ps1+=" J:$PURPLE\j" # job count
  #if [ -n "$VIRTUAL_ENV" ]; then
  #  ps1+=" $GREEN$(basename $VIRTUAL_ENV)$NORMAL "
  #else
  #  ps1+=" $BGRED$WHITE"
  #  ps1+="!$NORMAL "
  #fi
  if [ -d .git ]; then
    ps1+=" $(git_info)$NORMAL"
  fi
  ps1+=" \$(exit_code) $WHITE$prompt_char$NORMAL " # prompt
  export PS1=$ps1
}

exit_code() {
  local exitCode=$?
  if ((exitCode)); then
    echo -en "\033[31mERR \033[m";
  else
    echo -en "\033[32mOK  \033[m";
  fi
}

# tell /bin/ls to color output
export CLICOLOR=1
export TERM=xterm-256color
export EDITOR="mvim -v"
export PROMPT_COMMAND=ps1_set
# don't offer to tab-complete python local packages
export FIGNORE=egg-info
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export GOPATH=$HOME/go
export PATH=/usr/local/bin:/usr/local/git/bin:$PATH:$GOPATH/bin

eval $(docker-machine env default)
