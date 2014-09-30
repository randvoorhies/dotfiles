#!/bin/bash

cd $DOTFILESDIR &> /dev/null

# pull remote changes
git remote update &> /dev/null

# check if any can be merged
git status -uno | grep "is behind" &> /dev/null

if [ $? -eq 0 ]; # grep returned a result, so there ARE changes
then
  exit 1
fi
exit 0
