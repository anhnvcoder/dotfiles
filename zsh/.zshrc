if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting ssh-agent)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=99999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/.fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Bat (better cat) -----

export BAT_THEME=tokyonight_night

alias ls="colorls"

# ---- Eza (better ls) -----

alias l="eza --icons=always"
alias ls="eza --icons=always"
alias ll="eza -lg --icons=always"
alias la="eza -lag --icons=always"
alias lt="eza -lTg --icons=always"
alias lt2="eza -lTg --level=2 --icons=always"
alias lt3="eza -lTg --level=3 --icons=always"
alias lt4="eza -lTg --level=4 --icons=always"
alias lta="eza -lTag --icons=always"
alias lta2="eza -lTag --level=2 --icons=always"
alias lta3="eza -lTag --level=3 --icons=always"
alias lta4="eza -lTag --level=4 --icons=always"

# ---- TheFuck -----

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# ---- Zoxide (better cd) ----
if [[ "$CLAUDECODE" != "1" ]]; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

# ---- Starship -----
eval "$(starship init zsh)"

#export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
#export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
#export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
#export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"
export PATH="/opt/homebrew/opt/php@8.2/sbin:$PATH"
export PATH="/opt/homebrew/opt/php@8.2/bin:$PATH"
export PATH=${PATH}:/usr/local/mysql/bin/
export PATH=$PATH:$(npm get prefix)/bin
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PYTHON="/opt/homebrew/bin/python3"
export PATH="/usr/bin/pip3:$PATH"
export PATH="/usr/bin/python3:$PATH"
export PATH="$HOME/.local/bin:$PATH"

#export HOMEBREW_NO_AUTO_UPDATE=1
export DOCKER_DEFAULT_PLATFORM=linux/amd64

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

alias python=python3
alias pip=pip3
alias ld='lazydocker'
alias lg='lazygit'
alias docker-compose="docker compose"
alias dc="docker-compose"
alias ghc="gh copilot"
alias vim="nvim"
alias y=yarn

# set key to keychain
# security add-generic-password -a "$USER" -s GEMINI_API_KEY -w "YOUR_API_KEY" -U
export GEMINI_API_KEY=$(security find-generic-password -a $USER -s GEMINI_API_KEY -w)
# security add-generic-password -a "$USER" -s FIGMA_ACCESS_TOKEN -w "YOUR_FIGMA_ACCESS_TOKEN" -U
export FIGMA_ACCESS_TOKEN=$(security find-generic-password -a $USER -s FIGMA_ACCESS_TOKEN -w)

# Added by Antigravity
# export PATH="/Users/vas/.antigravity/antigravity/bin:$PATH"

# opencode
export PATH=/Users/vas/.opencode/bin:$PATH

# gnote: generate release notes from git commits grouped by type, usage gnote -h for help
source "$HOME/dotfiles/zsh/custom/gnote.zsh"

# rmix: repomix git wrapper, usage rmix -h for help
source "$HOME/dotfiles/zsh/custom/rmix.zsh"

# setting claude code run with antigravity tool
cca() {
  (
    export PATH="/Users/vas/.antigravity/antigravity/bin:$PATH"
    export ANTHROPIC_API_KEY="sk-antigravity"
    export ANTHROPIC_BASE_URL="http://127.0.0.1:8045"
    export ANTHROPIC_MODEL="claude-opus-4-6-thinking"
    export ANTHROPIC_DEFAULT_OPUS_MODEL="claude-opus-4-6-thinking"
    echo "🚀 Starting Claude with Antigravity proxy..."
    claude "$@"
  )
}

fpath=(/Users/vas/.zsh/completions $fpath)
autoload -Uz compinit && compinit
