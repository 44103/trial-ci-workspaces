#!/bin/bash

CURR_BRANCH=$CIRCLE_BRANCH

IFS_BACKUP=$IFS
IFS=$'\n'

COMMIT_MSG=$(git log --pretty=format:"%s" -n 1 $CIRCLE_SHA1)
# COMMIT_MSG='Merge pull request #3 from xxxxx/feature/001-1'

if [ $(echo $COMMIT_MSG | egrep '^Merge pull request #[0-9]+ from') ]; then
  return 0
else
  return 1
fi
