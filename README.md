# Dotfiles

## Overview

/!\ *still under construction* /!\

This is a personal repo for tracking my dotfiles and others config files (vim),
it's a fork of this skeleton/template repo: http://github.com/justone/dotfiles by [justone](https://github.com/justone)
It contains an utility ([dfm](https://github.com/justone/dfm)) to help with managing and updating your dotfiles.

##Use

Don't use it. [Dotfiles are not meant to be forked](http://www.anishathalye.com/2014/08/03/managing-your-dotfiles/).
You can take inspiration from my configuration, however i don't recommend it.
I haven't enough tested it, consider it unreliable.

## More details

For vim, i'm using [pathogen](https://github.com/tpope/vim-pathogen) as a submodule. When it exists i have put the vim plugin as a submodule too.
In my setup.sh, i have put a line to init and update my submodule on install with dfm.

## Full documentation

For more information, check out the [wiki](https://github.com/justone/dotfiles/wiki)
and [full doc](https://github.com/justone/dotfiles/wiki/Full-Documentation).
Other ref: a post on how to manage dotfiles with dfm at https://liquidat.wordpress.com/2013/05/24/howto-managing-dotfiles-with-dfm/ .

You can also run <tt>dfm --help</tt>.
