# COMMANDES D'INSTALLATION
# ------------------------
# git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
# sudo apt-install fonts-powerline
# git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
# wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/Hack.zip
# mkdir hack && unzip Hack.zip -d hack
# sudo mv hack /usr/share/fonts/truetype
# fc-cache -f -v

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export TERM="xterm-256color"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="fishy"
# ZSH_THEME="powerlevel9k/powerlevel9k"

# Config du prompt
POWERLEVEL9K_TIME_FORMAT="%D{\uf073 %d/%m/%y \ue383 %H:%M}"
POWERLEVEL9K_CUSTOM_DEBIAN_ICON="echo -e '\uf306'"
POWERLEVEL9K_CUSTOM_DEBIAN_ICON_BACKGROUND=234
POWERLEVEL9K_CUSTOM_DEBIAN_ICON_FOREGROUND=196
POWERLEVEL9K_ROOT_ICON="\uf198"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND=196
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND=232
POWERLEVEL9K_BATTERY_STAGES=($'\uf244' $'\uf243' $'\uf242' $'\uf241' $'\uf240')
POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND=(196 208 226 118 46)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_debian_icon root_indicator dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time battery)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\u256d\u2500 "
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\u2570\uf460 "
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

plugins=(zsh-autosuggestions)
# Configuration de l'historique pour zsh-autosuggestions
HISTSIZE=3000             # nb lignes en memoire
HISTFILE=~/.zsh_history   # fichier de sauvegarde
SAVEHIST=3000             # nb entrees a enregistrer
HISTDUP=erase             # suppression des doublons
setopt appendhistory      # ajout des entrees en mode append
setopt sharehistory       # partge de l'historique entre terminaux
setopt incappendhistory   # ajout imm�diat a l'historique
setopt correct            # proposition de correction

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  z
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'ranger\n'

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
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
