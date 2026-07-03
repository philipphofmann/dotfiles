# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#export PATH="/usr/local/texlive/2026basic/bin/universal-darwin:$PATH"
#export PATH="/usr/local/texlive/2026basic/bin/universal-darwin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/philipp/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/philipp/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/philipp/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/philipp/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Load local secrets (API keys, tokens) from a file kept out of version control.
[ -f ~/.zsh_secrets ] && source ~/.zsh_secrets
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- Eza (better ls) -----
alias ls="eza --icons=always"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Dual-pane yazi: second instance in a tmux split to the right,
# yank buffer is synced between them (see ~/.config/yazi/init.lua)
function yy() {
	if [ -n "$TMUX" ]; then
		tmux split-window -h -c "$PWD" yazi
	fi
	y "$@"
}

# ---- Remote mounts on juck (SSHFS over FUSE-T) ----
# juck (129.69.168.22) is only reachable on the uni network or via VPN, like
# the LS3 SMB shares handled by ~/.local/bin/mount-ls3-shares.sh. Files live
# only on the server, nothing is copied to the local disk. Mountpoints live
# under ~/mnt, which we own, so the helper creates them automatically. We stay
# out of /Volumes because macOS deletes empty mountpoints there on unmount.
#
# Shared helpers. $1 = mountpoint name under ~/mnt, $2 = absolute path on juck.
_juck_mount() {
	local name="$1" remote="$2" mnt="$HOME/mnt/$1"
	if mount | grep -q " on $mnt "; then
		echo "$name already mounted at $mnt"
		return 0
	fi
	if ! ssh -o BatchMode=yes -o ConnectTimeout=4 juck true 2>/dev/null; then
		echo "Cannot reach juck over SSH. Connect to the uni network or VPN, then retry."
		return 1
	fi
	if ! mkdir -p "$mnt"; then
		echo "Could not create mountpoint $mnt."
		return 1
	fi
	if sshfs "juck:$remote" "$mnt" \
		-o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,volname="$name"; then
		echo "$name mounted at $mnt"
	else
		echo "Mount failed."
		return 1
	fi
}

_juck_unmount() {
	local name="$1" mnt="$HOME/mnt/$1"
	if ! mount | grep -q " on $mnt "; then
		echo "$name not mounted"
		return 0
	fi
	umount "$mnt" 2>/dev/null || diskutil unmount force "$mnt" >/dev/null 2>&1
	if mount | grep -q " on $mnt "; then
		echo "Unmount failed. Something may still be using $mnt."
		return 1
	fi
	rmdir "$mnt" 2>/dev/null
	echo "$name unmounted"
}

# juck home directory -> ~/mnt/juck
mount-juck()   { _juck_mount   juck /data/homes/hoffmann }
unmount-juck() { _juck_unmount juck }

# enbw-water project (the ~/enbw-water symlink target) -> ~/mnt/enbw-water
mount-enbw-water()   { _juck_mount   enbw-water /data/projects/enbw-water }
unmount-enbw-water() { _juck_unmount enbw-water }

# Run a command on juck and bring its output back here. Usage:
#   juck-run <remote-dir> <command...>
# <remote-dir> is relative to your juck home (e.g. tapfn-test, or enbw-water via
# the ~/enbw-water symlink) or absolute. Runs in a login shell so the server
# profile (PATH, conda/uv, TABPFN_TOKEN) is loaded, with stderr merged into
# stdout so errors come back too. Pass a multi-word command as one quoted string.
# For long jobs, detach on the server and watch the log through the mount, e.g.
#   juck-run tapfn-test 'nohup python3 train.py > run.log 2>&1 & echo started'
juck-run() {
	if [ $# -lt 2 ]; then
		echo "usage: juck-run <remote-dir> <command...>"
		return 2
	fi
	if ! ssh -o BatchMode=yes -o ConnectTimeout=4 juck true 2>/dev/null; then
		echo "Cannot reach juck over SSH. Connect to the uni network or VPN, then retry."
		return 1
	fi
	local dir="$1"; shift
	ssh juck "bash -lc 'cd \"$dir\" && $*' 2>&1"
}