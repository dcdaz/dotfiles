#################
# Configuration #
#################

# This configuration has some things that I consider useful for my daily work

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
export EDITOR=/usr/bin/vim

## SSH_ASKPASS -> Disable KDE popup window on Git repos, etc
unset SSH_ASKPASS

## PROMPT
PS1="\[\e[0;36m\]\u\[\e[0;95m\]@\[\e[0;93m\]\h:\[\e[0;94m\]\W$\[\e[0;39m\] "

## MAVEN
export PATH=$PATH:/opt/maven/bin

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

# ALIASES
test -s ~/.alias && . ~/.alias || true
