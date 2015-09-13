# Dotfiles

## Overview

This repo is a personnal repo for tracking my dotfiles and over config files,
it's a fork of this skeleton/template repo: http://github.com/justone/dotfiles.
It contains a utility ([dfm](https://github.com/justone/dfm)) to help with managing and updating your dotfiles.

## Using this repo

First, fork this repo.

Then, add your dotfiles:

    $ git clone git@github.com:username/dotfiles.git .dotfiles
    $ cd .dotfiles
    $  # edit files
    $  # edit files
    $ git push origin master

Finally, to install your dotfiles onto a new system:

    $ cd $HOME
    $ git clone git@github.com:username/dotfiles.git .dotfiles
    $ ./.dotfiles/bin/dfm install # creates symlinks to install files

## Full documentation

For more information, check out the [wiki](http://github.com/justone/dotfiles/wiki)
and full doc [here](http://github.com/justone/dotfiles/wiki/Full-Documentation).
Other ref: a post on how to manage dotfiles with dfm at https://liquidat.wordpress.com/2013/05/24/howto-managing-dotfiles-with-dfm/ .

You can also run <tt>dfm --help</tt>.
