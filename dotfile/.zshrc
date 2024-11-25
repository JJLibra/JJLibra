pokemonc -r --no-title | fastfetch --file-raw -

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git z copypath copyfile copybuffer sudo zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search you-should-use)

source $ZSH/oh-my-zsh.sh

alias c="clear"

# Alias for ls replacement: eza
alias ls="eza --icons"
alias ll="eza --icons --long --header"
alias la="eza --icons --long --header --all"
alias lg="eza --icons --long --header --all --git"
alias tree="eza --icons --tree"

# Alias for cd replacement: zoxide
export PATH="$HOME/.local/bin:$PATH"
eval "$(zoxide init --cmd cd zsh)"
alias cd=z

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> plugins configuration >>>
# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=(bg=none,fg=magenta,bold)

# you-should-use
export YSU_MESSAGE_POSITION="after"
# <<< plugins configuration <<<

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

