if not set -q XDG_CONFIG_HOME
    set -gx XDG_CONFIG_HOME "$HOME/.config"
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
starship init fish | source
