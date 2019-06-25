# . ~/.env

# You should set up path in /etc/fish/conf.d/bin.fish
# set -gx PATH $PATH ~/bin

# This should also be moved to /etc/
if not ssh-add -l >/dev/null 2>&1; and test -e ~/.ssh/id_rsa
    ssh-add ~/.ssh/id_rsa
end

# OPAM configuration
. ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true

set -gx EDITOR "ec -c"
