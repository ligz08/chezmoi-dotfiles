if test -d $HOME/.local/share/fnm
    fish_add_path $HOME/.local/share/fnm
    fnm env --shell fish | source
end
