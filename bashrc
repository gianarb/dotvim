DOTFILES="$HOME/.dotfiles"
PATH="$HOME/.dotfiles/bin:$HOME/.dotfiles/vendor/bin:$PATH:/opt/bin"

#
# This directory contains all the command replaced with a docker container.
# By default it's disable but you can enable it in your ~/.bashrc
# PATH="$DOTFILES/docker-bin:$PATH'

alias tmux='TERM=screen-256color tmux'
alias ll='ls -lsa'

#
# Load bash git prompt
#
GIT_PROMPT_ONLY_IN_REPO=0
source $DOTFILES/bash-git-prompt/gitprompt.sh

export XDG_CONFIG_HOME=$HOME/.config

#
# FZF plugins
#
export FZF_DEFAULT_COMMAND="find -L * -path '*/\.*' -prune -o -type f -print -o -type l -print 2> /dev/null"

_history() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

git_log() {
  local out sha q
  while out=$(
      git log --decorate=short --graph --oneline --color=always |
      fzf --ansi --multi --no-sort --reverse --query="$q" --print-query); do
    q=$(head -1 <<< "$out")
    while read sha; do
      [ -n "$sha" ] && git show --color=always $sha | less -R
    done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
  done
}

source $DOTFILES/bash/git-completion
source $DOTFILES/bash/docker-completion
