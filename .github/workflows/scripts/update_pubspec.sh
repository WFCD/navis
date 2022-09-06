#!/bin/bash

export PATH="$PATH":"$HOME/.pub-cache/bin"

let VERSION_CODE="$(cider version | cut -d'+' -f2)" 
let VERSION_CODE=++VERSION_CODE

cider version "$1+$VERSION_CODE"