#!/bin/sh
set -e

git clone "$1" .add-licence-to-repository
cp LICENCE .add-licence-to-repository
(
  set -e
  cd .add-licence-to-repository
  git add LICENCE
  git commit . -m 'I added the ScraperWiki BSD licence to the repository'
  git push
)
rm -fR .add-licence-to-repository
