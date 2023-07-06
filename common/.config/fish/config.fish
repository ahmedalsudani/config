# . ~/.env

# You should set up path in /etc/fish/conf.d/bin.fish
# set -gx PATH $PATH ~/bin

# OPAM configuration
. ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true

set -gx EDITOR vim

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/user/.ghcup/bin # ghcup-env

function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

