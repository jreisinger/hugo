#!/bin/bash
#
# Based on https://gohugo.io/hosting-and-deployment/hosting-on-github/ but
# modified not to use git submodule :-)
#

PUBLIC="$HOME/git/hub/jreisinger.github.io"
GITMSG="rebuilding public site `date`"

function add_to_git() {
    local msg="$1"
    git add .
    git commit -m "$msg"
    git push origin master
}

echo -e "\033[0;32mBulding web pages ...\033[0m"
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

echo -e "\033[0;32mAdding stuff to repo jreisinger.github.io ...\033[0m"
(cd $PUBLIC && git pull)
rsync -az public/* $PUBLIC/
(cd $PUBLIC && add_to_git $GITMSG)

echo -e "\033[0;32mAdding stuff to repo hugo (CWD) ...\033[0m"
add_to_git $GITMSG
