#!/bin/bash
#
# Based on https://gohugo.io/hosting-and-deployment/hosting-on-github/ but
# modified not to use git submodule :-)
#

PUBLIC="$HOME/git/hub/jreisinger.github.io"
GITMSG="rebuilding public site `date`"

echo -e "\033[0;32mBulding web pages ...\033[0m"
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

echo -e "\033[0;32mAdding stuff to repo jreisinger.github.io ...\033[0m"
(cd $PUBLIC && git pull)
rsync public/* $PUBLIC/
(cd $PUBLIC && git add .)
git commit -m "$GITMSG"
git push origin master

echo -e "\033[0;32mAdding stuff to repo hugo (CWD) ...\033[0m"
git add .
git commit -m "$GITMSG"
git push
