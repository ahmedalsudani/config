set bindirs ~/bin \
            ~/nvbin \
            ~/.local/bin \
            ~/.cargo/bin \
            ~/.emacs.d/bin

for i in $bindirs
    if test -d "$i"
        set -gx PATH "$i" $PATH
    end
end
