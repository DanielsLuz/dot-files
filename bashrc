# =====================================================================================================================
# Basic settings
# =====================================================================================================================

xhost +local:root > /dev/null 2>&1
complete -cf sudo

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob
# Autocd to directory
shopt -s autocd

# Disable CTRL-S / CTRL-Q
stty ixany
stty ixoff -ixon

# =====================================================================================================================
# Aliases
# =====================================================================================================================

# Navigation
alias ..='cd ..'                          # Go up one directory
alias ...='cd ../..'                      # Go up two directories
alias ....='cd ../../..'                  # Go up three directories
alias cdd='cd -'                          # Go back where you were

# Files and directories
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias md='mkdir -p'
alias rd='rmdir'

# APT-GET
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias dist-upgrade='sudo apt-get dist-upgrade'
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias purge='sudo apt-get purge'
alias autoremove='sudo apt-get autoremove'

# Services
alias ss='sudo service'
alias ssmysql='sudo service mysql start'
alias sspgsql='sudo service postgresql start'

# Applications
alias g='git'
alias v='vim'
alias msql='mysql -uroot -p'

# Rails
alias r='rails'

# Rake
alias dbc='rake db:create'
alias dbm='rake db:migrate'
alias dbs='rake db:seed'
alias dbd='rake db:drop'

# Bundler
alias be='bundle exec'
alias bi='bundle install'
alias bl='bundle list'
alias bu='bundle update'
alias bp='bundle package'

# SSH servers
alias s-pinta='ssh team11@calculon.fiit.stuba.sk -p 30022'
alias s-nitrous='ssh action@euw1-2.nitrousbox.com -p 21326'

# Other
alias _="sudo"
alias q='exit'

# =====================================================================================================================
# Functions
# =====================================================================================================================

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		echo " [${BRANCH}]"
	else
		echo ""
	fi
}

# get ruby version
function get_ruby_version {
  echo -n $(ruby -v | cut -d ' ' -f 2)
}

# =====================================================================================================================
# Prompt line
# =====================================================================================================================

export PS1="\[\e[36m\]\w\[\e[m\]\[\e[33m\]\`parse_git_branch\` \[\e[m\]\[\e[31m\][\$(get_ruby_version)]\[\e[m\] \$ "

# =====================================================================================================================
# Completions
# =====================================================================================================================

# Bash autocomplete
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Tmuxinator autocompletion
if [ -f ~/bin/completion/tmuxinator.bash ]; then
  source ~/bin/completion/tmuxinator.bash
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# RVM Init, RVM bash completion
[[ -r /usr/local/rvm/scripts/completion ]] && . /usr/local/rvm/scripts/completion

# =====================================================================================================================
# Path setting and export
# =====================================================================================================================

# Add RVM to PATH for scripting
PATH=$PATH:/home/martin/.gem/ruby/2.0.0/bin
export PATH
PATH=$PATH:$HOME/.rvm/bin
export PATH

# =====================================================================================================================
# Other exports
# =====================================================================================================================

export EDITOR=vim
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
