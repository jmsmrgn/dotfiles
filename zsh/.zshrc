# https://github.com/romkatv/zsh4humans/blob/v5/README.md
zstyle ':z4h:' auto-update            'no'
zstyle ':z4h:' auto-update-days       '28'
zstyle ':z4h:bindkey' keyboard        'mac'
zstyle ':z4h:' start-tmux             'no'
zstyle ':z4h:' term-shell-integration 'yes'
zstyle ':z4h:autosuggestions' forward-char 'accept'
zstyle ':z4h:fzf-complete' recurse-dirs 'no'
zstyle ':z4h:direnv'         enable   'yes'
zstyle ':z4h:direnv:success' notify   'yes'
zstyle ':z4h:ssh:*'          enable   'no'
zstyle :omz:plugins:ssh-agent lazy    'yes'

z4h install ohmyzsh/ohmyzsh || return
z4h init || return
z4h source ~/.env.zsh

# PATH
path=(~/bin $path)
export PNPM_HOME="/Users/jmsmrgn/Library/pnpm"
[[ ":$PATH:" == *":$PNPM_HOME:"* ]] || export PATH="$PNPM_HOME:$PATH"

# Mise
eval "$(mise activate zsh)"

# Shell options
setopt AUTO_CD MULTIOS AUTO_PUSHD AUTO_NAME_DIRS
setopt GLOB_COMPLETE GLOB_DOTS NO_CASE_GLOB EXTENDED_GLOB RC_EXPAND_PARAM
setopt NUMERIC_GLOB_SORT PUSHD_TO_HOME PUSHD_IGNORE_DUPS
setopt RM_STAR_WAIT IGNORE_EOF NO_CLOBBER NO_AUTO_MENU

# Functions
autoload -Uz zmv
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Shell
alias reload="exec zsh"
alias ls="${aliases[ls]:-ls} -A"
alias tree="tree -a -I .git"
alias et="rm -rf ~/.Trash/*"

# Network
alias ports="sudo lsof -i -P | grep LISTEN"
alias killport="kill -9 \$(lsof -ti:"

# Mise
alias mi="mise install"
alias mu="mise use"

# Node / PNPM
alias pn="pnpm"
alias dev="pnpm dev"
alias build="pnpm build"
alias preview="pnpm build && pnpm start"
alias npm-global="npm list -g --depth=0"
alias npm-local="npm list --depth=0"

# Key bindings
z4h bindkey undo Ctrl+/   Shift+Tab
z4h bindkey redo Option+/
z4h bindkey z4h-cd-back    Shift+Left
z4h bindkey z4h-cd-forward Shift+Right
z4h bindkey z4h-cd-up      Shift+Up
z4h bindkey z4h-cd-down    Shift+Down

bindkey -s "^[Op" "0"; bindkey -s "^[On" "."; bindkey -s "^[OM" "^M"
bindkey -s "^[Oq" "1"; bindkey -s "^[Or" "2"; bindkey -s "^[Os" "3"
bindkey -s "^[Ot" "4"; bindkey -s "^[Ou" "5"; bindkey -s "^[Ov" "6"
bindkey -s "^[Ow" "7"; bindkey -s "^[Ox" "8"; bindkey -s "^[Oy" "9"
bindkey -s "^[Ol" "+"; bindkey -s "^[Om" "-"; bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"; bindkey -s "^[Ok" "+"; bindkey -s "^[OX" "="

# Starting directory
cd ~/git
