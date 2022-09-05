#!/bin/bash

# export PATH="$PATH":"$HOME/.pub-cache/bin"

CURRENT_VERSION="$(cider version | cut -d'+' -f2)"

cider version "$NEW_RELEASE+$((CURRENT_VERSION + 1))"

git config --global user.name "wfcd-bot-boi"
git config --global user.email "wfcd-bot-boi@users.noreply.github.com"

git add pubspec.yaml
git commit -a -m "chore(release): $NEW_RELEASE"

git pull --rebase
git push