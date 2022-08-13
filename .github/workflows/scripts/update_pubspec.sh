#!/bin/bash

# export PATH="$PATH":"$HOME/.pub-cache/bin"

let CURRENT_VERSION="$(cider version | cut -d'+' -f2)"
let VERSION_CODE=$((CURRENT_VERSION + 1))

cider version "$NEW_RELEASE+$VERSION_CODE"

git config --global user.name "${{ env.CI_COMMIT_AUTHOR }}"
git config --global user.email "noreply@users.github.com"

git pull --rebase

git add pubspec.yaml
git commit -a -m "chore(release): $NEW_RELEASE"

git push