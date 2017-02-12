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

# alias to use fasd
alias v='f -e vim -B viminfo' # quick opening files with vim and add viminfo backend
alias o='a -e xdg-open' # quick opening files with xdg-open

# alias for most used dir
##alias goCv='cd /home/turlutton/Documents/Justificatifs/Administratif/Cv'

# Weather in terminal as a function (not an alias)
weather () {
    wget -qO - http://www.wttr.in/$1 | less -R 
    # wget -qO - : quiet the wget infos, redirect to stdout
    # less -R: ANSI  "color" escape sequences are output in "raw" form
}
