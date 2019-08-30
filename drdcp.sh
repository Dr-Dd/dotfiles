#!/bin/bash
#
# This file is an alternative to gnu stow for those sysfiles that cannot be symlinked, but need to be manually copied 
#
# NOTES:
# Think of the system directories as an n-ary tree, as such, you'll find 2 types of file to handle: directories and NON-directories.
# What you should do is (in pseudocode):
# * Check for existing elements in the directory ()
#   > `find -maxdepth 1 -type d` for directories
#   > `find -maxdepth 1 -type f` for files
# * Copy all files to target ($2)
#   > `cp -i $FILE $2` -- PROBABLY NOT A GOOD IDEA
#   > it's probably better to grep the interested pwd
#     * `(pwd | grep -o "${1}.*") | sed "s/${1}//g"`
# * Restart the procedure for all directories
#   > `for dir in dirs                           `
#     `do                                        `
#     `  $FUNC -- how do i pass the func downard?`
#     `done                                      `
