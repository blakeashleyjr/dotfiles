# Check if the current session is interactive
if status is-interactive
    # Configure Tide
    tide configure --auto --style=Lean --prompt_colors='True color' --show_time='24-hour format' --lean_prompt_height='One line' --prompt_spacing=Compact --icons='Few icons' --transient=no

    # Set up Fish PATH
    set -x PATH $PATH /usr/lib/ssh
    set -x SSH_ASKPASS /usr/lib/ssh/x11-ssh-askpass
    set fish_greeting

    # Custom aliases and environment variables
    alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    dotfiles config --local status.showUntrackedFiles no
    set -x GOPATH "~/go"
    set -x GPG_TTY (tty)

    # Initialize SSH Agent
    if not pgrep -x -u (id -u) ssh-agent > /dev/null
        eval (ssh-agent -c)
    end

    # Initialize GPG Agent
    if not pgrep -x -u (id -u) gpg-agent > /dev/null
        gpg-connect-agent /bye
    end

    # Start keychain for SSH and GPG keys (suppressing output)
    set ssh_key_path ~/.ssh/id_ed25519
    set gpg_key_id "8BC22723817BF8279DFD338E0CB911997C0160D9"  # Full fingerprint
    # set gpg_key_id "7C0160D9"  # Last 8 characters, try this if the full fingerprint doesn't work 
    keychain --quiet --eval --agents ssh,gpg $ssh_key_path $gpg_key_id > /dev/null


    # Additional configuration for VSCode on Wayland
    alias code='code --ozone-platform-hint=auto'
end
