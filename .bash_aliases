# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# Rm alias: confirmation de suppression avec -i, l'option -f supprime sans confirmation
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Évite les fautes de frappe
alias ks='ls'

alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
 
# Force tmux to assume the terminal supports 256 colours.
alias tmux='tmux -2'

# alias for most used dir
alias goCv='cd /home/turlutton/Documents/Justificatifs/Administratif/Cv'
alias goRapport='cd /home/turlutton/Documents/Stage/RapportDeStage'
alias goSoutenance='cd /home/turlutton/Documents/Stage/Soutenance'
