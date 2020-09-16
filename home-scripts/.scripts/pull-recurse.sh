#!/bin/sh

find . -exec bash -c 'pull_if_repo() {
  for f in *
  do
    if [ "$f" == ".git" ]
    then
      /usr/bin/git pull > /dev/null 2>&1
      echo "Trying to pull updates for `pwd` ..."
      break
    fi
  done
}
pull_if_repo "$@"' bash {} +

