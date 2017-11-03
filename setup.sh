#!/bin/bash
# this file is executed directly after 'dfm install'

wasErrorDuringRun=false
#SettingUp Dir and Files for Log
LogDir=$HOME/log/DotFiles
if [ ! -d "$LogDir" ]; then
    mkdir -p "$LogDir";
fi
FontLogFile=FontInformationCachedFilesBuild
SubmoduleLogFile=SubmoduleUpdate

#Starting
echo '# Running setup.sh .. setting up environnement'
echo "Note: \$HOME=$HOME, every symlinked .dir will be there, log directory in $LogDir"

# import all submodules
echo '# Importing submodules (tmux plugins + vim plugins)..'
{
    echo -n "-- .dotfiles/setup.sh run" &
    echo -n " - " &
    date
} >> "$LogDir/$SubmoduleLogFile"

git submodule update --init --recursive "$HOME/.dotfiles" >> "$LogDir/$SubmoduleLogFile" & echo "Logs in $LogDir/$SubmoduleLogFile"

echo '# Building font information cached files..'
# build font information cached files (following https://powerline.readthedocs.io/en/latest/installation/linux.html#font-installation )
if [ -d "$HOME/.fonts" ]; then
    {
        echo -n "-- .dotfiles/setup.sh run" &
        echo -n " - " &
        date
    } >> "$LogDir/$FontLogFile"

    if fc-cache -vf "$HOME/.fonts/" >> "$LogDir/$FontLogFile" ; then
        echo 'Font files updated, now you have to set it where you want to use it. For gnome-terminal I use "Fira Mono Medium for Powerline Medium 10" (manual set in ~/.gconf/apps/gnome-terminal/profiles/Default)';
    else
        echo >&2 "Failed to build font information cached files: log file in $LogDir/$FontLogFile"
        wasErrorDuringRun=true;
    fi;
else
    echo >&2 "No .fonts dir in $HOME"
    wasErrorDuringRun=true;
fi

# installing fasd - Command-line productivity booster, offers quick access to files and directories, inspired by autojump, z and v. - https://github.com/clvv/fasd
fasdDir=$HOME/.dotfiles/.fasdCopy
fasdBinDir=$HOME/bin
fasdManDir=$HOME/share/man/man1

wasFasdAlreadyInstalled=true
echo '# Installing fasd'
if [ -d "$fasdDir" ]; then
    # the fasd binary should already be in place, but just in case reinstalled it
    if ! command -v fasd >/dev/null; then
        echo >&2 "$HOME/bin -with fasd binary inside- should have been symlinked to .dotfiles/bin, there has been a problem!"
        install -d "$fasdBinDir"
        install -m 755 "$fasdDir/fasd" "$fasdBinDir"
        echo "fasd binary installed in $fasdBinDir"
        wasFasdAlreadyInstalled=false;
    fi

    # fasd manpage must be installed at the begining
    if [ ! -f "$fasdManDir/fasd.1" ]; then
        install -d "$HOME/share/man/man1"
        install -m 644 "$fasdDir/fasd.1" "$fasdManDir"
        echo "fasd manpage installed in $fasdManDir"
        wasFasdAlreadyInstalled=false;
    fi

    if [ "$wasFasdAlreadyInstalled" = true ]; then
        echo "Fasd already installed, skipping..."
    fi;
else
    echo >&2 "No $fasdDir directory, you've messed up my .dotfiles dir!"
    echo >&2 "Possible workaround: change the fasdDir variable in .dotfiles/setup.sh to point to that dir"
    wasErrorDuringRun=true;
fi

# installing fzf - A command-line fuzzy finder written in Go - https://github.com/junegunn/fzf
# note: fzf_browser is available via `fuzzy_broswer`
echo '# Installing fzf'
if [ -d "$HOME/.fzf" ]; then
    # fzf already check if it's already installed no need to check ourselves
    echo "Installing fzf..."
    "$HOME/.fzf/install" --key-bindings --completion --no-update-rc ;
else
    echo >&2 "No .fzf dir in $HOME"
    wasErrorDuringRun=true;
fi

# generate documentation for vim with vim-pathogen plugin
echo "# Generating documentation for vim"
if command -v vim >/dev/null; then
    echo 'Vim exists, now generating vim documentation threw  :Helptags  pathogen command'
    # source vimrc, run Helptags and quit
    vim -S "$HOME/.vim/vimrc" -c "Helptags" -c q;
else
    echo >&2 "vim does not exist, I can't generate vim documentation threw pathogen plugin. You should install a package like 'vim-gnome'"
    wasErrorDuringRun=true;
fi

# every file should end with an EOL
echo "" >> "$LogDir/$SubmoduleLogFile"
echo "" >> "$LogDir/$FontLogFile"

if [ "$wasErrorDuringRun" = true ]; then
    echo >&2 "It seems there has been some error(s), please read the preceding output and if necessary, logs in $LogDir";
    echo "\$wasErrorDuringRun=$wasErrorDuringRun";
else
    echo "All okay, enjoy!";
fi

