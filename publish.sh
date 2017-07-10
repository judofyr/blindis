#!/bin/bash

set -e

hugo --quiet

DIR="public"
BRANCH="gh-pages"

# Stage all files in the directory
git add "$DIR"

# Write the sub-tree
TREE=$(git write-tree --prefix="$DIR")

# Commit the tree
COMMIT=$(git commit-tree "$TREE" -m 'update site' -p "$BRANCH")

# Update branch to the new commit
git branch --force "$BRANCH" "$COMMIT"

# Unstage files again
git reset HEAD --quiet -- "$DIR"

# And remove it
rm -rf "$DIR"
