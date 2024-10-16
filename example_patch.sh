#!/bin/bash

URL=$1

if [[ $URL =~ https://github.com/([^/]+)/([^/]+) ]]; then
    ORG=${BASH_REMATCH[1]}
    REPO=${BASH_REMATCH[2]}
else
    exit 1
fi

gh repo fork $ORG/$REPO
(
  cd $REPO
  git branch -m pyproject
  git reset --hard upstream/master
  ../ITKModuleTemplate/setup-py-to-pyproject-toml.py setup.py
  git add .
  git commit -m 'chore: Convert from setup.py to pyproject.toml'
  gh pr new -b 'cc @thewtex @jhlegarreta'
)
