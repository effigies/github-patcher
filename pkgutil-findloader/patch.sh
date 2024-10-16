#!/bin/bash
set -ex

URL=$1

if [[ $URL =~ https://github.com/([^/]+)/([^/]+) ]]; then
    ORG=${BASH_REMATCH[1]}
    REPO=${BASH_REMATCH[2]}
elif [[ $URL =~ ([^/]+)/([^/]+) ]]; then
    ORG=${BASH_REMATCH[1]}
    REPO=${BASH_REMATCH[2]}
else
    exit 1
fi

gh repo clone $ORG/$REPO -- --filter=blob:none --depth=1
(
  cd $REPO
  gh repo fork
  git branch -m rf/drop-pkgutil-find_loader
  git reset --hard upstream/HEAD
  sed -i'' \
      -e 's/pkgutil/importlib.util/g' \
      -e 's/find_loader/find_spec/' \
      $( git grep -l find_loader )

  git add .
  git commit -m 'rf(py314): Replace deprecated pkgutil.find_loader'
  git push -u origin rf/drop-pkgutil-find_loader
  gh pr new -R $ORG/$REPO -f -F ../body.md
)
