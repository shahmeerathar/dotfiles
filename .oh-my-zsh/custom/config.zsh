# Aliases
alias zshrc="vim ~/.zshrc"
alias addalias="vim $ZSH/custom/config.zsh" 
alias brewtree="brew deps --tree --installed"
alias dev="cd ~/Developer"
alias tree="ls --long --tree"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias espidf=". ~/Developer/esp32/esp-idf/export.sh"

# eza
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --exclude "Pictures/Photos Library.photoslibrary/" --exclude Movies/TV --exclude Music/Music --exclude Library/ --exclude .zsh_sessions --exclude .DS_Store --exclude .nvm/ --exclude .npm --exclude .cache/ --exclude .oh-my-zsh/themes --exclude .oh-my-zsh/plugins --exclude .oh-my-zsh/lib --exclude .oh-my-zsh/.github --exclude .oh-my-zsh/tools --exclude .tldrc/ --exclude .dotfiles/'
export FZF_DEFAULT_OPTS="--height 40% --layout reverse --border"
alias fzfpreview='fzf --preview="bat --color=always {}" --height=100% --border=none --layout=default'

# nvm
# Lazy loading nvm. From:
# https://github.com/undg/zsh-nvm-lazy-load/blob/master/zsh-nvm-lazy-load.plugin.zsh
typeset -ga __lazyLoadLabels=(nvm node npm npx pnpm yarn pnpx bun bunx)

__load-nvm() {
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

__work() {
    for label in "${__lazyLoadLabels[@]}"; do
        unset -f $label
    done
    unset -v __lazyLoadLabels

    __load-nvm
    unset -f __load-nvm __work
}

for label in "${__lazyLoadLabels[@]}"; do
    eval "$label() { __work; $label \$@; }"
done
