#################
# Configuration #
#################

# This configuration has some things that I consider useful for my daily work

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

## PROMPT
PS1="\e[36m\u\e[95m@\e[93m\h:\e[94m\W$ \e[39m"

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
