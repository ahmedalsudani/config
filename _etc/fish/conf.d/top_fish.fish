if test (tty) = '/dev/tty2'
    if test -z "$TOP_FISH"
        setenv TOP_FISH '1'
        zsh -c '. ~/.profile && fish'; and exit
    else
        ssh-agent startx
    end
end

