if test -n "$DESKTOP_SESSION" -a -z "$container"
    for env_var in (gnome-keyring-daemon --start)
        set -x (echo $env_var | string split "=")
    end
end
