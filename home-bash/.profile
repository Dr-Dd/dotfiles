export LANG=en_US.UTF-8
export GEM_HOME="$HOME/gems"
export PATH="${HOME}/.local/bin:${PATH}:$(ruby -e 'puts Gem.user_dir')/bin"
