# drd's dotfiles

Small dotfiles collection for quickly bootstrapping a fresh arch install.
To install all the needed packages run `install-all.sh`, i've included some comments in the install script (i suggest you to take a look at them).

To symlink all the needed config files use stow: i've divided stow-able config files in home `(~)` files and root `(/)` files.

Home files are marked with the prefix `home-` so, to stow them all run (make sure to run stow from the repo dir)
  - `stow home-*` 

If you find any conflicts, consider deleting the already existing files or just adopting them (`stow --adopt <FILE-TO-ADOPT>`). Remember that these dotfiles satisfy MY preferences.
