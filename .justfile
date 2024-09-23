default: install

alias f := format
alias fmt := format

format:
    just --fmt --unstable

install:
    #!/usr/bin/env bash
    set -euxo pipefail
    sudo cp --update=none yum.repos.d/rsteube-fury.repo /etc/yum.repos.d/rsteube-fury.repo
    distro=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
    if [ "$distro" = "fedora" ]; then
        variant=$(awk -F= '$1=="VARIANT_ID" { print $2 ;}' /etc/os-release)
        if [ "$variant" = "toolbx" ]; then
            sudo dnf --assumeyes install carapace-bin fish direnv
        elif [ "$variant" = "iot" ] || [[ "$variant" = *-atomic ]]; then
            sudo rpm-ostree install --idempotent carapace-bin fish direnv
            echo "Reboot and rerun to finish installation."
        fi
    fi
    mkdir --parents "{{ config_directory() }}/fish/conf.d"
    ln --force --relative --symbolic fish/conf.d/*.fish "{{ config_directory() }}/fish/conf.d/"
