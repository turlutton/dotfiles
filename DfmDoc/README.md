# Dotfiles Documentation

## Overview

## Dotfiles directories tree

`~/.dotfiles` contains:

* configuration files for various software:
    * `.shellrc.load` file for:
        * `bash` configuration (it's run in `.bashrc`, for compliance with futur use of other shell)
        * `fasd` initialization and sourcing
        * `fzf` and `fzf_browser` sourcing
    * `.shell_prompt.sh` "Generate a fast shell prompt with powerline symbols and airline colors"  https://github.com/edkolev/promptline.vim
    * `.tmux.conf` configuration file of `tmux`
    * `.vimrc` configuration file of `vim`
    * `.irssi/config` and `.irssi/default.theme` configuration files for `irssi`
    * `.fasd-init-bash` configuration file for `bash`
    * `.toprc` configuration file for `top`
* directories:
    * `.tmux/` containing plugins dir (handle as submodules) and the [tmuxline](https://github.com/edkolev/tmuxline.vim) configuration file (`.tmuxlineSnapshot`)
    * `.irssi/` containing the `scripts/` dir (TODO handle them as submodules)
    * `.vim/` containing the configuration `.vimrc` file
    * `.fasd/` used only on startup/installiation (handle as a submodule)
    *


## Workflow


