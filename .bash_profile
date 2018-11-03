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
alias bp='nvim ~/.bash_profile'
alias vi='nvim'
alias vim='nvim'
alias iv='nvim'
alias ..='source ~/.bash_profile'
alias f='grep -rI --include=*.py --include=*.ini --include=*.yaml --include=*.sh --include=*.conf --include=*.wsgi --include=*.js --include=*.j2 --exclude-dir=bootstrap* --exclude-dir=thirdparty --exclude-dir=site-packages --exclude-dir=node_modules'
alias dc='docker-compose'
alias ngrok_up='/Applications/ngrok http -subdomain=trey 5000'

# setup solarized dircolors (make sure you symlink ~/.dircolors to the one from dotfiles
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi  
UNDL="\\001$(tput sgr 0 1)\\002"
BOLD="\\001$(tput bold)\\002"
NORMAL="\\001$(tput sgr0)\\002"

BGRED="\\001$(tput setab 1)\\002"
BGGREEN="\\001$(tput setab 2)\\002"
BGBLUE="\\001$(tput setab 4)\\002"
BGWHITE="\\001$(tput setab 7)\\002"

BLACK="\\001$(tput setaf 0)\\002"
RED="\\001$(tput setaf 1)\\002"
GREEN="\\001$(tput setaf 2)\\002"
YELLOW="\\001$(tput setaf 3)\\002"
BLUE="\\001$(tput setaf 4)\\002"
PURPLE="\\001$(tput setaf 5)\\002"
CYAN="\\001$(tput setaf 6)\\002"
WHITE="\\001$(tput setaf 7)\\002"

SYM_RADIOACTIVE=""
#SYM_BRANCH="λ"
SYM_BRANCH="⎇"


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

job_count() {
  local jcount=$(jobs | wc -l)
  if [[ $jcount == "0" ]]; then
    echo ""
  else
    echo "$WHITE🜉 ${PURPLE}$jcount"
  fi
}

ps1_set() {
  local ps1=""
  local prompt_char="⌁"

  ps1+="$NORMAL\!" # history counter
  ps1+=" $WHITE\t" # time of day
  ps1+=" $NORMAL$BLUE\u$GREEN\h"
  ps1+=" $NORMAL⁅$WHITE\w$NORMAL⁆" # working directory
  ps1+=" $(job_count)" # job count
  #if [ -n "$VIRTUAL_ENV" ]; then
  #  ps1+=" $GREEN$(basename $VIRTUAL_ENV)$NORMAL "
  #else
  #  ps1+=" $BGRED$WHITE"
  #  ps1+="!$NORMAL "
  #fi
  if [ -d .git ]; then
    ps1+=" $(git_info)$NORMAL"
  fi
  ps1+=" \$(exit_code) $GREEN$prompt_char$NORMAL " # prompt
  export PS1=$ps1
}

exit_code() {
  local exitCode=$?
  if ((exitCode)); then
    echo -en "${RED}🕱${NORMAL}"
  else
    echo -en "${GREEN}🗸${NORMAL}"
  fi
}

# tell /bin/ls to color output
export CLICOLOR=1
export TERM=xterm-256color
export EDITOR="nvim"
export PROMPT_COMMAND=ps1_set
# don't offer to tab-complete python local packages
export FIGNORE=egg-info
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export GOPATH=$HOME/go
export PATH=/bin:/sbin:/usr/local/bin:/usr/local/git/bin:$PATH:$GOPATH/bin
