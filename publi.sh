#!/bin/bash
#
# Based on https://gohugo.io/hosting-and-deployment/hosting-on-github/ but
# modified not to use git submodule :-)
#

PUBLIC="$HOME/git/hub/jreisinger.github.io"

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`
mv public/* $PUBLIC

# Go To Public folder
cd $PUBLIC
# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come back to the source
cd -

git add .
git commit -m "deploy new stuff"
git push
