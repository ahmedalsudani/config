if test (tty) = '/dev/tty2'
    if test -z "$TOP_FISH"
        set -gx TOP_FISH '1'
        bash -c '. ~/.profile && fish'
        exit
    else 
        startx
        exit
    end
end
