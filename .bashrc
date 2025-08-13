#################
# Configuration #
#################

# This configuration has some things that I consider useful for my daily work

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)

export EDITOR=/usr/bin/vim

## SSH_ASKPASS -> Disable KDE popup window on Git repos, etc
unset GIT_ASKPASS
unset SSH_ASKPASS

## PATH
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

## COMPLETIONS
source /etc/bash_completion

## PROMPT
PS1="\[\e[0;36m\]\u\[\e[0;95m\]@\[\e[0;93m\]\h:\[\e[0;94m\]\W$\[\e[0;39m\] "

## TMUX
if [ -n "$PS1" ]; then
case $- in *i*)
    [ -z "$TMUX" ] && exec tmux
esac
fi

if [[ -n "$TMUX" ]]; then
  bind '"\e[1~":"\eOH"'
  bind '"\e[4~":"\eOF"'
fi

## ALIASES
test -s ~/.alias && . ~/.alias || true

## RUST
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

## NVM
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# Don't forget check version before run curl command
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# PNPM
# curl -fsSL https://get.pnpm.io/install.sh | sh -
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

