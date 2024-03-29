# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# have to hardcode CPATH b/c catalina + xcode 11 removed /usr/include which breaks a bunch of shit
export CPATH=`xcrun --show-sdk-path`/usr/include
export CPPPATH=`xcrun --show-sdk-path`/usr/include

# Path to your oh-my-zsh installation.
export ZSH=/Users/taylorthompson/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git, virtualenv)

# source $ZSH/oh-my-zsh.sh

# get path from .bash_profile
source /Users/taylorthompson/.bash_profile

# User configuration

# use antigen plugin manager
export ANTIGEN_LOG=~/antigen.log
source ~/antigen.zsh

# load oh-my-zsh library
antigen use oh-my-zsh

# bundles from default repo
antigen bundle git
# antigen bundle venv

# non-default bundles
# antigen bundle popstas/zsh-command-time

# bundle setting overrides

# theme setting
export ALIEN_THEME="modofai"
antigen theme tat2133/talien talien
# antigen theme eendroroy/alien alien
# antigen theme denysdovhan/spaceship-prompt

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/id_rsa"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias please='sudo "$(fc -ln -1)"'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="${PATH}:${HOME}/.krew/bin"
export PATH="$PATH:$HOME/.rvm/bin"

# init pyenv and pyenv virtualenv on start of shell
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
eval "$(direnv hook zsh)"

antigen apply

# standard move word shortcuts
bindkey "[D" backward-word
bindkey "[C" forward-word

log_special() {
    jq -rR '. as $raw | try(fromjson? | if .level == "INFO" then "\u001B[0;36m"
                                        elif .level == "DEBUG" then "\u001B[0;32m"
                                        elif .level == "ERROR" then "\u001B[1;35m"
                                        elif .level == "CRITICAL" then "\u001B[1;31m"
                                        elif .level == "WARNING" then "\u001B[1;33m"
                                        else "" end
                                            + (.time|split(".")[0]|split("T")|join(" "))
                                            + " - " + .level + " - " + .file + ":" + (.lineNumber|tostring)
                                            + " - " + .message + "\u001B[0m")
                         // $raw'
}
l2json() {
    jq -Rr '. as $line | fromjson? // $line'
}
time_test() {
    jq -Rr '. as $line | fromjson? | (.time|strptime("%Y-%m-%dT%H:%M.$S")) // $line'
}
kube-token() {
    kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
}
mount-gin() {
    sshfs gin:/home/taylor/ /Users/taylorthompson/mounts/gin/
}
mount-mezcal() {
    sshfs -o ro gin:/mnt/ /Users/taylorthompson/mounts/mezcal/
}

# export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"
# export PATH="/usr/local/opt/arm-gcc-bin@8/bin:$PATH"
