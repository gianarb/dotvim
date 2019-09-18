export DOTFILES="$HOME/.dotfiles"
export PATH="$HOME/.dotfiles/bin:$HOME/.dotfiles/vendor/bin:$PATH:/opt/bin:/home/gianarb/go/bin:/home/gianarb/.local/bin:/home/gianarb/.gem/ruby/2.5.0/bin:$HOME/bin"
export EDITOR=vim
export XDG_CONFIG_HOME=$HOME/.config
export LS_OPTS='--color=auto'

#
# This directory contains all the command replaced with a docker container.
# By default it's disable but you can enable it in your ~/.bashrc
# PATH="$DOTFILES/docker-bin:$PATH'

alias ll='ls ${LS_OPTS} -lsah'
alias myip='curl ipinfo.io/ip'
alias less='less --RAW-CONTROL-CHARS'
alias ls='ls ${LS_OPTS}'

alias sl=ls
alias mdkir=mkdir
alias soruce=source
alias souce=source
alias vi=vim
alias clipc='xclip -in -selection clipboard'

alias g=git
alias d=docker

alias gs='git show --pretty=oneline'
alias gpom='git push origin master'
alias gpod='git push origin develop'
alias gfpu='git fetch upstream && git pull upstream develop'
alias grom='git reset --hard origin/master'
alias gp='git pull'
alias shm="source ~/.bashrc"

# Reference
alias alphabet='echo a b c d e f g h i j k l m n o p q r s t u v w x y z'
alias unicode='echo ✓ ™  ♪ ♫ ☃ ° Ɵ ∫'
alias numalphabet='alphabet; echo 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6'
alias ascii='man ascii | grep -m 1 -A 63 --color=never Oct'

#
# Load bash git prompt
#
source $DOTFILES/bash-git-prompt/gitprompt.sh
GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_THEME_NAME="Single_line" # needed for reload optimization, should be unique

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
source <(kubectl completion bash)


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source /usr/share/nvm/init-nvm.sh

export JAVA_HOME=/usr/lib/jvm/java-10-openjdk
export ANDROID_HOME=/home/gianarb/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export ANDROID_SDK_HOM=$ANDROID_HOME

export PATH=${PATH}:$ANDROID_HOME/tools/bin
export PATH=${PATH}:$ANDROID_HOME/tools
export PATH=${PATH}:$ANDROID_HOME/platform-tools
export PATH=${PATH}:$ANDROID_SDK/emulator
export PATH=${PATH}:/home/gianarb/.cargo/bin

GOPROXY=https://proxy.golang.org
