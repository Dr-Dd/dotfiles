# System
export LANG="en_US.UTF-8"
export PATH="${HOME}/.local/bin:${PATH}:$(ruby -e 'puts Gem.user_dir')/bin:${HOME}/.cargo/bin"
export CHROOT="$HOME/chroot"
export COUNTRY="IT"
export COMP_KNOWN_HOSTS_WITH_HOSTFILE=""

# Terminal
export TERM="/usr/bin/alacritty"
export TERMINAL="/usr/bin/alacritty"
export HISTCONTROL="erasedups:ignorespace"
export PROMPT_DIRTRIM=2

# Editors
export VISUAL="/usr/bin/vim"
export EDITOR="/usr/bin/vim"

# Qt
export QT_STYLE_OVERRIDE="kvantum"
export QT_QPA_PLATFORMTHEME="gtk2"

# Less
export LESSHISTFILE="/dev/null"

# Locate
# Custom envars for chron scripts
export MLOCATE_DATA_PRUNED_PATHS="media/data/.Trash-1000 /media/data/wine-pc /media/data/System\ Volume\ Information/ /media/data/SteamLibrary /media/data/Recovery /media/data/MSPCache /media/data/msdownld.tmp /media/data/found.000 /media/data/\$RECYCLE.BIN /media/data/Music"
export MLOCATE_HOME_PRUNED_PATHS="$HOME/chroot $HOME/gems $HOME/go $HOME/key-tools $HOME/proton $HOME/.cache $HOME/.bundle $HOME/.config $HOME/.dwarffortress $HOME/.eclipse $HOME/.emacs.d/anaconda-mode $HOME/.emacs.d/elpa $HOME/.emacs.d/emojis $HOME/.gem $HOME/.local/lib $HOME/.local/share $HOME/.m2 $HOME/.npm $HOME/.opam $HOME/music $HOME/Android"

# Ruby
export GEM_HOME="$HOME/gems"

# Browser 
export BROWSER="firefox"

# pkg-config
export PKG_CONFIG_PATH="/usr/lib/pkgconfig/"

# Video
export LIBVA_DRIVER_NAME="vdpau"
export VDPAU_DRIVER="nvidia"

# X11
export XMODIFIERS="@im=fcitx"

# XDG Base directories
export XDG_CONFIG_HOME="$HOME/.config"

# Gtags
export GTAGSLABEL="ctags"
export GTAGSCONF="/usr/share/gtags/gtags.conf"

# Input method
export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"

# Wine 
export WINEDEBUG="fps"

# Dictionary 
export DICPATH="/usr/share/hunspell"

# Vulkan 
export VK_ICD_FILENAMES="/usr/share/vulkan/icd.d/nvidia_icd.json"

# Steam environment variables
export STEAM_FRAME_FORCE_CLOSE=1
export STEAM_COMPAT_DATA_PATH="$HOME/proton"

# Sound card
export SOUND_CARD_PCI_ID="00:1f.3"

# Start ssh-agent session wide
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
	    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
	    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

