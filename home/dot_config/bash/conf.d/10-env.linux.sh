# Linux configuration

export GPG_TTY=$(tty)

# Forward ssh to 1Pass socket
export SSH_AUTH_SOCK=~/.1password/agent.sock
