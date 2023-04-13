# . ~/.env

# You should set up path in /etc/fish/conf.d/bin.fish
# set -gx PATH $PATH ~/bin

# OPAM configuration
. ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true

set -gx EDITOR vim
