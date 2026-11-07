# Linux configuration

set -gx GPG_TTY (tty)

# Forward ssh to 1Pass socket
# set -gx SSH_AUTH_SOCK ~/.1password/agent.sock

# Forward ssh to ProtonPass socket
set -gx SSH_AUTH_SOCK ~/.ssh/proton-pass-ssh-agent.sock
