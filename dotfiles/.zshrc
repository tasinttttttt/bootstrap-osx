# Env
export ZSH=$HOME/.oh-my-zsh
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Cleaning PATH from duplicates
export PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')

# Plugins
plugins=(
  brew
  colored-man-pages
  copyfile
  extract
  git
  osx
  web-search
  z
)

# Aliases
alias ip="ifconfig | grep 'inet ' | cut -f2 -d' '"
alias update="source $HOME/.zshrc"
alias wg="wget -mrkp --progress=dot --random-wait -e robots=off"
alias yta="youtube-dl -f bestaudio --embed-thumbnail --add-metadata --extract-audio --audio-format mp3 --audio-quality 320k"
alias yt="youtube-dl --write-description --write-thumbnail --all-subs --convert-subs srt"
alias tsm="transmission-remote"
alias ts="transmission-daemon"
alias ta="tsm -a"
alias tl="tsm -l"
alias tw="while true; do clear; tl; sleep 3; done"

ZSH_THEME="spaceship"

# Inits
. ~/z.sh
. $ZSH/oh-my-zsh.sh
