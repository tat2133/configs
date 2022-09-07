if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi

# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# alias ggrep so it has colors
alias ggrep='ggrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
