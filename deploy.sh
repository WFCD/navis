#!/bin/bash

CURRENT_VERSION="$(pubver get | cut -d'+' -f1)"

if [ "$CURRENT_VERSION" != "$1" ]
then
    let VERSION_CODE="$(pubver get | cut -d'+' -f2)" 
    let VERSION_CODE=++VERSION_CODE

    pubver set "$1+$VERSION_CODE"
fi