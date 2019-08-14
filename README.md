#### drd's dotfiles

Small dotfiles collection for quickly bootstrapping a fresh arch install.
To install all the needed packages run 'install-all.sh', i've included some comments in the install script (i suggest you to take a look at them).

To symlink all the needed config files use stow: i've divided stow-able config files in home ("~") files and root ("/") files.

* All root files are marked with the prefix "sys-", and need to be stowed with a different target. So, to install them all, just run `stow sys-*`
* Home files are marked with the prefix "home-" so, just as before, to stow them all run `stow home-*` 

If you find any conflicts, consider deleting the files or just adopting them. Remember that these dotfiles satisfy MY preferences.
