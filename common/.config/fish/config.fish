# . ~/.env

# You should set up path in /etc/fish/conf.d/bin.fish
# set -gx PATH $PATH ~/bin

# OPAM configuration
. ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true

set -gx EDITOR "ec -c"

set NPM_PACKAGES "$HOME/.npm-packages"
set PATH $PATH $NPM_PACKAGES/bin
set MANPATH $NPM_PACKAGES/share/man $MANPATH
