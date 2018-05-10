# . ~/.env

if test (tty) = '/dev/tty2' -a -z "$TOP_FISH"
    setenv TOP_FISH '1'
    zsh -c '. ~/.profile && fish'; and exit
end

set -gx PATH $PATH ~/bin

if not ssh-add -l >/dev/null 2>&1; and test -e ~/.ssh/id_rsa
    ssh-add ~/.ssh/id_rsa
end

# OPAM configuration
. ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true
