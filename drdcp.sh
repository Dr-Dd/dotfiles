#!/bin/bash
#
# This script is an alternative to gnu stow for those sysfiles that cannot be symlinked, but need to be manually copied

copy_files_create_folders()
{
  target=$(pwd | grep -o "${trim}.*" | sed "s/${trim}//g")

  if [ "${target}" != "" ] ; then
      echo "[TAR] Target is ${target}"
      mkdir -p "${target}"
      echo "[DIR] Created directory ${target}"
      cp -i "${1}" "${target}"
      echo "[FILE] Copied ${1} to ${target}"
      echo "Completed copying files and creating folders in ${target}"
  fi
}

# For some reason, passing multiple arguments doesn't work as find only works for the first iteration

export -f copy_files_create_folders
export trim=$(printf $1 | sed "s/\///g")
echo "The trimmed expression is ${trim}"
find "${trim}" -type f -execdir bash -c 'copy_files_create_folders "$@"' bash {} \;
