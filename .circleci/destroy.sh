#!/bin/sh

switch_tf_workspace() {
  terraform workspace new $1
  terraform workspace select $1
  # TODO: exec failed
  # circleci-agent step halt
}

init_tf_workspace() {
  terraform init -reconfigure -backend-config=dev.tfbackend
  terraform fmt -check
  terraform validate
  switch_tf_workspace $1
  terraform plan
}

cd infrastructure/service

echo $DEV_TFBACKEND | base64 -d >dev.tfbackend

IFS_BACKUP=$IFS
IFS=$'\n'

COMMIT_MSG=$(git log --pretty=format:"%s" -n 1 $1)
# COMMIT_MSG='Merge pull request #3 from xxxxx/feature/001-1'

if [ $(echo $COMMIT_MSG | egrep '^Merge pull request #[0-9]+ from') ]; then
  echo 'match merge pull request'
  MERGED_BRANCH=$(echo $COMMIT_MSG | sed -E 's/^Merge pull request #[0-9]+ from [^/]+\///g')
  echo $MERGED_BRANCH
  WORKSPACE=${MERGED_BRANCH/feature\//ft}
  init_tf_workspace $WORKSPACE
  terraform destroy -auto-approve
  terraform workspace select default
  terraform workspace delete $WORKSPACE
fi

IFS=$IFS_BACKUP
