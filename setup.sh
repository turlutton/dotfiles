#!/bin/bash

echo 'Running setup.sh..'

echo 'Importing submodules (tmux plugins + vim plugins)..'
# import all submodules
git submodule update --init --recursive

echo 'Building font information cached files..'
# build font information cached files
fc-cache -vf "$HOME/.fonts/"

# installing fasd - Command-line productivity booster, offers quick access to files and directories, inspired by autojump, z and v. - https://github.com/clvv/fasd
if [ -d "$HOME/.fasd" ]; then
    PREFIX=$HOME make -C "$HOME/.fasd/" install;
fi

# installing fzf - A command-line fuzzy finder written in Go - https://github.com/junegunn/fzf
if [ -d "$HOME/.fzf" ]; then
    echo "Installing fzf..."
    "$HOME/.fzf/install" --key-bindings --completion --no-update-rc ;
fi

#if [ -d "$HOME/.fzf_browser" ]; then
#    # installing fzf - A command-line fuzzy finder written in Go - https://github.com/junegunn/fzf
#    echo 'Now cloning and installing fzf at $HOME/.fzf (Enable key bindings and fuzzy completion, don'"'"'t update shell configuration files)..'
#    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
#    $HOME/.fzf/install --key-bindings --completion --no-update-rc
#if
