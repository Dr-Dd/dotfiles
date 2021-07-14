#
# ~/.bash_profile
#

# opam configuration
test -r /home/drd/.opam/opam-init/init.sh && . /home/drd/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# source .bashrc and .profile
if [ -n "$BASH" ] && [ -r ~/.bashrc ]; then
  . ~/.bashrc
fi
[[ -f ~/.profile ]] && . ~/.profile


