#!/bin/sh
set -e

git clone "$1" .add-license-to-repository
cp LICENSE .add-license-to-repository
(
  set -e
  cd .add-license-to-repository
  git add LICENSE
  git commit . -m 'I added the ScraperWiki BSD license to the repository'
  git push
)
