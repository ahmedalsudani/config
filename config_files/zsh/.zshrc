# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="frisk"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias myssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/.AWS-ElasticBeanstalk-CLI-2.6.0/eb/linux/python2.7:$HOME/.cabal/bin:$HOME/bin:$PATH:$HOME/.gem/ruby/2.2.0/bin #Unecessary: /usr/local/bin:
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Evaluate virtualenv
# source /usr/local/bin/virtualenvwrapper.sh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#Confirm rm
alias rm="rm -i"

# Add android tools to PATH
export PATH="$HOME/.android-sdk-linux/tools:$HOME/.android-sdk-linux/platform-tools:$PATH"

# Add Elm to PATH
export PATH="$HOME/.elm/.cabal-sandbox/bin:$PATH"

# Add Pandoc to PATH
export PATH="$HOME/.pandoc/.cabal-sandbox/bin:$PATH"

# auto sudo tarsnap
alias tarsnap="sudo tarsnap"

BACKUP_DIRECTORIES=(Documents code)

#thefuck
alias fuck='eval $(thefuck $(fc -ln -1))'

export NVM_DIR="/home/ahmed/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export TERMINAL=gnome-terminal

[ "$TTY" = /dev/tty1 ] && startx

# This is only here because gnome-terminal wasn't preserving directories
# when I created new tabs
. /etc/profile.d/vte.sh
