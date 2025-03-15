#!/usr/bin/env bash


# ------------------------------------------------------------------------------
# Debugging
# ------------------------------------------------------------------------------

# Clear Chrome GPU cache

rm -rf ~/.config/google-chrome/Default/GPUCache/


# ------------------------------------------------------------------------------
# Git
# ------------------------------------------------------------------------------

# Delete ignored files

find FOLDER_NAME -name '*.git' -execdir sh -c 'cd {}/.. && git clean -f -d -X' \;

# Mirror clone repository
# https://docs.github.com/en/repositories/creating-and-managing-repositories/duplicating-a-repository#mirroring-a-repository-in-another-location

git clone --mirror [URL]
git remote add [NAME] [URL]
git fetch --prune origin
git push --mirror [NAME]
