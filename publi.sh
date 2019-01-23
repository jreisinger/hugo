#!/bin/bash
#
# Based on https://gohugo.io/hosting-and-deployment/hosting-on-github/ but
# modified not to use git submodule :-)
#

PUBLIC="$HOME/git/hub/jreisinger.github.io"

echo -e "\033[0;32mBulding web pages...\033[0m"
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

echo -e "\033[0;32mAdding stuff to repo jreisinger.github.io ...\033[0m"
rsync public/* $PUBLIC/
cd $PUBLIC
git add .
msg="rebuilding public site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"
git push origin master

# Come back to the source
cd -

echo -e "\033[0;32mAdding stuff to repo hugo ...\033[0m"
git add .
git commit -m "$msg"
git push
