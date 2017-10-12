#!/bin/bash
# this file is executed directly after 'dfm install'

#SettingUp Dir and Files for Log
LogDir=/tmp/DotFiles
if ! [ -d "$LogDir" ]; then
    mkdir "$LogDir";
fi
FontLogFile=FontInformationCachedFilesBuild
if [ -f "$FontLogFile" ]; then
    echo "--" >> "$LogDir/$FontLogFile";
fi

echo '# Running setup.sh .. setting up environnement'

echo '# Importing submodules (tmux plugins + vim plugins)..'
# import all submodules
git submodule update --init --recursive "$HOME/.dotfiles"

echo '# Building font information cached files..'
# build font information cached files (following https://powerline.readthedocs.io/en/latest/installation/linux.html#font-installation )
if [ -d "$HOME/.fonts" ]; then
        if fc-cache -vf "$HOME/.fonts/" >> "$LogDir/$FontLogFile" ; then
        echo 'Font files updated, now you have to set it where you want to use it. For gnome-terminal I use "Fira Mono Medium for Powerline Medium 10" (manual set in ~/.gconf/apps/gnome-terminal/profiles/Default)';
    else
        echo >&2 "Failed to build font information cached files: log file in $LogDir/$FontLogFile";
    fi;
else
    echo >&2 'No .fonts dir in $HOME';
fi
# installing fasd - Command-line productivity booster, offers quick access to files and directories, inspired by autojump, z and v. - https://github.com/clvv/fasd
echo '# Installing fasd'
if [ -d "$HOME/.fasd" ]; then
    if command -v fasd >/dev/null; then
        echo >&2 'Fasd seems to already be installed.. skipping. If not, remove the .fasd directory in $HOME.';
    else
        PREFIX=$HOME make -C "$HOME/.fasd/" install;
    fi;
else
    echo >&2 'No .fasd dir in $HOME';
fi

# installing fzf - A command-line fuzzy finder written in Go - https://github.com/junegunn/fzf
echo '# Installing fzf'
if [ -d "$HOME/.fzf" ]; then
    echo "Installing fzf..."
    "$HOME/.fzf/install" --key-bindings --completion --no-update-rc ;
else
    echo >&2 'No .fzf dir in $HOME';
fi

# generate documentation for vim with vim-pathogen plugin
echo "# Generating documentation for vim"
if command -v vim >/dev/null; then
    echo 'Vim exists, now generating vim documentation threw  :Helptags  pathogen command'
    # source vimrc, run Helptags and quit
    vim -S "$HOME/.vim/vimrc" -c "Helptags" -c q;
else
    echo >&2 "vim does not exist, I can't generate vim documentation threw pathogen plugin. You should install a package like 'vim-gnome'";
fi


#if [ -d "$HOME/.fzf_browser" ]; then
#    # installing fzf - A command-line fuzzy finder written in Go - https://github.com/junegunn/fzf
#    echo 'Now cloning and installing fzf at $HOME/.fzf (Enable key bindings and fuzzy completion, don'"'"'t update shell configuration files)..'
#    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
#    $HOME/.fzf/install --key-bindings --completion --no-update-rc
#if
